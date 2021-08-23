import 'package:flutter/material.dart';
import 'package:acccount_project/account_details.dart';
import 'package:acccount_project/account_list.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/' : (context) => AccountList(),
      '/details' : (context) => AccountDetails()
    },
  ));
}

