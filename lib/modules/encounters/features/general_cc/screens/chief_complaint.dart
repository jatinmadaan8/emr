import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/general_cc/chief_complaint.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/general_cc/block/chief_complaint.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/sub_menu.dart';
import '../../widgets/common_text.dart';
import '../../widgets/radio_button.dart';

class ChiefComplaintWidget extends StatefulWidget {
  static const routeName = '/chiefComplaint';

  @override
  _ChiefComplaintWidgetState createState() => _ChiefComplaintWidgetState();
}

class _ChiefComplaintWidgetState extends State<ChiefComplaintWidget> {
  var _form = GlobalKey<FormState>();

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
//    TODO fontFamily: 'Roboto'
  );
  final TextStyle _optionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: Color(0XFF737373),
//    TODO fontFamily: 'Roboto'
  );

  TextEditingController _chiefComplaintController = TextEditingController();
  TextEditingController _accompaniedByController = TextEditingController();

  var _methodOfArrivalDropDownValue;
  var _informantDropDownValue;

  int _reasonToVisitRadioValue = -1;

  final bloc = sl<ChiefComplaintBloc>();

  _reasonForVisitHandler(val) {
    setState(() {
      bloc.chiefComplaintData.reasonId = val;
      if (val == 0) {
        setState(() {
          _chiefComplaintController.text = "Patient annual/periodic visit";
        });
      } else if (val == 1) {
        setState(() {
          _chiefComplaintController.text = "Patient problem visit";
        });
      }
    });
  }

  @override
  void initState() {
    bloc.initialize();
    super.initState();
  }

  bool updated = false;

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    bloc.saveChiefComplaint();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidthPercent = deviceSize.width / 100;
    final deviceHeightPercent = deviceSize.height - 180;

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MainMenu(2),
            Row(
              children: <Widget>[
                Container(
                  width: deviceWidthPercent * 20,
                  height: deviceHeightPercent,
                  child: SubMenu(1, 2),
                ),
                Container(
                  width: deviceWidthPercent * 80,
                  height: deviceHeightPercent,
                  child: StreamBuilder<ChiefComplaint>(
                      stream: bloc.chiefComplaint,
                      builder: (context, snapshot) {
                        // if (!snapshot.hasData) {
                        //   return Center(child: CircularProgressIndicator());
                        // }
                        if (snapshot.hasData && !updated) {
                          _chiefComplaintController.text =
                              bloc.chiefComplaintData.complaint;
                          _accompaniedByController.text =
                              bloc.chiefComplaintData.accompaniedBy;
                          updated = true;
                        }
                        return Form(
                          key: _form,
                          child: ListView(
                            padding: EdgeInsets.all(16),
                            children: <Widget>[
                              _informantDropDown(),
                              TextFormField(
                                style: _optionTextStyle,
                                decoration: InputDecoration(
                                  labelText: 'Accompanied By',
                                  contentPadding:
                                      EdgeInsets.only(top: 8, bottom: 4),
                                ),
                                controller: _accompaniedByController,
                                onChanged: (val) =>
                                    bloc.chiefComplaintData.accompaniedBy = val,
                              ),
                              SizedBox(height: 8),
                              _methodOfArrivalDropDown(),
                              SizedBox(height: 8),
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    CommonText('Reason For Visit:', false),
                                    SizedBox(height: 4),
                                    StreamBuilder<List<GenricDropDown>>(
                                        stream:
                                            bloc.officeVisitReasonObservable,
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Text("No data");
                                          }
                                          return Container(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: snapshot.data
                                                  ?.map((answer) =>
                                                      RadioButtonCommon(
                                                          _reasonForVisitHandler,
                                                          bloc.chiefComplaintData
                                                              .reasonId,
                                                          answer.name,
                                                          answer.id))
                                                  ?.toList(),
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                              MaterialButton(
                                onPressed: () => print('Pressed Import'),
                                child: Text(
                                  'Import >',
                                  style:
                                      _textStyle.copyWith(color: Colors.white),
                                ),
                                color: Color(0XFF048ABF),
                              ),
                              TextFormField(
                                  controller: _chiefComplaintController,
                                  onChanged: (val) =>
                                      bloc.chiefComplaintData.complaint = val,
                                  style: _optionTextStyle,
                                  decoration: InputDecoration(
                                    labelText: 'Chief Complaint 8',
                                    contentPadding:
                                        EdgeInsets.only(top: 8, bottom: 4),
                                  ),
                                  minLines: 2,
                                  maxLines: 2,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Chief Complaint';
                                    }
                                    return null;
                                  }),
                              SizedBox(height: 8),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: MaterialButton(
                                      onPressed: _saveForm,
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
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      color: Color(0XFF048ABF),
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
      ),
    );
  }

  Widget _informantDropDown() {
    return StreamBuilder<List<GenricDropDown>>(
        stream: bloc.informantListObservable,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("No data");
          }
          return DropdownButton<int>(
            hint: Text('Informant'),
            isExpanded: true,
            iconSize: 24,
            style: _textStyle,
            underline: Container(
              color: Colors.black54,
              height: 1,
            ),
            value: bloc.chiefComplaintData.informantId,
            onChanged: (int newValue) {
              setState(() {
                bloc.chiefComplaintData.informantId = newValue;
              });
            },
            items: snapshot.data
                ?.map<DropdownMenuItem<int>>((GenricDropDown answer) {
              return DropdownMenuItem<int>(
                value: answer.id,
                child: Text(answer.name, style: _optionTextStyle),
              );
            })?.toList(),
          );
        });
  }

  Widget _methodOfArrivalDropDown() {
    return StreamBuilder<List<GenricDropDown>>(
        stream: bloc.methodOfArrivalListObservable,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("No data");
          }
          return DropdownButton<int>(
            hint: Text('MethodOfArrival'),
            isExpanded: true,
            iconSize: 24,
            style: _textStyle,
            underline: Container(
              color: Colors.black54,
              height: 1,
            ),
            items: snapshot.data
                ?.map<DropdownMenuItem<int>>((GenricDropDown answer) {
              return DropdownMenuItem<int>(
                value: answer.id,
                child: Text(answer.name, style: _optionTextStyle),
              );
            })?.toList(),
            value: bloc.chiefComplaintData.methodOfArrivalId,
            onChanged: (int newValue) {
              setState(() {
                bloc.chiefComplaintData.methodOfArrivalId = newValue;
              });
            },
          );
        });
  }
}
