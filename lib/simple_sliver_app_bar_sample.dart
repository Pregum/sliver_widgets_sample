import 'package:flutter/material.dart';

class SimpleSliverAppBarSample extends StatefulWidget {
  const SimpleSliverAppBarSample({Key? key}) : super(key: key);

  @override
  State<SimpleSliverAppBarSample> createState() =>
      _SimpleSliverAppBarSampleState();
}

class _SimpleSliverAppBarSampleState extends State<SimpleSliverAppBarSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: const Text('SliverAppBar Sample'),
        ),
        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              color: index.isOdd ? Colors.white : Colors.black12,
              height: 100.0,
              child: Center(
                child: Text('$index', textScaleFactor: 5),
              ),
            );
          },
        ))
      ],
    ));
  }
}
