import 'package:rxdart/rxdart.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Observable get networkStateObserver;
}