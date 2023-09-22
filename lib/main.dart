import 'package:flutter/material.dart';
import 'package:sun_stickers/states/sticker_state.dart';

import 'ui/_ui.dart';
import 'ui_kit/_ui_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: StickerState().isLight,
      builder: (_, isLight, __){
        return MaterialApp(
          title: 'Sunny Stickers',
          theme: isLight?AppTheme.darkTheme:AppTheme.lightTheme,
          home: const HomeScreen(),
        );
      },
    );
  }
}
