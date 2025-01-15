import 'package:flutter/material.dart';

enum FlavorType {
  dev,
  stag,
  prod,
}

class FlavorValues {
  final String titleApp;

  const FlavorValues({
    this.titleApp = "Development App",
  });
}

class FlavorConfig {
  final FlavorType flavor;
  final MaterialColor color;
  final FlavorValues values;
  final String server;
  static FlavorConfig? _instance;

  FlavorConfig(
      {this.flavor = FlavorType.dev,
      this.color = Colors.orange,
      this.values = const FlavorValues(),
      this.server = ''}) {
    _instance = this;
  }

  static FlavorConfig get instance => _instance ?? FlavorConfig();
}
