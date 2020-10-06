import 'package:flutter/material.dart';
import 'package:training_app/constants.dart';

class DiaryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final Color cardColor;
  final _StyleSheet styleSheet = _StyleSheet();

  DiaryCard({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.description,
    @required this.cardColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 7),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: styleSheet._titleText, maxLines: 2, overflow: TextOverflow.ellipsis,),
          Text(subtitle, style: styleSheet._subtitleText, maxLines: 1, overflow: TextOverflow.ellipsis,),
          SizedBox(height: 12,),
          Text(description, style: styleSheet._descriptionText, maxLines: 3, overflow: TextOverflow.ellipsis,),
          Container(
            margin: EdgeInsets.only(top: 16,),
            height: 30,
            child: Material(
              borderRadius: BorderRadius.circular(15),
              clipBehavior: Clip.antiAlias,
              color: Colors.transparent,
              child: InkWell(
                splashColor: Color(0xFF89ADBD),
                highlightColor: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Text('SHOW MORE', style: styleSheet._buttonText,),
                ),
                onTap: () {},
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
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(0, 0, 0, 0.87),
  );
  final TextStyle _subtitleText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(0, 0, 0, 0.54),
  );
  final TextStyle _descriptionText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(0, 0, 0, 0.74),
  );
  final TextStyle _buttonText = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: Color.fromRGBO(0, 0, 0, 0.87),
  );
}
