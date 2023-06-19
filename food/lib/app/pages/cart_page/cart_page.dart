import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/app/bloc/bloc_event.dart';
import 'package:food/app/pages/main_page/main_page.dart';
import 'package:food/app/utils/constants.dart';

import '../../bloc/bloc.dart';
import '../../bloc/bloc_state.dart';
import '../../widgets/app_bar/app_bar.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

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
                      return const CartBody();
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



class CartBody extends StatelessWidget {
  const CartBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, BlocState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<AppBloc>(context);
          return Column(
            children: [
              (bloc.state.dishesInCart.dishes.isNotEmpty)
                  ? const CartListView()
                  : Container(
                      height: MediaQuery.of(context).size.height - 235,
                      color: AppColors().white
                    ),
              const CartPayButton()
            ],
          );
        }
    );
  }
}

class CartListView extends StatelessWidget {
  const CartListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AppBloc>(context);
    return BlocBuilder<AppBloc, BlocState>(
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height - 235,
            color: AppColors().white,
            child: ListView.builder(
                itemCount: bloc.state.dishesInCart.dishes.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width - (2 * 16),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Row(
                      children: [
                        Container(
                          height: 62,
                          width: 62,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: AppColors().light,
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: Image.network(bloc.state.dishesInCart.dishes[index].imageUrl),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bloc.state.dishesInCart.dishes[index].name,
                              style: AppTextStyle().n414,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${bloc.state.dishesInCart.dishes[index].price} ₽ ',
                                  style: AppTextStyle().n414,
                                ),
                                Text(
                                  '· ${bloc.state.dishesInCart.dishes[index].weight}г',
                                  style: AppTextStyle().n414a,
                                )
                              ],
                            )
                          ],
                        ),
                        Expanded(
                            child: ColoredBox(
                              color: AppColors().white,
                            )
                        ),
                        Container(
                          height: 32,
                          width: 99,
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                              color: AppColors().light,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  bloc.add(MinusByCartEvent(index));
                                },
                                child: Image.asset('assets/images/icons/minus.png'),
                              ),
                              Text(
                                  '${bloc.state.dishesInCart.count[index]}',
                                  style: AppTextStyle().n514
                              ),
                              InkWell(
                                onTap: () {
                                  bloc.add(PlusByCartEvent(index));
                                },
                                child: Image.asset('assets/images/icons/plus.png'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
            ),
          );
        }
    );
  }
}

class CartPayButton extends StatelessWidget {
  const CartPayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AppBloc>(context);

    int amount() {
      int sum = 0;
      if (bloc.state.dishesInCart.dishes.isEmpty) {
        return sum;
      } else {
        for (var i = 0; i < bloc.state.dishesInCart.dishes.length; i++) {
          sum = sum + (bloc.state.dishesInCart.dishes[i].price * bloc.state.dishesInCart.count[i]);
        }
        return sum;
      }
    }

    return BlocBuilder<AppBloc, BlocState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            margin: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width - (2 * 16),
            decoration: BoxDecoration(
                color: AppColors().blue,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Text(
              'Оплатить ${amount()} ₽',
              textAlign: TextAlign.center,
              style: AppTextStyle().n516a,
            ),
          );
        }
    );
  }

}


