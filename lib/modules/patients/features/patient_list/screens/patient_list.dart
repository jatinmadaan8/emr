import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/custom_app_bar.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/models/patient.dart';
import 'package:practiceinsights_emr_provider/modules/patients/features/patient_list/blocs/patient_list_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/patients/features/patient_list/widgets/patient_row.dart';

class PatientsScreen extends StatefulWidget {
  static const routeName = '/patients';

  @override
  _PatientsScreenState createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  // void _goToForm(Patient patient) {
  //   Navigator.of(context)
  //       .pushNamed(ProblemCheckListScreen.routeName, arguments: patient);
  // }

  TextEditingController controller = new TextEditingController();
  // String filter = '';
  // int currentPage = 0;

  final bloc = sl<PatientListBloc>();

  TokenService _tokenService = TokenService();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidth = deviceSize.width;
    final deviceHeight = deviceSize.height;
    final blockSizeHorizontal = deviceWidth / 100;

    bloc.getPatientsList("");
    return Scaffold(
        appBar: CustomAppBar(false),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.all(5),
                child: new TextField(
                  decoration: new InputDecoration(labelText: "Search Patient"),
                  controller: controller,
                  onChanged: bloc.filterChange,
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey[300]),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: blockSizeHorizontal * 12,
                      child: Text(
                        'Billing Id',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      width: blockSizeHorizontal * 12,
                      child: Text(
                        'Patient Id',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      width: blockSizeHorizontal * 14,
                      child: Text(
                        'Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      width: blockSizeHorizontal * 14,
                      child: Text(
                        'DOB',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      width: blockSizeHorizontal * 14,
                      child: Text(
                        'Phone',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      width: blockSizeHorizontal * 14,
                      child: Text(
                        'Email',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      width: blockSizeHorizontal * 14,
                      child: Text(
                        'SSN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                height: deviceHeight - 190,
                child: StreamBuilder(
                  stream: bloc.patientsListObservable,
                  builder: (context, AsyncSnapshot<List<Patient>> snapshot) {
                    child:
                    if (snapshot.connectionState == ConnectionState.active &&
                        !bloc.isLoading) {
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      if (snapshot.hasData) {
                        List<Patient> patientsList = snapshot.data;
                        if (snapshot.data.length > 0) {
                          return NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification scrollInfo) {
                              if (scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {}
                            },
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: patientsList.length,
                              itemBuilder: (context, index) => GestureDetector(
                                child: PatientRow(
                                    patientsList[index], blockSizeHorizontal),
                                onTap: () {
                                  _tokenService.selectedPatientId =
                                      patientsList[index].id;
                                  bloc.getEncounters(
                                      patientsList[index], context);
                                  //  _goToForm(patientsList[index]);
                                },
                              ),
                            ),
                          );
                        }
                      }
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
