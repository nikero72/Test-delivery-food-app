import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/app/bloc/bloc_event.dart';
import 'package:food/app/pages/cart_page/cart_page.dart';
import 'package:food/app/pages/categories_page/categories_page.dart';
import 'package:food/app/utils/constants.dart';
import 'package:food/app/widgets/app_bar/app_bar.dart';
import 'package:food/domain/entities/categories/categories.dart';

import '../../bloc/bloc.dart';
import '../../bloc/bloc_state.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppBarWidget(),
            Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 154,
                color: AppColors().white,
                child: BlocBuilder<AppBloc, BlocState>(
                    builder: (context, state) {
                      return const MainBody();
                    }
                )
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

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, BlocState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<AppBloc>(context);
          return categoriesListView(bloc.state.categories);
        }
    );
  }

  Widget categoriesListView(Categories categories) {
    return ListView.builder(
        itemCount: categories.categoryList.length,
        itemBuilder: (context, index) {
          return categoryCard(categories, index, context);
        }
    );
  }

  Widget categoryCard(Categories categories, int index, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CategoriesPage(categoryName: categories.categoryList[index].name),
          ),
        );
      },
      child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Stack(
            children: [
              Image.network(categories.categoryList[index].imageUrl),
              Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, top: 12),
                        child: Text(
                          categories.categoryList[index].name,
                          style: AppTextStyle().n520,
                        ),
                      )
                  ),
                  const Flexible(
                      flex: 1,
                      child: ColoredBox(
                          color: Colors.transparent
                      )
                  )
                ],
              )
            ],
          )
      ),
    );
  }
}


