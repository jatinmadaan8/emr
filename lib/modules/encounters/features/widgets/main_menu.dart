import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounter.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/standards_and_scales/screen/standards_and_scales.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/identification.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/insurance/patient_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/other_information/screens/legal.dart';

import '../bio_psycho/models/menuitem.dart';
import '../general_cc/screens/chief_complaint.dart';
import '../bio_psycho/screens/problem_check_list.dart';
import '../tuberculosis/screen/tuberculosis_widget.dart';
import '../health_pattern_assessment/screens/values_beliefs.dart';
import '../../../../modules/encounters/features/social_medical_psych_hx/screens/medical_history.dart';
import '../../../../modules/encounters/features/vitals/screens/vitals.dart';
import '../../../../modules/encounters/features/soa/screens/soa_note.dart';
import '../../../../modules/encounters/features/system_assessments/screens/neuro_sensory.dart';

class MainMenu extends StatefulWidget {
  final index;
  final bool demographics;

  MainMenu(@required this.index, {this.demographics = false});
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  // var _dropdownValue;

  List<MenuItem> _menuItems = [
    MenuItem('Bio Physio Form', ProblemCheckListScreen.routeName, true),
    MenuItem('General/CC', ChiefComplaintWidget.routeName, false),
    MenuItem('Tubericulosis', TuberculosisScreen.routeName, false),
    MenuItem('Vitals', VitalsScreen.routeName, false),
    MenuItem('Systems Assessment', NeuroSensoryScreen.routeName, false),
    MenuItem('Social/Medical/Psych Hx', MedicalHistoryScreen.routeName, false),
    MenuItem('Allergies/Meds', ProblemCheckListScreen.routeName, false),
    MenuItem(
        'Health Patterns Assessment', ValuesBeliefsWidget.routeName, false),
    MenuItem('Standards And Scales', StandardsAndScalesScreen.routeName, false),
    MenuItem('Plan Counseling', ProblemCheckListScreen.routeName, false),
    MenuItem('Audio & Video', ProblemCheckListScreen.routeName, false),
    MenuItem('SOA', SOANoteScreen.routeName, false),
  ];

  @override
  void initState() {
    if (this.widget.demographics != null && this.widget.demographics) {
      _menuItems = [
        MenuItem('Information', IdentificationWidget.routeName, true),
        MenuItem('Insurance', PatientInformationWidget.routeName, false),
        MenuItem('Other Information', LegalWidget.routeName, false),
        MenuItem('Care Team', LegalWidget.routeName, false),
      ];
    }
  }

  void _selectMenu(menu) {
    setState(() {
      _menuItems.forEach((item) {
        item.selected = false;
      });
      menu.selected = true;
    });
    // _menuItems[widget.index].selected = true;
    Navigator.of(context).pushReplacementNamed(menu.route);
  }

  TokenService _tokenService = TokenService();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidth = deviceSize.width;
    final blockSizeHorizontal = deviceWidth / 100;
    _menuItems.forEach((item) {
      item.selected = false;
    });
    _menuItems[widget.index - 1].selected = true;

    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: blockSizeHorizontal * 24,
                child: DropdownButton<int>(
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  items: _tokenService.encounters.map((Encounter location) {
                    return new DropdownMenuItem<int>(
                      child: new Text(
                          DateTime.parse(location.date.split('+')[0])
                              .toString()),
                      value: location.id,
                    );
                  }).toList(),
                  onChanged: (int newValue) {
                    setState(() {
                      _tokenService.selectedEncounterId = newValue;
                      Navigator.of(context).pushReplacementNamed(
                          ProblemCheckListScreen.routeName);
                    });
                  },
                  value: _tokenService.selectedEncounterId,
                ),
              ),
              Container(
                height: 50,
                width: blockSizeHorizontal * 74,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ..._menuItems.map((menu) {
                      var index = _menuItems.indexOf(menu);

                      return Container(
                        width: 150,
                        color: (index == _menuItems.length - 1)
                            ? Colors.white
                            : Colors.grey[300],
                        child: MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Text(
                            menu.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  menu.selected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          color: menu.selected
                              ? Theme.of(context).primaryColor
                              : Colors.grey[300],
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                          ),
                          onPressed: () {
                            _selectMenu(menu);
                          },
                        ),
                      );
                    }).toList()
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
