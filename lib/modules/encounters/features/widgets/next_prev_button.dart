import 'package:flutter/material.dart';

class NextPreButton extends StatelessWidget {
  Function _skipClick;
  Function _previousClick;
  Function _nextClick;

  NextPreButton(@required this._skipClick, @required this._previousClick,
      @required this._nextClick);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      //color: Color.fromRGBO(228, 228, 228, 1),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: _skipClick,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text(
                  '< Previous',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                color: Color.fromRGBO(115, 115, 115, 1),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                onPressed: _previousClick,
              ),
              SizedBox(
                width: 5,
              ),
              MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text(
                  'Next >',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                onPressed: _nextClick,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
