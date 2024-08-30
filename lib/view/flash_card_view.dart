import 'package:flash_card/view/chat_view.dart';
import 'package:flash_card/widgets/curousal_button.dart';
import 'package:flash_card/widgets/customIconButton.dart';
import 'package:flash_card/widgets/slider_custom_container.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FlashCardView extends StatefulWidget {
  FlashCardView({super.key});

  @override
  _FlashCardViewState createState() => _FlashCardViewState();
}

class _FlashCardViewState extends State<FlashCardView> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: CustomIconButton(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChatView(),
              ));
            },
            iconData: Icons.arrow_back_ios_new_outlined),
        title: const Text(
          'Flash Card',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Stack(
        children: [
          Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 150),
              painter: AppBarPainter(),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Everyday Phases',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomPaint(
                      size: const Size(50, 50),
                      painter: CircularProgressPainter(
                        currentPage: _currentIndex,
                        totalPages: 3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    height: 320,
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: const [
                    SliderCustomContainer(),
                    SliderCustomContainer(),
                    SliderCustomContainer(),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CurousalButton(
                      title: 'Previous',
                      onPressed: () {
                        _carouselController.previousPage();
                      },
                    ),
                    CurousalButton(
                      title: 'Next',
                      onPressed: () {
                        _carouselController.nextPage();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final int currentPage;
  final int totalPages;

  CircularProgressPainter(
      {required this.currentPage, required this.totalPages});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    Paint progressPaint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    double angle = 2 * 3.14159265358979323846 * (currentPage / totalPages);

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2),
      -3.14159265358979323846 / 2,
      angle,
      false,
      progressPaint,
    );

    TextSpan textSpan = TextSpan(
      text: '${currentPage + 1}/$totalPages',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );

    TextPainter textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    Offset offset = Offset(
      size.width / 2 - textPainter.width / 2,
      size.height / 2 - textPainter.height / 2,
    );

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class AppBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.fill;

    Rect rect = Rect.fromLTWH(
      -size.width / 2,
      -size.height * 1,
      size.width * 2,
      size.height * 1.5,
    );

    canvas.drawArc(
      rect,
      0,
      3.14,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
