import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class AppBarCategoriesWidget extends StatelessWidget {
  final String categoryName;
  const AppBarCategoriesWidget({
    Key? key,
    required this.categoryName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      color: AppColors().white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _ArrowBackIcon(),
          _HeadText(categoryName: categoryName),
          const _UserIcon()
        ],
      ),
    );
  }
}

class _ArrowBackIcon extends StatelessWidget {
  const _ArrowBackIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Image.asset(
          'assets/images/icons/arrow_back.png',
        )
    );
  }
}

class _HeadText extends StatelessWidget {
  final String categoryName;
  const _HeadText({
    Key? key,
    required this.categoryName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      categoryName,
      style: AppTextStyle().n518,
    );
  }
}



class _UserIcon extends StatelessWidget {
  const _UserIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/icons/user.png',
      width: 44,
      height: 44,
    );
  }
}