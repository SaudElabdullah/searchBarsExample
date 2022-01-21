import 'package:flutter/material.dart';
import 'package:search/search_bars/search_bar_with_animation.dart';
import 'package:search/utils/size_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter search bar examples',
              home: Scaffold(
                body: SearchBarWithAnimation(),
              ),
            );
          },
        );
      },
    );
  }
}
