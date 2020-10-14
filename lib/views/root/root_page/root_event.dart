import 'package:flutter/material.dart';

@immutable
abstract class RootEvent {}

class ErrorEvent extends RootEvent {
  final String error;

  ErrorEvent(this.error);
}

class AppInitialized extends RootEvent {}
