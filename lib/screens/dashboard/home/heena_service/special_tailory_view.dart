import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/dashboard/cart/check_out_pay.dart';
import 'package:hunt_and_rent/screens/dashboard/home/heena_service/check_out.dart';
import 'package:hunt_and_rent/screens/dashboard/home/heena_service/model/BookingDetails.dart';
import 'package:hunt_and_rent/screens/dashboard/home/heena_service/widget/abayas_view.dart';
import 'package:hunt_and_rent/screens/dashboard/home/heena_service/widget/special_tailory_widget.dart';
import 'package:hunt_and_rent/widgets/my_button.dart';
import 'package:hunt_and_rent/widgets/table_calender.dart';

import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../forum/forum_page.dart';
import '../../../../resources/resources.dart';
import '../../dashboard_view.dart';
import '../../profile/pages/my_whish_list.dart';
import '../../profile/pages/notifications/notifications.dart';
import '../favrt_produects.dart';

// class SpecialTailoryView extends StatelessWidget {
//   const SpecialTailoryView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //     leading: Center(
//       //       child: InkWell(
//       //         onTap: () {
//       //           Get.back();
//       //         },
//       //         child: Container(
//       //           height: FetchPixels.getPixelHeight(30),
//       //           width: FetchPixels.getPixelWidth(30),
//       //           decoration: BoxDecoration(
//       //               shape: BoxShape.circle, color: R.colors.blackColor),
//       //           child: Icon(
//       //             Icons.arrow_back_ios_rounded,
//       //             size: FetchPixels.getPixelHeight(18),
//       //             color: R.colors.bgColor,
//       //           ),
//       //         ),
//       //       ),
//       //     ),
//       //     actions: [
//       //       Center(
//       //         child: getAssetImage(R.images.selectedCart,
//       //             color: R.colors.buttonText,
//       //             scale: FetchPixels.getPixelHeight(4)),
//       //       ),
//       //       getHorSpace(FetchPixels.getPixelWidth(10)),
//       //       Center(
//       //         child: InkWell(
//       //           onTap: () {
//       //             Get.to(FavrtProductsView());
//       //           },
//       //           child: getAssetImage(R.images.fav,
//       //               color: R.colors.redColor,
//       //               scale: FetchPixels.getPixelHeight(3.5)),
//       //         ),
//       //       ),
//       //       getHorSpace(FetchPixels.getPixelWidth(20))
//       //     ],
//       //     iconTheme: IconThemeData(
//       //       color: R.colors.whiteColor, //change your color here
//       //     ),
//       //     automaticallyImplyLeading: false,
//       //     backgroundColor: R.colors.transparent,
//       //     elevation: 0.0,
//       //     centerTitle: true,
//       //     title: getAssetImage(R.images.logo1,
//       //         height: FetchPixels.getPixelHeight(60),
//       //         width: FetchPixels.getPixelWidth(150))),
//       body: getPaddingWidget(
//         EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(15)),
//         ListView(children: [
//           getVerSpace(FetchPixels.getPixelHeight(10)),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               InkWell(
//                 onTap: () => Get.back(),
//                 child: Icon(
//                   Icons.arrow_back_ios_rounded,
//                   size: FetchPixels.getPixelHeight(22),
//                   color: R.colors.blackColor,
//                 ),
//               ),
//               getHorSpace(FetchPixels.getPixelWidth(30)),
//               Row(
//                 children: [
//                   Align(
//                       alignment: Alignment.center,
//                       child: Text(
//                         "Tailory Service",
//                         style: R.textStyle
//                             .semiBoldMetropolis()
//                             .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
//                       )),
//                 ],
//               ),
//               // Container(
//               //   height: FetchPixels.getPixelHeight(40),
//               //   width: FetchPixels.getPixelWidth(180),
//               //   child: Padding(
//               //     padding: EdgeInsets.only(
//               //         left: FetchPixels.getPixelWidth(5),
//               //         right: FetchPixels.getPixelWidth(10)),
//               //     child: TextFormField(
//               //         // controller: searchController,
//               //         // onChanged: (value) {
//               //         //   searchQuery = value;
//               //         //   performSearch(product: product);
//               //         //   setState(() {});
//               //         // },
//               //         decoration: R.decorations.textFormFieldDecoration(
//               //             null, "Search",
//               //             suffix: Icon(Icons.search_rounded))),
//               //   ),
//               // ),

