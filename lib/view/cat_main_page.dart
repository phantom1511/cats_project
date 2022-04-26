import 'package:flutter/material.dart';

class CatMainPage extends StatefulWidget {
  const CatMainPage({Key? key}) : super(key: key);

  @override
  State<CatMainPage> createState() => _CatMainPageState();
}

class _CatMainPageState extends State<CatMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cats'),
      ),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
