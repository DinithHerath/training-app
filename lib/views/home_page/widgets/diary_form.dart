import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_app/constants.dart';
import 'package:training_app/db/models/diary_data.dart';
import 'package:training_app/views/home_page/home_bloc.dart';
import 'package:training_app/views/home_page/home_event.dart';
import 'package:training_app/views/home_page/home_state.dart';

class DiaryForm extends StatefulWidget {
  @override
  _DiaryFormState createState() => _DiaryFormState();
}

class _DiaryFormState extends State<DiaryForm> {
  final _StyleSheet styleSheet = _StyleSheet();
  final formKey = new GlobalKey<FormState>();
  final FocusNode focusTitle = new FocusNode();
  final FocusNode focusDescription = new FocusNode();
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _descriptionController = new TextEditingController();

  String title = '';
  String user = 'James'; //user firebase to get the users
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

  void clearText(bool hide) {
    if (hide) {
      _titleController.clear();
      _descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => !identical(previous.hide, current.hide),
        builder: (context, state) {
          clearText(state.hide);
          return new Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: Constants.kAnimationDuration,
                  curve: Curves.ease,
                  padding: EdgeInsets.all(4.0),
                  width: state.hide ? 140 : MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(color: Color.fromRGBO(153, 113, 225, 0.3), borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4, right: 4, bottom: 4),
                    child: TextFormField(
                      focusNode: focusTitle,
                      controller: _titleController,
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
                      onTap: () => homeBloc.add(ShowInputEvent()),
                      onFieldSubmitted: (value) {
                        focusTitle.unfocus();
                        FocusScope.of(context).requestFocus(focusDescription);
                      },
                    ),
                  ),
                ),
                AnimatedContainer(
                  margin: EdgeInsets.symmetric(
                    vertical: state.hide ? 0 : 8,
                  ),
                  padding: EdgeInsets.all(4.0),
                  width: MediaQuery.of(context).size.width - 20,
                  height: state.hide ? 0 : 150,
                  decoration: BoxDecoration(color: Color.fromRGBO(153, 113, 225, 0.3), borderRadius: BorderRadius.circular(20)),
                  duration: Constants.kAnimationDuration,
                  curve: Curves.ease,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4, right: 4, bottom: 4),
                    child: TextFormField(
                      maxLines: 6,
                      focusNode: focusDescription,
                      controller: _descriptionController,
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
                  margin: EdgeInsets.only(top: 4, bottom: state.hide ? 0 : 2),
                  height: state.hide ? 0 : 36,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    animationDuration: Constants.kAnimationDuration,
                    clipBehavior: Clip.antiAlias,
                    elevation: 0,
                    color: Color.fromRGBO(34, 113, 241, 0.933),
                    splashColor: Color.fromRGBO(0, 0, 0, 0.30),
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      if (validateAndSave()) {
                        final diary = DiaryEntry(
                          ref: null,
                          title: title,
                          user: user,
                          description: description,
                          created: Timestamp.fromDate(DateTime.now()),
                        );
                        homeBloc.add(AddDiaryEvent(diary));
                        resetForm();
                        FocusScope.of(context).unfocus();
                        homeBloc.add(HideInputEvent());
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      child: Center(
                          child: Text(
                        'SUBMIT',
                        style: styleSheet._buttonText,
                      )),
                    ),
                  ),
                )
              ],
            ),
          );
        });
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
