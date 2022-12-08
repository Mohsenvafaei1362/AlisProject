import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class slider extends StatelessWidget {
  const slider({
    Key? key,
    required PageController controller,
  })  : _controller = controller,
        super(key: key);

  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AspectRatio(
            aspectRatio: 2,
            child: PageView.builder(
                controller: _controller,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/$index.jpg',
                        fit: BoxFit.fill),
                  );
                }),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 8,
          child: Center(
            child: SmoothPageIndicator(
              controller: _controller,
              count: 5,
              axisDirection: Axis.horizontal,
              effect: const SlideEffect(
                  spacing: 8.0,
                  radius: 4.0,
                  dotWidth: 24.0,
                  dotHeight: 5.0,
                  paintStyle: PaintingStyle.stroke,
                  strokeWidth: 1.5,
                  dotColor: Colors.grey,
                  activeDotColor: Colors.indigo),
            ),
          ),
        )
      ],
    );
  }
}
