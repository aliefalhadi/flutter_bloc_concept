import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concept/constants/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription connectivityStreamSubcription;

  InternetCubit({this.connectivity}) : super(InternetLoading()){
    monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSubcription = connectivity.onConnectivityChanged.listen((connectivityResult) {
    if(connectivityResult == ConnectivityResult.wifi){
      emitInternetConnected(ConnectionType.WiFi);
    }else if(connectivityResult == ConnectivityResult.mobile){
      emitInternetConnected(ConnectionType.Mobile);
    }else if(connectivityResult == ConnectivityResult.none){
      emitInternetDisconnected();
    }
  });
  }

  void emitInternetConnected(ConnectionType _connectionType) => emit(InternetConnected(connectionType: _connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubcription.cancel();
    return super.close();
  }
}
