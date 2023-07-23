import 'package:flutter/material.dart';

class SliverAppBarOnTriggerSample extends StatefulWidget {
  const SliverAppBarOnTriggerSample({Key? key}) : super(key: key);

  @override
  State<SliverAppBarOnTriggerSample> createState() =>
      _SliverAppBarOnTriggerSampleState();
}

class _SliverAppBarOnTriggerSampleState
    extends State<SliverAppBarOnTriggerSample> {
  bool _stretch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            stretch: _stretch,
            // onStretchTrigger: () async {
            //   print('onStretchTrigger!!!');
            // },
            // stretchTriggerOffset: 300.0,
            expandedHeight: 200.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Sliver App Bar'),
              background: FlutterLogo(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            alignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('stretch'),
                  Switch(
                    onChanged: (bool val) {
                      print('val: $val');
                      setState(() {
                        _stretch = val;
                      });
                    },
                    value: _stretch,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
