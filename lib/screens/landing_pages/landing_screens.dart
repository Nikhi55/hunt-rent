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
              height: height * 0.47,
              child: PageView(
                controller: pageController,
                onPageChanged: (page) {
                  currentPage = page;
                  setState(() {});
                },
                children: [
                  getAssetImage(
                    R.images.landing01,
                    width: width,
                    height: height * 0.15,
                    boxFit: BoxFit.contain,
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
                    boxFit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: TopWaveClipper(),
              child: Container(
                margin: EdgeInsets.all(FetchPixels.getPixelHeight(10)),
                padding: EdgeInsets.all(FetchPixels.getPixelHeight(30)),
                height: FetchPixels.getPixelHeight(450),
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     begin: Alignment.topCenter,
                //     end: Alignment.bottomCenter,
                // colors: [R.colors.g1.withOpacity(0.1), R.colors.theme1],
                //   ),
                // ),

                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     R.colors.g1.withOpacity(0.1),
                //     R.colors.theme1,
                //   ],
                // ),

                color: R.colors.theme, // Use your desired color

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // getVerSpace(FetchPixels.getPixelHeight(10)),

                    Container(
                      padding: EdgeInsets.only(
                        top: FetchPixels.getPixelHeight(20),
                        bottom: FetchPixels.getPixelHeight(40),
                      ),
                      alignment: Alignment.topCenter,
                      height: FetchPixels.getPixelHeight(200),
                      width: FetchPixels.getPixelWidth(400),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              currentPage == 0
                                  ? "Own Your Style!\nNot your Wardrobe! "
                                  : currentPage == 1
                                      ? "Unleash your Glamour!"
                                      : currentPage == 2
                                          ? "Rent. Return .Redefine!"
                                          : "Unlock the Joy,\nJust Rent and Enjoy!",
                              textAlign: TextAlign.start,
                              style: R.textStyle.semiBoldMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(25),
                                    color: R.colors.whiteColor,
                                  ),
                            ),
                          ),
                          getVerSpace(30),
                          Expanded(
                            child: Text(
                              currentPage == 0
                                  ? "Access quality clothing without the commitment of owning. "
                                  : currentPage == 1
                                      ? "Fashion should be accessible to everyone.\nStay on-trend without the commitment of ownership."
                                      : currentPage == 2
                                          ? "Effortlessly stay in touch with the latest fashion trends without the need for long-term ownership. "
                                          : "Discover our extensive collection of fashionable clothing, shoes, and accessories that are now available for rent. ",
                              textAlign: TextAlign.start,
                              style: R.textStyle.mediumMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(16),
                                    color: R.colors.whiteColor,
                                  ),
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: FetchPixels.getPixelHeight(70),
                      width: FetchPixels.getPixelWidth(300),
                      child: Row(
                        mainAxisAlignment: currentPage == 3
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  // borderRadius: BorderRadius.circular(10),
                                  shape: BoxShape.rectangle,
                                  color: R.colors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                          currentPage == 3
                              ? InkWell(
                                  onTap: () {
                                    print(currentPage);
                                    if (currentPage <= 2) {
                                      currentPage = currentPage + 1;
                                      pageController.animateToPage(currentPage,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.ease);
                                      setState(() {});
                                    } else {
                                      Get.offAllNamed(Routes.userTypeView);
                                    }
                                  },
                                  child: Container(
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
                              : SizedBox(),
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

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(
        0, size.height * 0.15); // Start slightly below the top-left corner

    // // Define control points and end points to create the wave
    // var firstControlPoint = Offset(size.width * 0.25,
    //     size.height * 0.05); // Control point for the first curve
    // var firstEndPoint = Offset(
    //     size.width * 0.5, size.height * 0.15); // End point for the first curve

    // var secondControlPoint = Offset(size.width * 0.75,
    //     size.height * 0.25); // Control point for the second curve
    // var secondEndPoint = Offset(
    //     size.width, size.height * 0.15); // End point for the second curve

    // // Create the quadratic Bezier curve
    // path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
    //     firstEndPoint.dx, firstEndPoint.dy);
    // path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
    //     secondEndPoint.dx, secondEndPoint.dy);

    // path.lineTo(size.width, 0); // Go to the top-right corner
    // path.lineTo(0, 0); // Go to the top-left corner
    // path.close(); // Close the path

    path.cubicTo(
      size.width / 4,
      3 * (size.height / 2),
      3 * (size.width / 4),
      size.height / 2,
      size.width,
      size.height * 0.9,
    );

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
