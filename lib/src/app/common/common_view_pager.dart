import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/res/app_colors.dart';

class CommonViewPager extends StatefulWidget {
  final List<String> imagesList;
  const CommonViewPager({Key? key, required this.imagesList}) : super(key: key);

  @override
  _CommonViewPagerState createState() => _CommonViewPagerState();
}

class _CommonViewPagerState extends State<CommonViewPager> {
  StreamController<int> bubbleStream = StreamController<int>.broadcast();
  final pageController = PageController();
  int pagerSelectedindex = 0;

  List<String> imagesList = [];

  @override
  void initState() {
    imagesList = widget.imagesList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            onPageChanged: (int index) {
              pagerSelectedindex = index;
              bubbleStream.add(pagerSelectedindex);
            },
            controller: pageController,
            itemCount: imagesList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    image: DecorationImage(fit: BoxFit.fill, image: AssetImage(widget.imagesList[index])),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 5,
          left: 0,
          right: 0,
          child: StreamBuilder<int>(
            stream: bubbleStream.stream,
            builder: (context, snapshot1) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(imagesList.length, pagerSelectedindex),
              );
            },
          ),
        )
      ],
    );
  }

  List<Widget> _buildPageIndicator(int length, int selected) {
    final List<Widget> list = [];
    for (int i = 0; i < length; i++) {
      list.add(i == selected ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return SizedBox(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 8 : 6.0,
        width: isActive ? 8 : 6.0,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.transparent,
            )
          ],
          shape: BoxShape.circle,
          color: isActive ? Colors.blue : Colors.black,
        ),
      ),
    );
  }

  @override
  void dispose() {
    bubbleStream.close();
    super.dispose();
  }
}
