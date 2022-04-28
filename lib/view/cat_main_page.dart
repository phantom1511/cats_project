import 'package:cats_project/model/cats.dart';
import 'package:cats_project/service/web_service.dart';
import 'package:cats_project/utils/debugging_util.dart';
import 'package:cats_project/view/fact_history.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../utils/hive_boxes.dart';

class CatMainPage extends StatefulWidget {
  const CatMainPage({Key? key}) : super(key: key);

  @override
  State<CatMainPage> createState() => _CatMainPageState();
}

class _CatMainPageState extends State<CatMainPage> {
  final webService = WebService();
  final String catPhoto = 'https://cataas.com/cat';

  void _anotherFact() {
    setState(() {
      webService.getCatFact();
      webService.getCatImage();
      Hive.box(HiveBoxes.fact)
          .put(HiveBoxes.fact, webService.getCatFact());
      catPhoto;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cats'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              FutureBuilder<Cat>(
                future: webService.getCatFact(),
                builder: (context, snapshot) {
                  Hive.openBox<dynamic>(HiveBoxes.fact);
                  if (kDebugMode) {
                    print('snapshot.error');
                    print(snapshot.error);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    try {
                      final item = snapshot.data;
                      Hive.box(HiveBoxes.fact).put(HiveBoxes.fact, item);

                      return Column(
                        children: [
                          Text(
                            item?.text ?? '',
                            style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      );
                    } on Exception catch (e) {
                      dPrint(e, 'Error');
                      return Center(
                        child: Text('Something went wrong $e'),
                      );
                    }
                  } else {
                    const Text('Something went wrong');
                  }
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                },
              ),
              const SizedBox(height: 16),
              FutureBuilder(
                  future: webService.getCatImage(),
                  builder: (context, snapshot) {
                    return Image.network(catPhoto,
                        loadingBuilder: ((BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                          child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ));
                    }));
                  }),
              const SizedBox(height: 16),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                    onPressed: () async {
                      _anotherFact();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        elevation: MaterialStateProperty.all<double>(0),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.all(16)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22)),
                        )),
                    child: const Text('Another fact!')),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                    onPressed: () async {
                      await Hive.openBox<dynamic>(HiveBoxes.fact);

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const FactHistory()));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        elevation: MaterialStateProperty.all<double>(0),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.all(16)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22)),
                        )),
                    child: const Text('Fact history')),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
