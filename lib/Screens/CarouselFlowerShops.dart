// Carousel Slider with dots indication in a Flutter app by maxonflutter
// YT: https://www.youtube.com/@MaxonFlutter/
// Courses: https://www.atomsbox.com/
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: const CarouselSliderWithDots(),
    );
  }
}

class CarouselSliderWithDots extends StatefulWidget {
  const CarouselSliderWithDots({
    super.key,
    this.items = const [
      'assets/images/carouselImages/mother.jpg',
      'assets/images/carouselImages/sValentin.jpg',
    ],
  });

  final List<String> items;

  @override
  State<CarouselSliderWithDots> createState() => _CarouselSliderWithDotsState();
}

class _CarouselSliderWithDotsState extends State<CarouselSliderWithDots> {
  late CarouselController controller;
  int currentIndex = 0;

  @override
  void initState() {
    controller = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CarouselSlider(
          carouselController: controller,
          items: widget.items
              .map(
                (item) => Image.asset(
                  item,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: 100,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 8.0,
          child: DotsIndicator(
            dotsCount: widget.items.length,
            position: currentIndex,
            onTap: (index) {
              controller.animateToPage(index);
            },
            decorator: DotsDecorator(
              color: Color.fromARGB(255, 255, 255, 255),
              activeColor: Colors.amber,
              size: const Size.square(12.0),
              activeSize: const Size(24.0, 12.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
