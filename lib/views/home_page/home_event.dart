import 'package:flutter/material.dart';
import 'package:training_app/db/models/diary_data.dart';

@immutable
abstract class HomeEvent {}

class ErrorEvent extends HomeEvent {
  final String error;

  ErrorEvent(this.error);
}

class RetrieveDiariesEvent extends HomeEvent {
  final List<DiaryEntry> diaries;

  RetrieveDiariesEvent(this.diaries);
}

class AddDiaryEvent extends HomeEvent {
  final DiaryEntry diary;

  AddDiaryEvent(this.diary);
}

class HideInputEvent extends HomeEvent{}

class ShowInputEvent extends HomeEvent{}
