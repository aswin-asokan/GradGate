import 'dart:async'; // Import the timer package
import 'package:flutter/material.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key, required this.width});
  final double width;
  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<String> images = ["assets/images/back.jpg", "assets/images/back2.png"];
  int currentIndex = 0;
  List<String> description = [
    "“GradGate made my college application process so much easier. Its intuitive interface helped me track deadlines and documents effortlessly. The personalized college recommendations were spot-on, introducing me to great options I hadn’t considered. Plus, the support team was always there to help. I highly recommend it to any student!”",
    "“This Application has revolutionized our hiring process. Its user-friendly interface and robust features have streamlined candidate tracking and communication. The ability to access detailed profiles and application statuses in real-time has significantly improved our efficiency. I highly recommend this tool to any organization looking to enhance their recruitment efforts.”",
  ];

  Timer? _timer; // Declare a Timer object

  @override
  void initState() {
    super.initState();
    _startAutoSlide(); // Start the auto-slide timer
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      setState(() {
        currentIndex =
            (currentIndex + 1) % images.length; // Cycles through images
      });
    });
  }

  void _showNextImage() {
    setState(() {
      currentIndex =
          (currentIndex + 1) % images.length; // Cycles through images
    });
  }

  void _showPreviousImage() {
    setState(() {
      currentIndex = (currentIndex - 1 + images.length) % images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: widget.width * 0.6,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              AnimatedSwitcher(
                duration:
                    const Duration(milliseconds: 500), // Animation duration
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation, // Fade effect
                    child: child,
                  );
                },
                child: Image.asset(
                  images[currentIndex],
                  key:
                      ValueKey<int>(currentIndex), // Key for tracking the image
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom: 30,
                left: 20,
                right: 150,
                child: Column(
                  children: [
                    Text(
                      description[currentIndex],
                      style: const TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _showPreviousImage,
                      icon: Icon(
                        Icons.arrow_circle_left_outlined,
                        color: button,
                        size: 50,
                      ),
                    ),
                    IconButton(
                      onPressed: _showNextImage,
                      icon: Icon(
                        Icons.arrow_circle_right_outlined,
                        color: button,
                        size: 50,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
