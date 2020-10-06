import 'package:flutter/material.dart';
import 'package:training_app/constants.dart';
import 'package:training_app/views/home/components/background.dart';
import 'package:training_app/views/home/components/diarycard.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          ListView(
            padding: EdgeInsets.symmetric(vertical: 10),
            physics: BouncingScrollPhysics(),
            children: [
              DiaryCard(title: 'Test', subtitle: 'James', description: 'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the The remote computer’s IP address is assigned to the provider: “MTT Network Pvt Ltd 278, 4th Level, Aceccess towers, Union Place, descr: Colombo 02 MTT Network (Pvt) Ltd', cardColor: Constants.kCardBackground,),
              DiaryCard(title: 'Test', subtitle: 'Noah', description: 'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the The remote computer’s IP address is assigned to the provider: “MTT Network Pvt Ltd 278, 4th Level, Aceccess towers, Union Place, descr: Colombo 02 MTT Network (Pvt) Ltd', cardColor: Constants.kCardBackground,),
              DiaryCard(title: 'Test', subtitle: 'Benjamin', description: 'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the The remote computer’s IP address is assigned to the provider: “MTT Network Pvt Ltd 278, 4th Level, Aceccess towers, Union Place, descr: Colombo 02 MTT Network (Pvt) Ltd', cardColor: Constants.kCardBackground,),
              DiaryCard(title: 'Test', subtitle: 'James', description: 'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the The remote computer’s IP address is assigned to the provider: “MTT Network Pvt Ltd 278, 4th Level, Aceccess towers, Union Place, descr: Colombo 02 MTT Network (Pvt) Ltd', cardColor: Constants.kCardBackground,),
              DiaryCard(title: 'Test', subtitle: 'James', description: 'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the The remote computer’s IP address is assigned to the provider: “MTT Network Pvt Ltd 278, 4th Level, Aceccess towers, Union Place, descr: Colombo 02 MTT Network (Pvt) Ltd', cardColor: Constants.kCardBackground,),
            ]
          ),
        ],
      ),
    );
  }
}
