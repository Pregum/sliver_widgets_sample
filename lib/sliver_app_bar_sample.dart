import 'dart:math';

import 'package:flutter/material.dart';

class SliverAppBarSample extends StatefulWidget {
  const SliverAppBarSample({Key? key}) : super(key: key);

  @override
  State<SliverAppBarSample> createState() => _SliverAppBarSampleState();
}

class _SliverAppBarSampleState extends State<SliverAppBarSample> {
  final List _gridItems = List.generate(90, (index) => 'item $index');
  final List _sliverItems = List.generate(50, (index) => 'sliver item $index');
  final ScrollController _scrollController = ScrollController();

  var _lastPosition = 0.0;
  final _distanceDeltaThreshold = 50.0;
  var _visibleLeading = false;
  var _floating = true;
  var _stretch = true;
  var _snap = true;
  var _pinned = true;
  var _collapsedHeight = kToolbarHeight;
  var _expandedHeight = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final distance =
          (_lastPosition - _scrollController.position.pixels).abs();

      if (distance > _distanceDeltaThreshold) {
        print('current position: ${_scrollController.position.pixels}');
        _lastPosition = _scrollController.position.pixels;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            leading: _visibleLeading ? null : Container(),
            stretch: _stretch,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {},
              )
            ],
            collapsedHeight: _collapsedHeight,
            pinned: _pinned,
            floating: _floating,
            snap: _snap,
            backgroundColor: Colors.green,
            expandedHeight: _expandedHeight,
            elevation: 1,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.deepOrange,
                child: const Center(
                  child: Icon(
                    Icons.favorite,
                    size: 70,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ),
            title: const Text('first app bar'),
          ),
          SliverGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1,
            children: [
              Card(
                color: Colors.blue[200],
                child: Container(),
              ),
              Card(
                color: Colors.blue[400],
                child: Container(),
              ),
              Card(
                color: Colors.blue[600],
                child: Container(),
              ),
              Card(
                color: Colors.blue[1000],
                child: Container(),
              ),
            ],
          ),
          // const SliverPadding(padding: EdgeInsets.symmetric(vertical: 30)),
          // SliverAppBar(
          //   leading: _visibleLeading ? null : Container(),
          //   elevation: 5,
          //   pinned: _pinned,
          //   stretch: _stretch,
          //   snap: _snap,
          //   floating: _floating,
          //   backgroundColor: Colors.pink,
          //   expandedHeight: 250.0,
          //   flexibleSpace: FlexibleSpaceBar(
          //     background: Container(
          //       color: Colors.amber,
          //       child: const Center(
          //         child: Icon(
          //           Icons.run_circle,
          //           size: 60,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          //   title: const Text(
          //     'Second Sliver AppBar',
          //   ),
          // ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate(
              ((context, index) {
                return Card(
                  color: Colors.amber[Random().nextInt(9) * 100],
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      _gridItems[index],
                    ),
                  ),
                );
              }),
              childCount: _gridItems.length,
            ),
          ),
          // SliverList(
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      _sliverItems[index],
                    ),
                  ),
                );
              },
              addRepaintBoundaries: true,
              childCount: _sliverItems.length,
            ),
            itemExtent: 200.0,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('drawer button visible'),
                  Switch(
                      value: _visibleLeading,
                      onChanged: (value) {
                        setState(() {
                          _visibleLeading = value;
                        });
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('expandedHeight'),
                  SizedBox(
                    height: 50,
                    child: Slider(
                      label: _expandedHeight.toStringAsFixed(0),
                      divisions: 10,
                      value: _expandedHeight,
                      min: kToolbarHeight,
                      max: MediaQuery.of(context).size.height,
                      onChanged: ((value) {
                        setState(() {
                          _expandedHeight = value;
                        });
                      }),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('collapsedHeight'),
                  SizedBox(
                    height: 50,
                    child: Slider(
                      value: _collapsedHeight,
                      divisions: 10,
                      label: _collapsedHeight.toStringAsFixed(0),
                      min: kToolbarHeight,
                      max: MediaQuery.of(context).size.height,
                      onChanged: ((value) {
                        setState(() {
                          _collapsedHeight = value;
                        });
                      }),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('stretch'),
                  Switch(
                    value: _stretch,
                    onChanged: (value) {
                      setState(() {
                        _stretch = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('floating'),
                  Switch(
                    value: _floating,
                    onChanged: (value) {
                      final needTurnOffSnapFlag = !value;
                      setState(() {
                        _floating = value;
                        if (needTurnOffSnapFlag) {
                          _snap = value;
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('pinned'),
                  Switch(
                    value: _pinned,
                    onChanged: (value) {
                      setState(() {
                        _pinned = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('snap'),
                  Switch(
                    value: _snap,
                    onChanged: (value) {
                      // snapがfalseだとfloatingはtrue must
                      // snapがtrueだとfloatingはtrue must
                      final needTurnOnFloatingFlag = value;
                      setState(() {
                        _snap = value;
                        if (needTurnOnFloatingFlag) {
                          _floating = value;
                        }
                      });
                    },
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
