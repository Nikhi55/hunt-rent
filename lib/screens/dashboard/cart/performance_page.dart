// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hunt_and_rent/screens/dashboard/dashboard_view.dart';
// import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:provider/provider.dart';

// import '../../../base/resizer/fetch_pixels.dart';
// import '../../../base/widget_utils.dart';
// import '../../../resources/resources.dart';

// class PerformancePage extends StatefulWidget {
//   const PerformancePage({super.key});

//   @override
//   State<PerformancePage> createState() => _PerformancePageState();
// }

// class _PerformancePageState extends State<PerformancePage> {
//   int totalHunts = 0;
//   int thisMonthHunts = 0;
//   int previousMonthHunts = 0;

//   @override
//   void initState() {
//     getTotalHunts();
//     getThisMonthHunts();
//     getPreviousMonthHunts();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           leading: InkWell(
//             onTap: () {
//               Get.to(() => DashboardView(
//                     index: 0,
//                   ));
//             },
//             child: Icon(
//               Icons.arrow_back_ios_rounded,
//               size: FetchPixels.getPixelHeight(25),
//               color: R.colors.blackColor,
//             ),
//           ),
//           iconTheme: IconThemeData(
//             color: R.colors.whiteColor, //change your color here
//           ),
//           automaticallyImplyLeading: false,
//           backgroundColor: R.colors.transparent,
//           elevation: 0.0,
//           // centerTitle: true,
//           title: Text(
//             "My Performance",
//             style: R.textStyle
//                 .semiBoldMetropolis()
//                 .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
//           )),
//       body: Container(
//         decoration: BoxDecoration(
//             gradient: LinearGradient(colors: [
//           R.colors.whiteColor,
//           R.colors.whiteColor,
//           // R.colors.whiteColor,
//           // R.colors.whiteColor,
//           R.colors.whiteColor,
//           R.colors.containerBG1
//         ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
//         child: getPaddingWidget(
//           EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
//           Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//             Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[Text('60 %'), Text("100%")],
//                   ),
//                 ),
//                 Center(
//                   child: LinearPercentIndicator(
//                     barRadius: Radius.circular(FetchPixels.getPixelHeight(30)),
//                     width: FetchPixels.getPixelWidth(350),
//                     backgroundColor: R.colors.containerBG,
//                     animation: true,
//                     animateFromLastPercent: true,
//                     lineHeight: 20.0,
//                     animationDuration: 2000,
//                     percent: totalHunts <= 10 ? totalHunts / 10 : 0.5,
//                     // center: Text("90.0%"),
//                     linearStrokeCap: LinearStrokeCap.roundAll,
//                     progressColor: R.colors.goldenColor,
//                   ),
//                 )
//               ],
//             ),

//             Text.rich(
//               TextSpan(
//                 children: [
//                   TextSpan(
//                       text: "Rental Performance: ",
//                       style: R.textStyle
//                           .regularMetropolis()
//                           .copyWith(fontSize: FetchPixels.getPixelHeight(16))),
//                   TextSpan(
//                       text: "Very Good",
//                       style: R.textStyle.regularMetropolis().copyWith(
//                           fontSize: FetchPixels.getPixelHeight(17),
//                           color: R.colors.theme)),
//                 ],
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   color: R.colors.goldenColor.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(16)),
//               padding: EdgeInsets.all(16),
//               width: double.maxFinite,
//               child: Column(
//                 children: [
//                   getAssetImage(
//                     boxFit: BoxFit.scaleDown,
//                     R.images.starImage,
//                     scale: FetchPixels.getPixelHeight(8),
//                   ),
//                   getVerSpace(FetchPixels.getPixelHeight(10)),
//                   Text.rich(TextSpan(children: [
//                     TextSpan(
//                         text: "Rank:  ",
//                         style: R.textStyle.mediumMetropolis().copyWith(
//                             fontSize: FetchPixels.getPixelHeight(18))),
//                     TextSpan(
//                         text: "Gold",
//                         style: R.textStyle.semiBoldMetropolis().copyWith(
//                             fontSize: FetchPixels.getPixelHeight(22),
//                             color: R.colors.goldenColor)),
//                   ]))
//                 ],
//               ),
//             ),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 getHorSpace(FetchPixels.getPixelWidth(20)),
//                 Text(
//                   "Total Huntings:",
//                   style: R.textStyle.semiBoldMetropolis().copyWith(
//                       color: R.colors.theme,
//                       fontSize: FetchPixels.getPixelHeight(18)),
//                 ),
//                 Spacer(),
//                 Text(
//                   "${totalHunts}",
//                   style: R.textStyle.semiBoldMetropolis().copyWith(
//                         fontSize: FetchPixels.getPixelHeight(18),
//                       ),
//                 ),
//                 getHorSpace(FetchPixels.getPixelWidth(20)),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // getHorSpace(FetchPixels.getPixelWidth(10)),
//                 // Icon(
//                 //   Icons.circle,
//                 //   size: FetchPixels.getPixelHeight(8),
//                 // ),
//                 getHorSpace(FetchPixels.getPixelWidth(20)),
//                 Text(
//                   "Huntings this Month:",
//                   style: R.textStyle
//                       .regularMetropolis()
//                       .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
//                 ),
//                 Spacer(),
//                 Text("${thisMonthHunts}",
//                     style: R.textStyle
//                         .mediumMetropolis()
//                         .copyWith(fontSize: FetchPixels.getPixelHeight(18))),
//                 getHorSpace(FetchPixels.getPixelWidth(20)),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // getHorSpace(FetchPixels.getPixelWidth(10)),
//                 // Icon(
//                 //   Icons.circle,
//                 //   size: FetchPixels.getPixelHeight(8),
//                 // ),
//                 getHorSpace(FetchPixels.getPixelWidth(20)),
//                 Text(
//                   "Previous Month:",
//                   style: R.textStyle
//                       .regularMetropolis()
//                       .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
//                 ),
//                 Spacer(),
//                 Text("${previousMonthHunts}",
//                     style: R.textStyle
//                         .mediumMetropolis()
//                         .copyWith(fontSize: FetchPixels.getPixelHeight(18))),
//                 getHorSpace(FetchPixels.getPixelWidth(20)),
//               ],
//             ),
//             Container(
//               margin: EdgeInsets.all(8),
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                   color: R.colors.containerBG.withOpacity(0.9),
//                   borderRadius: BorderRadius.circular(16)),
//               child: Column(
//                 children: [
//                   getAssetImage(R.images.firework,
//                       scale: FetchPixels.getPixelHeight(6)),
//                   getVerSpace(FetchPixels.getPixelHeight(10)),
//                   Text(
//                     "You have a very high performance this month, Congratulations!",
//                     textAlign: TextAlign.center,
//                     style: R.textStyle
//                         .mediumMetropolis()
//                         .copyWith(fontSize: FetchPixels.getPixelHeight(14)),
//                   )
//                 ],
//               ),
//             ),

