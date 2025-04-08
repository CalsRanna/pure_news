import 'package:flutter/material.dart';
import 'package:pure_news/dependency_injection/dependency_injection.dart';
import 'package:pure_news/route/route.dart';

void main() {
  DependencyInjection.ensureInitialized();
  runApp(const PureNewsApp());
}

class PureNewsApp extends StatelessWidget {
  const PureNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
    );
    return MaterialApp.router(
      routerConfig: pureNewsRouter.config(),
      title: 'Flutter Demo',
      theme: themeData,
    );
  }
}
