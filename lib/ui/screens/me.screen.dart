import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.provider.dart';

class MeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Me'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
      body: user != null
          ? Column(
              children: [
                Text('Name: ${user.name}'),
                Text('Email: ${user.email}'),
                Text('Referrer: ${user.referrerCode}'),
                Text('Phone: ${user.phone}'),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
