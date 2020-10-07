import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_app/constants.dart';
import 'package:training_app/models/diaryData.dart';

class DiaryForm extends StatefulWidget {
  final Function(int) onSubmit;
  final VoidCallback tappedText;
  final bool hide;

  DiaryForm({@required this.onSubmit, @required this.hide, @required this.tappedText});

  @override
  _DiaryFormState createState() => _DiaryFormState();
}

class _DiaryFormState extends State<DiaryForm> {
  final _StyleSheet styleSheet = _StyleSheet();
  final formKey = new GlobalKey<FormState>();
  final FocusNode focusTitle = new FocusNode();
  final FocusNode focusDescription = new FocusNode();

  String title = '';
  String subtitle = 'James';
  String description = '';

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void resetForm() {
    formKey.currentState.reset();
  }

  void saveEntry() async {
    String encodedString  = jsonEncode(DiaryEntry(title: title, subtitle: subtitle, description: description).toJson());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0);
    await prefs.setString(counter.toString(), encodedString);
    await prefs.setInt('counter', counter + 1);
    widget.onSubmit(counter); 
  }

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: Constants.kAnimationDuration,
            curve: Curves.ease,
            padding: EdgeInsets.all(4.0),
            width: widget.hide ? 140 : MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              color: Color.fromRGBO(153, 113, 225, 0.3),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 4, right: 4, bottom: 4),
              child: TextFormField(
                focusNode: focusTitle,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(0.0),
                  isDense: true,
                  hintText: 'Submit New',
                  hintStyle: styleSheet._titleText,
                ),
                validator: (value) => value.isEmpty ? 'Missing title.' : null,
                onSaved: (value) => title = value.trim(), 
                onTap: () {
                  widget.tappedText();
                },
                onFieldSubmitted: (value) {
                  focusTitle.unfocus();
                  FocusScope.of(context).requestFocus(focusDescription);
                },   
              ),
            ),
          ),
          AnimatedContainer(
            margin: EdgeInsets.symmetric(vertical: 8,),
            padding: EdgeInsets.all(4.0),
            width: MediaQuery.of(context).size.width - 20,
            height: widget.hide ? 0 : 150,
            decoration: BoxDecoration(
              color: Color.fromRGBO(153, 113, 225, 0.3),
              borderRadius: BorderRadius.circular(20)
            ),
            duration: Constants.kAnimationDuration,
            curve: Curves.ease,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 4, right: 4, bottom: 4),
              child: TextFormField(
                maxLines: 6,
                focusNode: focusDescription,
                textInputAction: TextInputAction.done,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(0.0),
                  isDense: true,
                  hintText: 'Enter Description',
                  hintStyle: styleSheet._descriptionText,
                ),
                validator: (value) => value.isEmpty ? 'Missing description.' : null,
                onSaved: (value) => description = value.trim(), 
                onFieldSubmitted: (value) => focusDescription.unfocus(),
              ),
            ),
          ),
          AnimatedContainer(
            duration: Constants.kAnimationDuration,
            curve: Curves.ease,
            margin: EdgeInsets.only(top: 4, bottom: 16),
            height: widget.hide ? 0 : 36,
            child: Material(
              borderRadius: BorderRadius.circular(15),
              clipBehavior: Clip.antiAlias,
              color: Color.fromRGBO(34, 113, 241, 0.933),
              child: InkWell(
                splashColor: Color.fromRGBO(0, 0, 0, 0.30),
                highlightColor: Colors.transparent,
                onTap: () {
                  if(validateAndSave()) {
                    saveEntry();
                    resetForm();
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Center(child: Text('SUBMIT', style: styleSheet._buttonText,)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _StyleSheet {
  final TextStyle _titleText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(0, 0, 0, 0.60),
  );
  final TextStyle _descriptionText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(0, 0, 0, 0.60),
  );
  final TextStyle _buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color.fromRGBO(0, 0, 0, 0.87),
  );
}
