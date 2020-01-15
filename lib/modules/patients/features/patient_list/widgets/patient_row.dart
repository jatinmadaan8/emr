import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/models/patient.dart';

class PatientRow extends StatelessWidget {
  final Patient patient;
  final blockSizeHorizontal;

  PatientRow(this.patient, this.blockSizeHorizontal);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey[300]),
        ),
      ),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: blockSizeHorizontal * 12,
            child: Text(patient.billingId),
          ),
          Container(
            width: blockSizeHorizontal * 12,
            child: Text(patient.billingId),
          ),
          Container(
            width: blockSizeHorizontal * 14,
            child: Text(patient.fullName),
          ),
          Container(
            width: blockSizeHorizontal * 14,
            child: Text(patient.dob),
          ),
          Container(
            width: blockSizeHorizontal * 14,
            child: Text(patient.phone),
          ),
          Container(
            width: blockSizeHorizontal * 17,
            child: Text(patient.email),
          ),
          Container(
            width: blockSizeHorizontal * 14,
            child: Text((patient.ssn == null ? '' : patient.ssn)),
          ),
        ],
      ),
    );
  }
}
