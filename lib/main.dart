
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:practiceinsights_emr_provider/app/app.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart'
    as di;

void main() {
  di.initDI();
  _setupLogger();
  runApp(
    App(),
  );
}

void _setupLogger() {
  Logger.level = Level.verbose;
  Logger.addLogListener((event) {
    print('${event.level.toString()} : ${event.message}');
  });
}
