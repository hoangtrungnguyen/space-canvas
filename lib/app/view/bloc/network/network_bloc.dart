import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'network_bloc.freezed.dart'; // This file will be generated
part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  NetworkBloc() : super(const NetworkState.initial()) {
    on<_Started>(_onStarted);
    on<_ConnectivityChanged>(_onConnectivityChanged);

    // Initial check
    add(const NetworkEvent.started());
  }

  void _onStarted(_Started event, Emitter<NetworkState> emit) async {
    // Listen to network changes
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) async {
      await _checkInternetConnection(results);
    });

    // Check initial status
    final initialConnectivityResult = await Connectivity().checkConnectivity();
    await _checkInternetConnection(initialConnectivityResult);
  }

  Future<void> _checkInternetConnection(
    List<ConnectivityResult> results,
  ) async {
    if (results.contains(ConnectivityResult.none)) {
      add(const NetworkEvent.connectivityChanged(isConnected: false));
    } else {
      // Perform a deeper check for actual internet access
      bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
      add(NetworkEvent.connectivityChanged(isConnected: hasInternet));
    }
  }

  void _onConnectivityChanged(
    _ConnectivityChanged event,
    Emitter<NetworkState> emit,
  ) {
    if (event.isConnected) {
      emit(const NetworkState.online());
    } else {
      emit(const NetworkState.offline());
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    // _internetStatusSubscription?.cancel(); // If you use this directly
    return super.close();
  }
}
