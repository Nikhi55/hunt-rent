import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../resources/resources.dart';
import '../../../routes/app_routes.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';

class LandingScreens extends StatefulWidget {
  const LandingScreens({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingScreens> createState() => _LandingScreensState();
}

class _LandingScreensState extends State<LandingScreens> {
  PageController pageController = PageController();
  int currentPage = 0;
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              // padding: EdgeInsets.only(top: height * 0.1),
              height: height * 0.53,
              child: PageView(
                controller: pageController,
                onPageChanged: (page) {
                  currentPage = page;
                  setState(() {});
                },
                children: [
                  getAssetImage(
                    R.images.landing01,
                    // width: width,
                    // height: height * ,
                    boxFit: BoxFit.cover,
                  ),
                  getAssetImage(
                    R.images.landing02,
                    boxFit: BoxFit.fill,
                  ),
                  getAssetImage(
                    R.images.landing03,
                    boxFit: BoxFit.fill,
                  ),
                  getAssetImage(
                    R.images.landing04,
                    height: 400,
                    // boxFit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomPaint(
              painter: CurvePainter(),
              size: Size(double.infinity, double.infinity),
              child: Container(
                margin: EdgeInsets.all(FetchPixels.getPixelHeight(10)),
                padding: EdgeInsets.all(FetchPixels.getPixelHeight(30)),
                height: FetchPixels.getPixelHeight(950),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text Widget moved here directly inside the Column
                    Container(
                      padding: EdgeInsets.only(
                        bottom: FetchPixels.getPixelHeight(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        currentPage == 0
                            ? "Own your Style!"
                            : currentPage == 1
                                ? "Elevate your Fashion!"
                                : currentPage == 2
                                    ? "Affordable Luxury Awaits!"
                                    : "Rent or Buy - Your\nFashion, Your Way",
                        textAlign: TextAlign.start,
                        style: R.textStyle.mediumMetropolis().copyWith(
                              fontSize: FetchPixels.getPixelHeight(25),
                              color: R.colors.whiteColor,
                            ),
                      ),
                    ),

                    // Dots and Button Row
                    currentPage == 3
                        ? Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: FetchPixels.getPixelHeight(20)),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.offAllNamed(Routes.dashboardView);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    R.colors.bgColor, // Background color
                                padding: EdgeInsets.all(
                                    FetchPixels.getPixelHeight(15)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                "Get Started",
                                style: R.textStyle.mediumMetropolis().copyWith(
                                      fontSize: FetchPixels.getPixelHeight(18),
                                      color: R.colors.blackColor,
                                    ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: FetchPixels.getPixelHeight(120),
                            width: FetchPixels.getPixelWidth(300),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    4,
                                    (index) => Container(
                                      margin: EdgeInsets.only(right: 5),
                                      height: currentPage == index
                                          ? height * 0.04
                                          : height * 0.03,
                                      width: currentPage == index
                                          ? width * 0.04
                                          : width * 0.03,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: R.colors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (currentPage < 3) {
                                      currentPage += 1;
                                      pageController.animateToPage(currentPage,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.ease);
                                      setState(() {});
                                    }
                                  },
                                  icon: Container(
                                    height: height * 0.06,
                                    width: width * 0.15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: R.colors.bgColor,
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 25,
                                      color: R.colors.blackColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = R.colors.theme
      ..style = PaintingStyle.fill;

    final path = Path();
    final controlPoint1 = Offset(size.width / 4, size.height * 0.9);
    final controlPoint2 = Offset(size.width * 1.3, size.height * 0.40);

    path.moveTo(0, size.height / 2.5); // Start from center-left
    path.cubicTo(
      controlPoint1.dx,
      controlPoint1.dy,
      controlPoint2.dx,
      controlPoint2.dy,
      size.width, // End at bottom-right
      size.height,
    );
    path.lineTo(0, size.height); // Draw line from bottom-right to bottom-left
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
