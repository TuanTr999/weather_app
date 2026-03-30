import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/page/detail/detail_widget/detail_body.dart';
import 'package:weather_app/providers/weather_provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1D6CF3), Color(0xFF19D2FE)],
        ),
      ),
      child: FutureBuilder(
        future: context.read<WeatherProvider>().getWeatherDetail(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!asyncSnapshot.hasData)
            return const Center(child: CircularProgressIndicator());
          List<WeatherDetail> listData =
              asyncSnapshot.data as List<WeatherDetail>;
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                children: [
                  Icon(CupertinoIcons.location),
                  SizedBox(width: 15),
                  AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '${context.read<WeatherProvider>().nameCity}',
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                IconButton(onPressed: (){
                  Navigator.push(context, route)
                }, icon: Icon(CupertinoIcons.search))
              ],
            ),
            body: DetailBody(listData: listData,),
          );
        },
      ),
    );
  }
}
