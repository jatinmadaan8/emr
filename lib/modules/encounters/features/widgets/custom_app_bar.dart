import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/identification.dart';
import 'package:practiceinsights_emr_provider/modules/patients/features/patient_list/screens/patient_list.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  Size get preferredSize => Size.fromHeight(56.0);
  bool isactionButton = true;

  CustomAppBar(this.isactionButton);
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  TokenService _tokenService = TokenService();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          backgroundColor: Color.fromRGBO(45, 133, 185, 1),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Color.fromRGBO(246, 246, 246, 1),
              ),
          leading: Padding(
            padding: EdgeInsets.only(left: 12),
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(PatientsScreen.routeName);
              },
            ),
          ),
          title: widget.isactionButton
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://www.gstatic.com/webp/gallery/4.sm.jpg"),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(
                            IdentificationWidget.routeName);
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 7),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  _tokenService.selectedPatient.fullName,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'DOB : ' + _tokenService.selectedPatient.dob,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 40,
                        ),
                        Container(
                          width: 180,
                          margin: EdgeInsets.only(top: 7),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Patient ID : ' +
                                        _tokenService.selectedPatient.id
                                            .toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Gender : ' +
                                        _tokenService
                                            .selectedPatient.gender.name,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[],
                    ),
                  ],
                )
              : SizedBox.shrink(),
          actions: widget.isactionButton
              ? <Widget>[
                  Icon(Icons.brush),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.insert_drive_file),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.notifications),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: FlatButton(
                      textColor: Colors.white,
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            _tokenService.selectedPatient.fullName,
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Colors.white)),
                    ),
                  )
                ]
              : <Widget>[],
        )
      ],
    );
  }
}
