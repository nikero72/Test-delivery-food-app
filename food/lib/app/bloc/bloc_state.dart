import '../../domain/entities/categories/categories.dart';
import '../../domain/entities/dishes/dishes.dart';
import '../../domain/entities/dishes_in_cart/dishes_in_cart.dart';

class BlocState {
  final Map<int, dynamic> tags;
  final Dishes dishes;
  final Categories categories;
  final Dishes filteredDishes;
  final int bottomNavBarIndex;
  final DishesInCart dishesInCart;

  BlocState(this.tags, this.dishes, this.categories, this.filteredDishes, this.bottomNavBarIndex, this.dishesInCart);

}