import 'package:flutter/material.dart';

class HomeDetail extends StatelessWidget {
  const HomeDetail({super.key, required this.wind, required this.humidity});

  final double wind;
  final int humidity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Image.asset('assets/images/icons/wind.png', width: 50, height: 50),
            Text(
              '${wind.toString()}Km/h',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        const SizedBox(width: 150),
        Column(
          children: [
            Image.asset('assets/images/icons/humidity.png', width: 50, height: 50,),
            Text(
              '${humidity.round().toString()}%',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
