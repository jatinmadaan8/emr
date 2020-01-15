import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/app_drawer.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/common_text.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/custom_app_bar.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/main_menu.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/sub_menu.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/insurance.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/Information/providers/information_questions.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/blocs/insurance_bloc.dart';
//import 'package:practiceinsights_emr_provider/modules/information/features/blocs/patient_information_bloc.dart';
import 'package:provider/provider.dart';

//import '../../../encounters/features/bio_psycho/models/group.dart';
//import '../providers/information_questions.dart';

class GuarantorInformationWidget extends StatefulWidget {
  static const routeName = '/guarantorInformation';
  @override
  _GuarantorInformationWidgetState createState() => _GuarantorInformationWidgetState();
}

class _GuarantorInformationWidgetState extends State<GuarantorInformationWidget> {
  var _formKey = GlobalKey<FormState>();

  bool _relationshipLoaded = false,
      _genderLoaded = false,
      _stateLoaded = false,
      _prefferedContactLoaded = false,
      _updated = false;

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
  );
  final TextStyle _optionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: Color(0XFF737373),
  );

  int _relOfGuarantorSelectValue = 0;
  int _sexSelectValue = 0;
  int _stateSelectValue = 0;
  int _prefferedContactSelectValue = 0;

  _relOfGuarantorSelectValueHandler(val) {
    setState(() {
      _relOfGuarantorSelectValue = val;
    });
  }

  _sexSelectValueHandler(val) {
    setState(() {
      _sexSelectValue = val;
    });
  }

  _stateSelectValueHandler(val) {
    setState(() {
      _stateSelectValue = val;
    });
  }

  _prefferedContactSelectValueHandler(val) {
    setState(() {
      _prefferedContactSelectValue = val;
    });
  }

  TextEditingController 
      _firstnameController,
      _lastnameController,
      _dobController,
      _address1Controller,
      _address2Controller,
      _cityController,
      _zipController,
      _homephoneController,
      _cellphoneController,
      _workphoneController;

  
  final bloc = sl<InsuranceBloc>();

  @override
  void initState() {
    _firstnameController = TextEditingController();
    _lastnameController = TextEditingController();
    _dobController = TextEditingController();
    _address1Controller = TextEditingController();
    _address2Controller = TextEditingController();
    _cityController = TextEditingController();
    _zipController = TextEditingController();
    _homephoneController = TextEditingController();
    _cellphoneController = TextEditingController();
    _workphoneController = TextEditingController();

    init();

    super.initState();
  }

  init() async {
    Future.wait(<Future>[
      bloc.getRelationship(),
      bloc.getGender(),
      bloc.getStates(),
      bloc.getPrefferedContact(),
    ]);

    bloc.initialize();
  }

  InsuranceModel _insurance;

  DateTime _dob;

  void _updateInsurance(List<InsuranceModel> insurance) {
    setState(() {
      _insurance = insurance[0];

      _relOfGuarantorSelectValue = _insurance.girelOfGuarantorCodeId;
      _sexSelectValue = _insurance.gigenderCodeId;
      _stateSelectValue = _insurance.gistatesCodeId;
      _prefferedContactSelectValue = _insurance.giprefferedContactCodeId;

      if (_insurance.dob != null) {
        _dob = _getDate(_insurance.dob);
        _dobController.text = _getString(_dob);
      }

      _firstnameController.text = _insurance.gifirstName ?? "";
      _lastnameController.text = _insurance.gilastName ?? "";
      _address1Controller.text = _insurance.giaddress1 ?? "";
      _address2Controller.text = _insurance.giaddress2 ?? "";
      _cityController.text = _insurance.gicity ?? "";
      _zipController.text = _insurance.gizip ?? "";
      _homephoneController.text = _insurance.gihomePhone ?? "";
      _cellphoneController.text = _insurance.gicellPhone ?? "";
      _workphoneController.text = _insurance.giworkPhone ?? "";

      _updated = true;
    });
  }

  String _getString(DateTime d) => "${d.month}/${d.day}/${d.year}";

  DateTime _getDate(String s) {
    var dArr = s.split("-");

    return DateTime(int.parse(dArr[0]), int.parse(dArr[1]),
        int.parse(dArr[2].substring(0, 2)));
  }

  List<dynamic> _relationshipSelectValues = [],
                    _genderSelectValues= [],
                    _stateSelectValues = [],
                    _prefferedContactSelectValues = [];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidthPercent = deviceSize.width / 100;
    final deviceHeightPercent = deviceSize.height - 180;

    final _informations = Provider.of<InformationQuestions>(context);

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          MainMenu(5),
          Row(
            children: <Widget>[
              Container(
                width: deviceWidthPercent * 20,
                height: deviceHeightPercent,
                child: SubMenu(3, 5),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: StreamBuilder(
                  stream: bloc.insuranceObservable,
                  builder: (context, snapshot) {
                      if (snapshot.hasData && !_updated) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _updateInsurance(snapshot.data);
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
                      CommonText('Guarantor Information', false),
                      SizedBox(height: 12,),
                      Text(
                        'Rel of Guarantor',
                        style: _optionTextStyle,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: StreamBuilder(
                              stream: bloc.relationship,
                              builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                                  if (snapshot.hasData && !_relationshipLoaded) {
                                    _relationshipSelectValues = snapshot.data;

                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      setState(() {
                                        _relationshipLoaded = true;
                                      });
                                    });
                                  }
                                return DropdownButton<int>(
                                  isDense: true,
                                  isExpanded: true,
                                  iconSize: 24,
                                  // style: _textStyle,
                                  underline: Container(
                                    color: Colors.black54,
                                    height: 1,
                                  ),
                                  value: _relOfGuarantorSelectValue,
                                  onChanged: _relOfGuarantorSelectValueHandler,
                                  items: _informations.relOfGuarantorSelectValues
                                      .map<DropdownMenuItem<int>>((answer) {
                                    return DropdownMenuItem<int>(
                                      value: answer.index,
                                      child: Text(answer.text),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TextFormField(
                                style: _optionTextStyle,
                                controller: _firstnameController,
                                decoration: InputDecoration(
                                  labelText: 'First Name *',
                                  contentPadding: EdgeInsets.only(top: 0, bottom: 4),
                                ),
                                onChanged: (t) => setState(
                                  () => _firstnameController.text = t[0]
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              style: _optionTextStyle,
                              controller: _lastnameController,
                              decoration: InputDecoration(
                                labelText: 'Last Name *',
                                contentPadding: EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                            style: _optionTextStyle,
                            controller: _dobController,
                            decoration: InputDecoration(
                              labelText: 'DOB',
                              contentPadding:
                                  EdgeInsets.only(top: 0, bottom: 0),
                              suffix: GestureDetector(
                                onTap: () async {
                                  final DateTime picked =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1990, 8),
                                    lastDate: DateTime(2101),
                                  );
                                  if (picked != null)
                                    setState(() {
                                      _dobController.text =
                                          '${picked.day}/${picked.month}/${picked.year}';
                                      print(_dobController.text);
                                    });
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Sex',
                        style: _optionTextStyle,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: StreamBuilder(
                              stream: bloc.gender,
                              builder: (BuildContext context,
                                    AsyncSnapshot<List<GenderNavigation>> snapshot) {
                                  if (snapshot.hasData && !_genderLoaded) {
                                    _genderSelectValues = snapshot.data
                                        .map((d) => GenderNavigation(d.id, d.name,d.code))
                                        .toList();

                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      setState(() {
                                        _genderLoaded = true;
                                      });
                                    });
                                  }
                                return DropdownButton<int>(
                                  isDense: true,
                                  isExpanded: true,
                                  iconSize: 24,
                                  // style: _textStyle,
                                  underline: Container(
                                    color: Colors.black54,
                                    height: 1,
                                  ),
                                  value: _sexSelectValue,
                                  onChanged: _sexSelectValueHandler,
                                  items: _informations.genderSelectValues
                                      .map<DropdownMenuItem<int>>((answer) {
                                    return DropdownMenuItem<int>(
                                      value: answer.index,
                                      child: Text(answer.text),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TextFormField(
                                style: _optionTextStyle,
                                controller: _address1Controller,
                                decoration: InputDecoration(
                                  labelText: 'Address 1',
                                  contentPadding: EdgeInsets.only(top: 0, bottom: 4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              style: _optionTextStyle,
                              controller: _address2Controller,
                              decoration: InputDecoration(
                                labelText: 'Address 2',
                                contentPadding: EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              style: _optionTextStyle,
                              controller: _cityController,
                              decoration: InputDecoration(
                                labelText: 'City',
                                contentPadding: EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'State',
                        style: _optionTextStyle,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: StreamBuilder(
                              stream: bloc.states,
                              builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                                  if (snapshot.hasData && !_stateLoaded) {
                                    _stateSelectValues = snapshot.data;

                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      setState(() {
                                        _stateLoaded = true;
                                      });
                                    });
                                  }
                                return DropdownButton<int>(
                                  isDense: true,
                                  isExpanded: true,
                                  iconSize: 24,
                                  // style: _textStyle,
                                  underline: Container(
                                    color: Colors.black54,
                                    height: 1,
                                  ),
                                  value: _stateSelectValue,
                                  onChanged: _stateSelectValueHandler,
                                  items: _informations.stateSelectValues
                                      .map<DropdownMenuItem<int>>((answer) {
                                    return DropdownMenuItem<int>(
                                      value: answer.index,
                                      child: Text(answer.text),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TextFormField(
                                style: _optionTextStyle,
                                controller: _zipController,
                                decoration: InputDecoration(
                                  labelText: 'Zip *',
                                  contentPadding: EdgeInsets.only(top: 0, bottom: 4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Preffered Contact',
                        style: _optionTextStyle,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: StreamBuilder(
                              stream: bloc.preferredContact,
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<PrefferedContactNavigation>> snapshot) {
                                if (snapshot.hasData && !_prefferedContactLoaded) {
                                  _prefferedContactSelectValues = snapshot.data
                                      .map((d) => PrefferedContactNavigation(d.dataValue ,d.displayTest))
                                      .toList();

                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    setState(() {
                                      _prefferedContactLoaded = true;
                                    });
                                  });
                                }
                                return DropdownButton<int>(
                                  isDense: true,
                                  isExpanded: true,
                                  iconSize: 24,
                                  // style: _textStyle,
                                  underline: Container(
                                    color: Colors.black54,
                                    height: 1,
                                  ),
                                  value: _prefferedContactSelectValue,
                                  onChanged: _prefferedContactSelectValueHandler,
                                  items: _informations.preferredPhonesSelectValues
                                      .map<DropdownMenuItem<int>>((answer) {
                                    return DropdownMenuItem<int>(
                                      value: answer.index,
                                      child: Text(answer.text),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TextFormField(
                                style: _optionTextStyle,
                                controller: _homephoneController,
                                decoration: InputDecoration(
                                  labelText: 'Home Phone',
                                  contentPadding: EdgeInsets.only(top: 0, bottom: 4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              style: _optionTextStyle,
                              controller: _cellphoneController,
                              decoration: InputDecoration(
                                labelText: 'Cell Phone',
                                contentPadding: EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              style: _optionTextStyle,
                              controller: _workphoneController,
                              decoration: InputDecoration(
                                labelText: 'Work Phone',
                                contentPadding: EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}