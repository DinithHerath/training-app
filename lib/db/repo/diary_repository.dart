import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:training_app/db/models/diary_data.dart';
import 'package:training_app/util/db_util.dart';

class DiaryRepository extends FirebaseRepository<DiaryEntry> {
  @override
  DiaryEntry fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final data = snapshot.data();
    if (data == null) return null;
    return DiaryEntry(
      ref: snapshot.reference,
      title: data[DiaryEntry.TITLE_FIELD],
      description: data[DiaryEntry.DESCRIPTION_FIELD],
      user: data[DiaryEntry.USER_FIELD].toString(),
      created: data[DiaryEntry.CREATED_FIELD],
    );
  }

  @override
  Map<String, dynamic> toMap(DiaryEntry diary) {
    return {
      DiaryEntry.TITLE_FIELD: diary.title,
      DiaryEntry.DESCRIPTION_FIELD: diary.description,
      DiaryEntry.USER_FIELD: diary.user,
      DiaryEntry.CREATED_FIELD: diary.created,
    };
  }

  @override
  Stream<List<DiaryEntry>> query({
    @required SpecificationI specification,
    String type,
    DocumentReference parent,
  }) {
    return super.query(
      specification: specification,
      type: DBUtil.DIARIES,
      parent: null,
    );
  }

  @override
  Future<DocumentReference> add({
    @required DiaryEntry item,
    String type,
    DocumentReference parent,
  }) {
    return super.add(
      item: item,
      type: DBUtil.DIARIES,
      parent: null,
    );
  }
}