//             Container(
//               height: FetchPixels.getPixelHeight(30),
//               width: FetchPixels.width,
//               color: R.colors.transparent,
//               child: Center(
//                   child: Text(
//                 "Your next order delivery fees will be on us",
//                 style: R.textStyle.regularMetropolis().copyWith(
//                       fontSize: FetchPixels.getPixelHeight(14),
//                     ),
//               )),
//             ),
//             // MyButton(
//             //     onTap: () {
//             //       Get.to(DashboardView());
//             //     },
//             //     buttonText: "Go to Dashboard")
//           ]),
//         ),
//       ),
//     );
//   }

//   getTotalHunts() async {
//     var provider = Provider.of<ProductProvider>(context, listen: false);
//     totalHunts = provider.earningsList
//         .where((element) =>
//             element.customerId == FirebaseAuth.instance.currentUser!.email)
//         .length;
//     setState(() {});
//   }

//   getThisMonthHunts() async {
//     var provider = Provider.of<ProductProvider>(context, listen: false);
//     var now = DateTime.now();
//     thisMonthHunts = provider.earningsList
//         .where((element) =>
//             element.customerId == FirebaseAuth.instance.currentUser!.email)
//         .where((element) => element.endDate!.toDate().month == now.month)
//         .length;
//     print("thisMonthBookings $thisMonthHunts");
//     setState(() {});
//   }

//   getPreviousMonthHunts() async {
//     var provider = Provider.of<ProductProvider>(context, listen: false);
//     var now = DateTime.now();
//     previousMonthHunts = provider.earningsList
//         .where((element) =>
//             element.customerId == FirebaseAuth.instance.currentUser!.email)
//         .where((element) => element.endDate!.toDate().month == now.month - 1)
//         .length;
//     print("previousMonthBookings $previousMonthHunts");
//     setState(() {});
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/resources/resources.dart';
import 'package:hunt_and_rent/widgets/my_button.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Contact Us'),
            Text(
              'Start earning by renting your collections!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildTextFormField(
                      label: 'Your Name*',
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildTextFormField(
                      label: 'Your Email*',
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextFormField(
                      label: 'Phone Number*',
                      controller: phoneNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildTextFormField(
                      label: 'Your Company',
                      controller: companyController,
                    ),
                  ),
                ],
              ),
              _buildTextFormField(
                label: 'Your Website',
                controller: websiteController,
              ),
              _buildTextFormField(
                label: 'Subject',
                controller: subjectController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: messageController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a message';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: _sendDataToFirestore,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getPixelWidth(20)),
                  height: FetchPixels.getPixelHeight(55),
                  width: FetchPixels.getPixelWidth(350),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: R.colors.theme1.withOpacity(0.3)),
                      // border: Border.all(color: R.colors.blackColor),
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(30)),
                      color: R.colors.theme),
                  child: Center(
                    child: Text(
                      'Send',
                      style: R.textStyle.mediumMetropolis().copyWith(
                          color: R.colors.buttonText,
                          fontSize: FetchPixels.getPixelHeight(18)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: UnderlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  Future<void> _sendDataToFirestore() async {
    if (_formKey.currentState!.validate()) {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('becomearenterrequest');

      await collection.add({
        'name': nameController.text,
        'email': emailController.text,
        'phoneNumber': phoneNumberController.text,
        'company': companyController.text,
        'website': websiteController.text,
        'subject': subjectController.text,
        'message': messageController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Optionally, clear the form fields after submitting the data
      nameController.clear();
      emailController.clear();
      phoneNumberController.clear();
      companyController.clear();
      websiteController.clear();
      subjectController.clear();
      messageController.clear();
    }
  }
}
