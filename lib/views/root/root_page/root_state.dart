import 'package:flutter/material.dart';

@immutable
class RootState {
  final String error;
  final bool init;

  RootState({
    @required this.error,
    @required this.init,
  });

  static RootState get initialState => RootState(
    init: false,
    error: '',
  );

  RootState clone({
    String error,
    bool init,
  }) {
    return RootState(
      error: error ?? this.error,
      init: init ?? this.init
    );
  }
}
