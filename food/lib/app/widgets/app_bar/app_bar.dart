import 'package:flutter/cupertino.dart';

import '../../utils/constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      color: AppColors().white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: const [
              SizedBox(height: 5),
              _GeoPointIcon(),
            ],
          ),
          const SizedBox(width: 8.5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _HeadCityText(),
              SizedBox(height: 4),
              _SubheadDateText()
            ],
          ),
          const _Expander(),
          const _UserIcon()
        ],
      ),
    );
  }
}

class _GeoPointIcon extends StatelessWidget {
  const _GeoPointIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/icons/geo_point.png',
    );
  }
}

class _HeadCityText extends StatelessWidget {
  const _HeadCityText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Санкт-Петербург',
      style: AppTextStyle().n518,
    );
  }
}

class _SubheadDateText extends StatelessWidget {
  const _SubheadDateText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '12 Августа 2023',
      style: AppTextStyle().n414c,
    );
  }
}

class _Expander extends StatelessWidget {
  const _Expander({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ColoredBox(
            color: AppColors().white
        )
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



