import 'dart:js';

import 'package:address_book/pages/contact_details_page.dart';
import 'package:address_book/pages/contact_list_page.dart';
import 'package:address_book/pages/new_contact_page.dart';
import 'package:address_book/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context)=>ContactProvider() .. getAllContact(),
      child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ContactListPage.routeName,
      routes: {
        ContactListPage.routeName:(context)=>ContactListPage(),
        NewContactPage.routeName:(context)=>NewContactPage(),
        ContactDetailsPage.routeName:(context)=>ContactDetailsPage(),
      },
    );
  }
}

