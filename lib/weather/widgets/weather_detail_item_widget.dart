import 'package:flutter/material.dart';

class WeatherDetailItemWidget extends StatelessWidget {
  const WeatherDetailItemWidget({
    super.key,
    required this.label,
    required this.icon,
    this.iconColor,
  });

  final String label;
  final IconData icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Icon(icon, color: iconColor),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}
