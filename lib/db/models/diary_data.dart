import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/material.dart';
class DiaryEntry extends DBModel {
  static const DESCRIPTION_FIELD = 'description';
  static const TITLE_FIELD = 'title';
  static const USER_FIELD = 'user';
  static const CREATED_FIELD = 'created';

  String title;
  String user;
  String description;
  Timestamp created;

  DiaryEntry({
    @required DocumentReference ref,
    this.title,
    this.user,
    this.description,
    this.created,
  }) : super(ref: ref);
}