//               Row(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Get.to(() => ForumView());
//                     },
//                     child: getAssetImage(R.images.chatoutline,
//                         // color: R.colors.buttonText,
//                         scale: 4.5),
//                   ),
//                   getHorSpace(FetchPixels.getPixelWidth(10)),
//                   InkWell(
//                     onTap: () {
//                       Get.to(() => WishList());
//                     },
//                     child: getAssetImage(R.images.favOutline,
//                         // color: R.colors.buttonText,
//                         scale: 4.5),
//                   ),
//                   getHorSpace(FetchPixels.getPixelWidth(10)),
//                   InkWell(
//                     onTap: () {
//                       Get.to(() => NotificationsView());
//                     },
//                     child: getAssetImage(R.images.notificationOutline,
//                         // color: R.colors.buttonText,
//                         scale: 4.5),
//                   ),
//                   getHorSpace(FetchPixels.getPixelWidth(20)),
//                 ],
//               ),
//             ],
//           ),
//           getVerSpace(FetchPixels.getPixelHeight(10)),
//           Text(
//             "Introducing our Special Tailory Service",
//             style: R.textStyle
//                 .mediumMetropolis()
//                 .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
//           ),
//           getVerSpace(FetchPixels.getPixelHeight(10)),
//           RichText(
//               text: TextSpan(
//             children: [
//               TextSpan(
//                   style: R.textStyle
//                       .regularMetropolis()
//                       .copyWith(fontSize: FetchPixels.getPixelHeight(14)),
//                   text:
//                       'Custom-made Abayas and Thobes,delivered to your doorstep. Know '),
//               TextSpan(
//                 style: R.textStyle.regularMetropolis().copyWith(
//                     decoration: TextDecoration.underline,
//                     fontSize: FetchPixels.getPixelHeight(14),
//                     color: R.colors.theme),
//                 text: ' How it works.',
//                 recognizer: TapGestureRecognizer()
//                   ..onTap = () {
//                     showModalBottomSheet(
//                       context: context,
//                       builder: (context) => Container(
//                         height: FetchPixels.getPixelHeight(350),
//                         padding: EdgeInsets.symmetric(
//                             horizontal: FetchPixels.getPixelWidth(20)),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Here's how it works:",
//                               style: R.textStyle.semiBoldMetropolis().copyWith(
//                                   fontSize: FetchPixels.getPixelHeight(18)),
//                             ),
//                             getVerSpace(FetchPixels.getPixelHeight(20)),
//                             Text.rich(TextSpan(children: [
//                               TextSpan(
//                                 text: "1. ",
//                                 style: R.textStyle.regularMetropolis().copyWith(
//                                     fontSize: FetchPixels.getPixelHeight(14)),
//                               ),
//                               TextSpan(
//                                 text:
//                                     "Explore designs and select your favorite.",
//                                 style: R.textStyle.regularMetropolis().copyWith(
//                                     fontSize: FetchPixels.getPixelHeight(14)),
//                               ),
//                             ])),
//                             Text.rich(TextSpan(children: [
//                               TextSpan(
//                                 text: "2. ",
//                                 style: R.textStyle.regularMetropolis().copyWith(
//                                     fontSize: FetchPixels.getPixelHeight(14)),
//                               ),
//                               TextSpan(
//                                 text:
//                                     "Request a visit from our Special Tailory agent.",
//                                 style: R.textStyle.regularMetropolis().copyWith(
//                                     fontSize: FetchPixels.getPixelHeight(14)),
//                               ),
//                             ])),
//                             Text.rich(TextSpan(children: [
//                               TextSpan(
//                                 text: "3. ",
//                                 style: R.textStyle.regularMetropolis().copyWith(
//                                     fontSize: FetchPixels.getPixelHeight(14)),
//                               ),
//                               TextSpan(
//                                 text:
//                                     "Personalized consultation and measurements at your convenience.",
//                                 style: R.textStyle.regularMetropolis().copyWith(
//                                     fontSize: FetchPixels.getPixelHeight(14)),
//                               ),
//                             ])),
//                             Text.rich(TextSpan(children: [
//                               TextSpan(
//                                 text: "4. ",
//                                 style: R.textStyle.regularMetropolis().copyWith(
//                                     fontSize: FetchPixels.getPixelHeight(14)),
//                               ),
//                               TextSpan(
//                                 text:
//                                     "Order placed with partner tailor stores.",
//                                 style: R.textStyle.regularMetropolis().copyWith(
//                                     fontSize: FetchPixels.getPixelHeight(14)),
//                               ),
//                             ])),
//                             Text.rich(TextSpan(children: [
//                               TextSpan(
//                                 text: "5. ",
//                                 style: R.textStyle.regularMetropolis().copyWith(
//                                     fontSize: FetchPixels.getPixelHeight(14)),
//                               ),
//                               TextSpan(
//                                 text: "Timely delivery to your doorstep.",
//                                 style: R.textStyle.regularMetropolis().copyWith(
//                                     fontSize: FetchPixels.getPixelHeight(14)),
//                               ),
//                             ])),
//                             getVerSpace(FetchPixels.getPixelHeight(10)),
//                             Text(
//                               "Say goodbye to long waits and enjoy hassle-free customization with Hunt&Rent's Special Tailory Service. Contact our customer support for more information.",
//                               style: R.textStyle.regularMetropolis().copyWith(
//                                   fontSize: FetchPixels.getPixelHeight(14)),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//               )
//             ],
//           )),
//           getVerSpace(FetchPixels.getPixelHeight(20)),
//           SizedBox(
//             height: FetchPixels.getPixelHeight(250),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 InkWell(
//                     onTap: () {
//                       Get.to(() => AbayasView(
//                             productName: "Abaya",
//                           ));
//                     },
//                     child: SpecialTailoryWidget(
//                       name: "Abayas",
//                       image: R.images.aba,
//                     )),
//                 // getHorSpace(FetchPixels.getPixelWidth(10)),
//                 InkWell(
//                     onTap: () {
//                       Get.to(() => AbayasView(
//                             productName: "Thobes",
//                           ));
//                     },
//                     child: SpecialTailoryWidget(
//                       name: "Thobes",
//                       image: R.images.tho,
//                     )),
//                 // SpecialTailoryWidget(
//                 //   name: "Thobes",
//                 //   image: R.images.tho,
//                 // ),
//               ],
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }

