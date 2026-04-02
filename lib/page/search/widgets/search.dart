import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class SearchOverlay extends StatelessWidget {
  final TextEditingController controller;

  const SearchOverlay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Tìm kiếm ở đây",
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  context.read<WeatherProvider>().searchCity(value);
                },
              ),
            ),

            /// 📋 LIST
            Expanded(
              child: Consumer<WeatherProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: provider.searchResults.length,
                    itemBuilder: (context, index) {
                      final item = provider.searchResults[index];
                      return ListTile(
                        leading: Container(
                          child: Icon(Icons.location_on_outlined),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                        ),

                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    controller.text = item.name;
                                  },
                                  icon: Icon(Icons.north_west),
                                ),
                              ],
                            ),
                            Divider(height: 1),
                          ],
                        ),
                          onTap: () async {
                            await context.read<WeatherProvider>().selectLocation(item);
                            Navigator.pop(context);
                            print(item.lat);
                            print(item.lon);
                            print(item.name);
                          }
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
