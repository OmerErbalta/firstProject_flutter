// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:list_gayrimenkul/anasayfa.dart';
import 'package:list_gayrimenkul/model/Musteri.dart';
import 'package:list_gayrimenkul/model/sabitler.dart';

Future<void> main() async {
  await Hive.initFlutter("Musteriler");
  Hive.registerAdapter(MusteriAdapter());
  await Hive.openBox<Musteri>("Musteriler");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Gayrimenkul',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Sabitler.anaRenk,
          primaryTextTheme:
              TextTheme(bodyText1: TextStyle(color: Colors.white))),
      home: Stack(children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromRGBO(4, 9, 35, 1), Sabitler.anaRenk],
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter)),
        ),
        Scaffold(body: AnaSayfa()),
      ]),
    );
  }
}
