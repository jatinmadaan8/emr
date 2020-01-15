import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';

import 'network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker dataConnectionChecker;

  NetworkInfoImpl({@required this.dataConnectionChecker});

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;

  @override
  Observable get networkStateObserver =>
      dataConnectionChecker.onStatusChange as Observable<DataConnectionStatus>;
}
