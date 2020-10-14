import 'package:flutter/material.dart';
import 'package:training_app/constants.dart';

class DiaryCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String description;
  final DateTime created;
  final Color cardColor;

  DiaryCard({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.description,
    @required this.created,
    this.cardColor,
  }) : super(key: key);

  @override
  _DiaryCardState createState() => _DiaryCardState();
}

class _DiaryCardState extends State<DiaryCard> {
  final _StyleSheet styleSheet = _StyleSheet();
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.symmetric(
        vertical: 4,
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.cardColor ?? Constants.kCardBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: styleSheet._titleText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.subtitle,
            style: styleSheet._subtitleText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            widget.description,
            style: styleSheet._descriptionText,
            maxLines: showMore ? 6 : 3,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            margin: EdgeInsets.only(
              top: 16,
            ),
            height: 30,
            child: Material(
              borderRadius: BorderRadius.circular(15),
              clipBehavior: Clip.antiAlias,
              color: Colors.transparent,
              child: InkWell(
                splashColor: Color(0xFF89ADBD),
                splashFactory: InkRipple.splashFactory,
                highlightColor: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Text(
                    !showMore ? 'SHOW MORE' : 'SHOW LESS',
                    style: styleSheet._buttonText,
                  ),
                ),
                onTap: () => setState(() {
                  showMore = !showMore;
                }),
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
