import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather/app/app.dart';

class CityContainer extends StatelessWidget {
  const CityContainer({super.key, required this.city, this.onTap});

  final String city;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            SvgPicture.asset(AppPart.icons.geo),
            const SizedBox(width: 8.0),
            Text(
              city,
              style: TextStyles.b2Medium,
            ),
          ],
        ),
        GestureDetector(
          onTap: onTap,
          child: const Icon(
            Icons.exit_to_app,
            size: 24,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
