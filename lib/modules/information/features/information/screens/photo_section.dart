import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/app_drawer.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/common_text.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/custom_app_bar.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/main_menu.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/sub_menu.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/patient_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/blocs/patient_information_bloc.dart';
import 'package:provider/provider.dart';

import '../providers/information_questions.dart';

class PhotoSectionWidget extends StatefulWidget {
  static const routeName = '/photoSection';

  @override
  _PhotoSectionWidgetState createState() => _PhotoSectionWidgetState();
}

class _PhotoSectionWidgetState extends State<PhotoSectionWidget> {
  var _formKey = GlobalKey<FormState>();

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
  );

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  final bloc = sl<PatientInformationBloc>();

  _onSavePressed() async {
    setState(() async {
      var x = await _image.readAsBytes();

      String imgBase64 = (base64Encode(x));

      print("\n\n\n\n");
      print(imgBase64);
      print("\n\n\n\n");

      bloc.uploadImage(imgBase64);
    });
  }

  bool _updated = false;
  PatientInformationModel _patientInfo;

  bool idVerified = false;
  String verifiedBy;
  String verifiedDate;

  void _updateOtherInformation(PatientInformationModel patientInfo) {
    setState(() {
      _patientInfo = patientInfo;

      idVerified = _patientInfo.idVerified ?? false;
      verifiedBy = _patientInfo.idVerifiedBy;
      verifiedDate = _patientInfo.idVerifiedDate;

      _updated = true;
    });
  }

  @override
  void initState() {
    bloc.initialize();
    bloc.getImage();
    super.initState();
  }

  Widget _imageWidget() {
    if (_image != null) {
      return Image.file(
        _image,
        fit: BoxFit.cover,
      );
    } else {
      return StreamBuilder<String>(
        stream: bloc.image,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Image.memory(
              base64Decode(snapshot.data),
              fit: BoxFit.cover,
            );
          } else
            return Container();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidthPercent = deviceSize.width / 100;
    final deviceHeightPercent = deviceSize.height - 180;

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          MainMenu(1, demographics: true),
          Row(
            children: <Widget>[
              Container(
                width: deviceWidthPercent * 20,
                height: deviceHeightPercent,
                child: SubMenu(3, 1, demographics: true),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: StreamBuilder<PatientInformationModel>(
                    stream: bloc.patientInformationObservable,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && !_updated) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _updateOtherInformation(snapshot.data);
                        });
                      }

                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Form(
                        key: _formKey,
                        child: ListView(
                          padding: EdgeInsets.all(16),
                          children: <Widget>[
                            CommonText("Photo", false),
                            SizedBox(height: 12),

                            Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 400,
                                        maxHeight: 300,
                                      ),
                                      color: Colors.grey,
                                      child: _imageWidget(),
                                    ),
                                    SizedBox(height: 12),
                                    MaterialButton(
                                      onPressed: getImage,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(
                                            Icons.add_a_photo,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Add Photo',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      color: Color(0XFFDCDCDC),
                                      elevation: 2,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: 12),
                            Row(
                              children: <Widget>[],
                            ),

                            SizedBox(height: 8),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Checkbox(
                                  value: idVerified,
                                  onChanged: (val) {
                                    setState(() {
                                      idVerified = val;
                                    });
                                  },
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                Text('ID Verified'),
                              ],
                            ),
                            SizedBox(height: 12),

                            Row(
                              children: <Widget>[
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(16),
                                  width: 400,
                                  height: 100,
                                  child: (idVerified)
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            (verifiedBy != null)
                                                ? Text(
                                                    "Verified By : $verifiedBy")
                                                : Container(),
                                            (verifiedDate != null)
                                                ? Text("Date : " + verifiedDate)
                                                : Container(),
                                          ],
                                        )
                                      : Text('Not Verified'),
                                ),
                              ],
                            ),

                            // -------

                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: _onSavePressed,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.check,
                                          size: 24,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Save',
                                          style: _textStyle.copyWith(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    color: Color(0XFF048ABF),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () => print('Pressed Save'),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.close,
                                          size: 24,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Cancel',
                                          style: _textStyle.copyWith(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    color: Color(0XFFE15656),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
