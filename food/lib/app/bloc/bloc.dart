import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:food/app/bloc/bloc_event.dart';
import 'package:food/app/bloc/bloc_state.dart';
import 'package:food/domain/entities/categories/categories.dart';
import 'package:food/domain/entities/dishes_in_cart/dishes_in_cart.dart';

import '../../data/api/api_service/api_service.dart';
import '../../domain/entities/dishes/dishes.dart';



class AppBloc extends Bloc<BlocEvent, BlocState> {
  AppBloc() : super(BlocState(
      initialTags,
      initialDishes,
      initialCategories,
      filteredDishes,
      initialBottomNavBarIndex,
      initialCart
  )) {
    on<TagsChangeEvent>(_tagsChange);
    on<InitializeDishes>(_initializeDishes);
    on<InitializeCategories>(_initializeCategories);
    on<PageChangeEvent>(_pageChange);
    on<AddToCartEvent>(_addToCart);
    on<PlusByCartEvent>(_plusByCart);
    on<MinusByCartEvent>(_minusByCart);
  }

  _tagsChange(TagsChangeEvent event, Emitter<BlocState> emit) {
    Map<int, dynamic> tags = state.tags;
    tags[event.index]['isActive'] = !tags[event.index]['isActive'];

    List<String> activeTags = [];
    for (var i = 0; i < 4; i++) {
      if (tags[i]['isActive']) {
        activeTags.add(tags[i]['name']);
      }
    }

    Dishes filteredDishes = Dishes(<Dish>[]);
    for (Dish element in state.dishes.dishList) {
      if (activeTags.every((item) => element.tags.contains(item))) {
        filteredDishes.dishList.add(element);
      }
    }

    emit(BlocState(tags, state.dishes, state.categories, filteredDishes,
        state.bottomNavBarIndex, state.dishesInCart));
  }

  _initializeDishes(InitializeDishes event, Emitter<BlocState> emit) async {
    final apiService = ApiService(
        Dio(BaseOptions(contentType: "application/json"))
    );
    Dishes dishes = await apiService.getDishes();
    emit(BlocState(
        state.tags, dishes, state.categories, dishes, state.bottomNavBarIndex,
        state.dishesInCart));
  }

  _initializeCategories(InitializeCategories event,
      Emitter<BlocState> emit) async {
    final apiService = ApiService(
        Dio(BaseOptions(contentType: "application/json"))
    );
    Categories categories = await apiService.getCategories();
    emit(BlocState(state.tags, state.dishes, categories, state.filteredDishes,
        state.bottomNavBarIndex, state.dishesInCart));
  }

  _pageChange(PageChangeEvent event, Emitter<BlocState> emit) {
    emit(BlocState(
        state.tags, state.dishes, state.categories, state.filteredDishes,
        event.index, state.dishesInCart));
  }

  _addToCart(AddToCartEvent event, Emitter<BlocState> emit) {
    if (state.dishesInCart.dishes.isEmpty) {
      DishesInCart dishesInCart = DishesInCart(
          [state.dishes.dishList[event.index]], [1]);
      emit(BlocState(
          state.tags, state.dishes, state.categories, state.filteredDishes,
          state.bottomNavBarIndex, dishesInCart));
    } else {
      if (state.dishesInCart.dishes.contains(state.dishes.dishList[event.index])) {
        for (var i = 0; i < state.dishesInCart.dishes.length; i++) {
          if (state.dishesInCart.dishes[i].id ==
              state.dishes.dishList[event.index].id) {
            DishesInCart dishesInCart = state.dishesInCart;
            dishesInCart.count[i] = state.dishesInCart.count[i] + 1;
            emit(BlocState(
                state.tags, state.dishes, state.categories, state.filteredDishes,
                state.bottomNavBarIndex, dishesInCart));
          }
        }
      } else {
        DishesInCart dishesInCart = state.dishesInCart;
        dishesInCart.dishes.add(state.dishes.dishList[event.index]);
        dishesInCart.count.add(1);
      }
    }
  }

  _plusByCart(PlusByCartEvent event, Emitter<BlocState> emit) {
    DishesInCart dishesInCart = state.dishesInCart;
    dishesInCart.count[event.index] = dishesInCart.count[event.index] + 1;
    emit(BlocState(
        state.tags, state.dishes, state.categories, state.filteredDishes,
        state.bottomNavBarIndex, dishesInCart));
  }

  _minusByCart(MinusByCartEvent event, Emitter<BlocState> emit) {
    DishesInCart dishesInCart = state.dishesInCart;
    dishesInCart.count[event.index] = dishesInCart.count[event.index] - 1;
    if (dishesInCart.count[event.index] == 0) {
      dishesInCart.dishes.removeAt(event.index);
      dishesInCart.count.removeAt(event.index);
    }
    emit(BlocState(
        state.tags, state.dishes, state.categories, state.filteredDishes,
        state.bottomNavBarIndex, dishesInCart));
  }
}



Categories initialCategories = Categories([Category(0, 'name', 'imageUrl')]);
Dishes initialDishes = Dishes([Dish(0, 'name', 0, 0, 'description', 'imageUrl', [''])]);
Dishes filteredDishes = initialDishes;
int initialBottomNavBarIndex = 0;
DishesInCart initialCart = DishesInCart([], []);

Map<int, dynamic> initialTags = {
  0: {
    'name': 'Все меню',
    'isActive': true
  },
  1: {
    'name': 'Салаты',
    'isActive': false
  },
  2: {
    'name': 'С рисом',
    'isActive': false
  },
  3: {
    'name': 'С рыбой',
    'isActive': false
  },
  4: {
    'name': 'Роллы',
    'isActive': false
  },
};