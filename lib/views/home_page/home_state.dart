import 'package:flutter/material.dart';
import 'package:training_app/db/models/diary_data.dart';

@immutable
class HomeState {
  final String error;
  final List<DiaryEntry> diaries;
  final bool hide;

  HomeState( {
    @required this.diaries,
    @required this.error,
    @required this.hide,
  });

  static HomeState get initialState => HomeState(
        error: '',
        diaries: null,
        hide: true,
      );

  HomeState clone({
    String error,
    List<DiaryEntry> diaries,
    bool hide
  }) {
    return HomeState(
      error: error ?? this.error,
      diaries: diaries ?? this.diaries,
      hide: hide ?? this.hide
    );
  }
}