class SpecialTailoryView extends StatefulWidget {
  const SpecialTailoryView({super.key});

  @override
  State<SpecialTailoryView> createState() => _SpecialTailoryViewState();
}

class _SpecialTailoryViewState extends State<SpecialTailoryView> {
  final TextEditingController adressController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  DateTime selectedDate = DateTime.now(); // Initial selected date

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: R.colors.theme1,
        title: Text(
          'Heena Service',
          style: TextStyle(
            color: R.colors.whiteColor,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: R.colors.whiteColor,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                height: height * 0.25,
                color: R.colors.theme1,
              ),
              SingleChildScrollView(
                // chiEdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.zero,
                        // height: height * 0.58,
                        // width: height * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: R.colors.bgColor,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: getAssetImage(R.images.heenaImg2),
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(10)),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 23.0),
                                child: Text(
                                  'Henna Home Service',
                                  style:
                                      R.textStyle.regularMetropolis().copyWith(
                                            fontSize:
                                                FetchPixels.getPixelHeight(24),
                                            fontWeight: FontWeight.bold,
                                          ),
                                ),
                              ),
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(10)),
                            Text(
                              'Book a skilled henna artist to create\nbeautiful designs at your home. Enjoy a\npersonalized and convenient henna\nexperience.',
                              style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(20),
                                  ),
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(05)),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'QR700',
                                  style: R.textStyle
                                      .regularMetropolis()
                                      .copyWith(
                                          fontSize:
                                              FetchPixels.getPixelHeight(24),
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(7)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: R.colors.bgColor,
                        ),
                        child: HeenaCalendarScreen(
                          onDateSelected: (date) {
                            setState(() {
                              selectedDate = date;
                            });
                          },
                        ),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(7)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: R.colors.bgColor,
                        ),
                        child: Column(
                          children: [
                            getVerSpace(FetchPixels.getPixelHeight(7)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Enter your Address for Delivery',
                                  style:
                                      R.textStyle.regularMetropolis().copyWith(
                                            fontSize:
                                                FetchPixels.getPixelHeight(22),
                                            fontWeight: FontWeight.bold,
                                          ),
                                ),
                                Icon(Icons.location_on_outlined)
                              ],
                            ),
                            SizedBox(height: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Address",
                                  style: R.textStyle
                                      .regularMetropolis()
                                      .copyWith(
                                        color: R.colors.blackColor
                                            .withOpacity(0.7),
                                        fontSize: FetchPixels.getPixelHeight(
                                          20,
                                        ),
                                      ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  // height: FetchPixels.getPixelHeight(50),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: adressController,
                                    cursorColor: R.colors.blackColor,
                                    textInputAction: TextInputAction.next,
                                    style: R.textStyle
                                        .regularMetropolis()
                                        .copyWith(
                                            height: 1,
                                            fontSize:
                                                FetchPixels.getPixelHeight(16),
                                            color: R.colors.blackColor),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelText: 'Enter your Address',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "State",
                                        style: R.textStyle
                                            .regularMetropolis()
                                            .copyWith(
                                              color: R.colors.blackColor
                                                  .withOpacity(0.7),
                                              fontSize:
                                                  FetchPixels.getPixelHeight(
                                                20,
                                              ),
                                            ),
                                      ),
                                      SizedBox(
                                        width: FetchPixels.getPixelWidth(150),
                                        // height: FetchPixels.getPixelHeight(50),
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          controller: stateController,
                                          cursorColor: R.colors.blackColor,
                                          textInputAction: TextInputAction.next,
                                          style: R.textStyle
                                              .regularMetropolis()
                                              .copyWith(
                                                  height: 1,
                                                  fontSize: FetchPixels
                                                      .getPixelHeight(16),
                                                  color: R.colors.blackColor),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelText: 'State here',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Zip Code",
                                        style: R.textStyle
                                            .regularMetropolis()
                                            .copyWith(
                                              color: R.colors.blackColor
                                                  .withOpacity(0.7),
                                              fontSize:
                                                  FetchPixels.getPixelHeight(
                                                20,
                                              ),
                                            ),
                                      ),
                                      SizedBox(
                                        width: FetchPixels.getPixelWidth(170),
                                        // height: FetchPixels.getPixelHeight(50),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: zipController,
                                          cursorColor: R.colors.blackColor,
                                          textInputAction: TextInputAction.next,
                                          style: R.textStyle
                                              .regularMetropolis()
                                              .copyWith(
                                                  height: 1,
                                                  fontSize: FetchPixels
                                                      .getPixelHeight(16),
                                                  color: R.colors.blackColor),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelText: 'Enter Code',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(20)),
                      MyButton(
                          onTap: () {
                            final bookingDetails = BookingDetails(
                              address: adressController.text,
                              zipCode: zipController.text,
                              state: stateController.text,
                              selectedDate: selectedDate,
                            );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CheckOutPage1(
                                  bookingDetails: bookingDetails,
                                ),
                              ),
                            );
                          },
                          buttonText: 'Book Now'),
                      getVerSpace(FetchPixels.getPixelHeight(16)),
                    ],
                  ),
                ),
              ),

              // Positioned(
              //   bottom: height * 0.0,
              //   left: height * 0.02,
              //   right: height * 0.02,
              //   child: Container(
              //     height: height * 0.58,
              //     width: height * 0.4,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: R.colors.theme),
              //   ),
              // )
            ],
          );
        },
      ),
    );
  }
}
