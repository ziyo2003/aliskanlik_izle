import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParaPage extends StatefulWidget {
  const ParaPage({super.key});

  @override
  State<ParaPage> createState() => _ParaPageState();
}

class _ParaPageState extends State<ParaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("para"),
    );
  }
}
