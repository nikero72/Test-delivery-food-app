import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/app/bloc/bloc_event.dart';
import 'package:food/app/utils/constants.dart';

import '../../../domain/entities/dishes/dishes.dart';
import '../../bloc/bloc.dart';
import '../../bloc/bloc_state.dart';

Widget dishDetailsCard(BuildContext context, Dishes filteredDishes, int index) {
  return Dialog(
    insetPadding: const EdgeInsets.only(left: 16, right: 16),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _imageAndButtonsContainer(context, filteredDishes, index),
          const SizedBox(height: 8),
          _dishName(filteredDishes, index),
          const SizedBox(height: 8),
          _dishPriceAndWeight(filteredDishes, index),
          const SizedBox(height: 8),
          _dishDescription(filteredDishes, index),
          const SizedBox(height: 16),
          BlocBuilder<AppBloc, BlocState>(
              builder: (context, state) {
                return _addButton(context, filteredDishes, index);
              }
          )
        ],
      ),
    ),
  );


}

Widget _imageAndButtonsContainer(BuildContext context, Dishes filteredDishes, int index) {
  return Container(
    width: MediaQuery.of(context).size.width - (2 * 32),
    height: (MediaQuery.of(context).size.width - (2 * 32)) * (232 / 311),
    decoration: BoxDecoration(
        color: AppColors().light,
        borderRadius: BorderRadius.circular(10)
    ),
    child: Stack(
      children: [
        _dishImage(filteredDishes, index),
        _buttons(context)
      ],
    ),
  );
}

Widget _dishImage(Dishes filteredDishes, int index) {
  return Align(
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 14),
      child: Image.network(filteredDishes.dishList[index].imageUrl),
    ),
  );
}

Widget _buttons(BuildContext context) {
  return Align(
    alignment: Alignment.topRight,
    child: Padding(
      padding: const EdgeInsets.only(top: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _favoriteButton(),
          const SizedBox(width: 8),
          _closeButton(context),
        ],
      ),
    ),
  );
}

Widget _favoriteButton() {
  return InkWell(
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors().white,
          borderRadius: BorderRadius.circular(8)
      ),
      child: Image.asset('assets/images/icons/favorite.png'),
    ),
  );
}

Widget _closeButton(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pop();
    },
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors().white,
          borderRadius: BorderRadius.circular(8)
      ),
      child: Image.asset('assets/images/icons/close.png'),
    ),
  );
}

Widget _dishName(Dishes filteredDishes, int index) {
  return Align(
    alignment: Alignment.topLeft,
    child: Text(
      filteredDishes.dishList[index].name,
      style: AppTextStyle().n516,
    ),
  );
}

Widget _dishPriceAndWeight(Dishes filteredDishes, int index) {
  return Row(
    children: [
      Text(
        '${filteredDishes.dishList[index].price} ₽ ',
        style: AppTextStyle().n414,
      ),
      Text(
        '· ${filteredDishes.dishList[index].weight}г',
        style: AppTextStyle().n414a,
      )
    ],
  );
}

Widget _dishDescription(Dishes filteredDishes, int index) {
  return Text(
    filteredDishes.dishList[index].description,
    style: AppTextStyle().n414b,
  );
}

Widget _addButton(BuildContext context, Dishes filteredDishes, int index) {
  final bloc = BlocProvider.of<AppBloc>(context);
  return InkWell(
    onTap: () {
      bloc.add(AddToCartEvent(index));
    },
    child: Container(
      width: MediaQuery.of(context).size.width - (2 * 32),
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        color: AppColors().blue,
        borderRadius: BorderRadius.circular(10)
      ),
      alignment: Alignment.center,
      child: Text(
        'Добавить в корзину',
        style: AppTextStyle().n516a,
      ),
    ),
  );
}

