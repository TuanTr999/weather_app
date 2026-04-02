import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/page/search/widgets/search.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/page/detail/detail_widget/detail_body.dart';
import 'package:weather_app/providers/weather_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool showSearch = false;
  TextEditingController controller = TextEditingController();

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
      child: Consumer<WeatherProvider>(
        builder: (context, provider, child) {
          if (provider.listData.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                children: [
                  const Icon(CupertinoIcons.location),
                  const SizedBox(width: 15),
                  Expanded(
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          provider.nameCity ?? '',
                          textStyle: const TextStyle(fontSize: 20),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SearchOverlay(controller: controller),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            body: DetailBody(listData: provider.listData),
          );
        },
      ),
    );
  }
}
