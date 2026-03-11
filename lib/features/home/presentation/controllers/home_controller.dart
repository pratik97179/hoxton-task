import 'package:flutter/foundation.dart';

import 'package:hoxton_task/core/logger/app_logger.dart';
import 'package:hoxton_task/core/network/api_exception.dart';
import 'package:hoxton_task/core/session/session_manager.dart';
import 'package:hoxton_task/features/home/data/datasources/home_remote_data_source.dart';
import 'package:hoxton_task/features/home/data/models/home_model.dart';

sealed class HomeState {
  const HomeState();
}

class HomeStateInitial extends HomeState {
  const HomeStateInitial();
}

class HomeStateLoading extends HomeState {
  const HomeStateLoading();
}

class HomeStateData extends HomeState {
  const HomeStateData(this.home);
  final HomeModel home;
}

class HomeStateError extends HomeState {
  const HomeStateError(this.message);
  final String message;
}

class HomeController extends ChangeNotifier {
  HomeController(this._remoteDataSource, this._sessionManager);

  final HomeRemoteDataSource _remoteDataSource;
  final SessionManager _sessionManager;

  HomeState _state = const HomeStateInitial();
  HomeState get state => _state;

  HomeModel? get home =>
      _state is HomeStateData ? (_state as HomeStateData).home : null;

  bool get isLoading => _state is HomeStateLoading;

  Future<void> loadHome() async {
    final session = _sessionManager.session;
    if (session == null) {
      appLogger.w('Home requested but no session is available');
      return;
    }

    _state = const HomeStateLoading();
    notifyListeners();

    try {
      final map = await _remoteDataSource.fetchHome(
        accessToken: session.accessToken,
      );
      final home = HomeModel.fromJson(map);
      appLogger.i('Fetched home data', data: map);
      _state = HomeStateData(home);
    } on ApiException catch (e) {
      appLogger.w(
        'Home API failed',
        error: e,
        data: e.data,
      );
      _state = HomeStateError(e.message);
    } catch (e, stackTrace) {
      appLogger.e(
        'Unexpected error fetching home',
        error: e,
        stackTrace: stackTrace,
      );
      _state = HomeStateError(e is Exception ? e.toString() : 'Something went wrong');
    }
    notifyListeners();
  }
}

