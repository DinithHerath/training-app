import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:training_app/db/repo/diary_repository.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  static final log = Log("HomeBloc");
  final diaryRepo = DiaryRepository();

  StreamSubscription diarySubscription;

  HomeBloc(BuildContext context) : super(HomeState.initialState) {
    diarySubscription = diaryRepo
        .query(
      specification: ComplexSpecification([]),
    )
        .listen((diaries) {
      add(RetrieveDiariesEvent(diaries));
    });
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        log.e('Error: $error');
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;
      case RetrieveDiariesEvent:
        final diaries = (event as RetrieveDiariesEvent).diaries;
        yield state.clone(diaries: diaries);
        break;
      case AddDiaryEvent:
        final diary = (event as AddDiaryEvent).diary;
        diaryRepo.add(item: diary);
        break;
      case ShowInputEvent:
        yield state.clone(hide: false);
        break;
      case HideInputEvent:
        yield state.clone(hide: true);
        break;
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    log.e('$stacktrace');
    log.e('$error');
    _addErr(error);
    super.onError(error, stacktrace);
  }

  @override
  Future<void> close() async {
    await diarySubscription?.cancel();
    await super.close();
  }

  void _addErr(e) {
    if (e is StateError) {
      return;
    }
    try {
      add(ErrorEvent(
        (e is String) ? e : (e.message ?? "Something went wrong. Please try again !"),
      ));
    } catch (e) {
      add(ErrorEvent("Something went wrong. Please try again !"));
    }
  }
}
