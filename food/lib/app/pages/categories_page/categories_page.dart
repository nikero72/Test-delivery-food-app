import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/app/utils/constants.dart';
import 'package:food/app/widgets/app_bar_categories/app_bar_categories.dart';
import 'package:food/app/widgets/tags/tags.dart';

import '../../../domain/entities/dishes/dishes.dart';
import '../../bloc/bloc.dart';
import '../../bloc/bloc_event.dart';
import '../../bloc/bloc_state.dart';
import '../../widgets/dish_detail_card/dish_detail_card.dart';
import '../cart_page/cart_page.dart';
import '../main_page/main_page.dart';

class CategoriesPage extends StatelessWidget {
  final String categoryName;
  const CategoriesPage({
    Key? key,
    required this.categoryName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarCategoriesWidget(categoryName: categoryName),
            const TagsWidget(),
            Container(
              padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
              height: MediaQuery
                    .of(context)
                    .size
                    .height - 197,
              width: MediaQuery.of(context).size.width,
              color: AppColors().white,
              child: const CategoriesBody(),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            if (index == 0) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ),
              );
              bloc.add(PageChangeEvent(index: index));
            } else {
              if (index == 2) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
                bloc.add(PageChangeEvent(index: index));
              }
            }
          },
          currentIndex: bloc.state.bottomNavBarIndex,
          iconSize: 24,
          backgroundColor: AppColors().white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColors().blue,
          unselectedItemColor: AppColors().lightGrey,
          selectedLabelStyle: AppTextStyle().n510,
          unselectedLabelStyle: AppTextStyle().n510,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/icons/home.png'),
                label: 'Главная'
            ),
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/icons/search.png'),
                label: 'Поиск'
            ),
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/icons/bag.png'),
                label: 'Корзина'
            ),
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/icons/profile.png'),
                label: 'Аккаунт'
            ),
          ]
      ),
    );
  }
}

class CategoriesBody extends StatelessWidget {
  const CategoriesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, BlocState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<AppBloc>(context);
          return dishesGridView(bloc.state.filteredDishes);
        }
    );
  }

  Widget dishesGridView(Dishes filteredDishes) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            mainAxisExtent: 165
        ),
        itemCount: filteredDishes.dishList.length,
        itemBuilder: (context, index) {
          return dishCard(filteredDishes, index, context);
        }
    );
  }


  Widget dishCard(Dishes filteredDishes, int index, BuildContext context) {
    final double side = (MediaQuery.of(context).size.width - (2 * 16) - (2 * 8)) / 3;
    return InkWell(
      onTap: () {showDish(context, filteredDishes, index);},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: side,
            height: side,
            padding: const EdgeInsets.all(11),
            margin: const EdgeInsets.only(bottom: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors().light,
                borderRadius: const BorderRadius.all(Radius.circular(10))
            ),
            child: Image.network(filteredDishes.dishList[index].imageUrl),
          ),
          Text(
              filteredDishes.dishList[index].name,
              style: AppTextStyle().n414
          )
        ],
      ),
    );
  }

  Future<void> showDish(BuildContext context, Dishes filteredDishes, int index) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return dishDetailsCard(context, filteredDishes, index);
        }
    );
  }
}

