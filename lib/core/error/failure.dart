import 'package:meta/meta.dart';

class Failure implements Exception {
  final String message;
  final int code;

  Failure({
    @required this.message,
    this.code,
  });
}
