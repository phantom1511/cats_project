import 'package:cats_project/model/cats.dart';
import 'package:cats_project/utils/hive_boxes.dart';
import 'package:cats_project/utils/static_keys.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/debugging_util.dart';

class FactHistory extends StatefulWidget {
  const FactHistory({Key? key}) : super(key: key);

  @override
  State<FactHistory> createState() => _FactHistoryState();
}

class _FactHistoryState extends State<FactHistory> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<dynamic>>(
      valueListenable: Hive.box(HiveBoxes.fact).listenable(keys: [
        StorageKeys.factKey,
      ]),
      builder: (context, Box<dynamic> box, _) {
        final getFact = box.get(StorageKeys.factKey);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Fact history'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final item = getFact.data![index];
                    Hive.box(HiveBoxes.fact).add(item.text);
                    dPrint(item, 'cats item');
                    return Column(
                      children: [
                        Text(
                          item.text ?? '',
                          style: const TextStyle(color: Colors.green),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 8);
                  },
                  itemCount: getFact ?? 0,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
