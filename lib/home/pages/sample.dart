import 'package:flutter/material.dart';

class Sample extends StatefulWidget {
  const Sample({Key? key}) : super(key: key);

  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> with TickerProviderStateMixin {
  late final TabController controller;
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabPageSelector(
              controller: controller,
              indicatorSize: 10,
            ),
            Container(
              height: 300,
              child: TabBarView(
                controller: controller,
                children: [
                  Text('aw'),
                  Text('aw'),
                  Text('aw'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
