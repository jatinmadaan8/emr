import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Divider(),
          ListTile(
            title: Text('Summary'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text('Forms/Notes'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text('Standards And Scales'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text('Test/Results'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text('Prescription'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text('Tele Consult'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text('CCM/RPM Consult'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text('PGx Consult'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
