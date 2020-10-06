import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_app/constants.dart';
import 'package:training_app/models/diaryData.dart';
import 'package:training_app/views/home/components/background.dart';
import 'package:training_app/views/home/components/diarycard.dart';
import 'package:training_app/views/home/components/diaryform.dart';

class DiaryHome extends StatefulWidget {
  @override
  _DiaryHomeState createState() => _DiaryHomeState();
}

class _DiaryHomeState extends State<DiaryHome> {
  final _StyleSheet styleSheet = _StyleSheet();
  List<DiaryCard> diaries = [];
  bool hide = false;

  Future<void> loadDiaries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0);
    for (int i = 0; i < counter; i++) {
      String diaryJson = prefs.getString(i.toString());
      DiaryEntry diary = DiaryEntry.fromJson(jsonDecode(diaryJson));
      diaries.add(DiaryCard(title: diary.title, subtitle: diary.subtitle, description: diary.description, cardColor: Constants.kCardBackground));
    }
    setState(() {});
  }

  Future<void> loadRecentDiary(int counter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String diaryJson = prefs.getString(counter.toString());
    DiaryEntry diary = DiaryEntry.fromJson(jsonDecode(diaryJson));
    setState(() {
      diaries.add(DiaryCard(title: diary.title, subtitle: diary.subtitle, description: diary.description, cardColor: Constants.kCardBackground));
    });
  }
  
  @override
  void initState() {
    loadDiaries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => setState(() {hide = true;}),
        child: Stack(
          children: [
            Background(),
            ListView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(height: 64,),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 24),
                  child: Text('Home', style: styleSheet._titleText,),
                ),
                DiaryForm(
                  onSubmit: (int counter) {
                    loadRecentDiary(counter);
                  },
                  hide: hide,
                  tappedText: () => setState(() {hide = false;}),
                ),
                for (DiaryCard card in diaries)
                  card,
              ]
            ),
          ],
        ),
      ),
    );
  }
}

class _StyleSheet {
  final TextStyle _titleText = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
}
