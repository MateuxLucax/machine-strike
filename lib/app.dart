import 'package:flutter/material.dart';

import 'view/home_view.dart';

class MachineStrikeApp extends StatelessWidget {
  const MachineStrikeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Machine Strike',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomeView(),
    );
  }
}
