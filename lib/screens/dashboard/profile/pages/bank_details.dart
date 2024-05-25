import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../resources/resources.dart';
import '../../../../utils/validator.dart';
import '../../../../widgets/my_button.dart';

class BankDetailsView extends StatefulWidget {
  const BankDetailsView({super.key});

  @override
  State<BankDetailsView> createState() => _BankDetailsViewState();
}

class _BankDetailsViewState extends State<BankDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        var formKey = GlobalKey();
        return Scaffold(
          appBar: AppBar(
              leading: Center(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: R.colors.blackColor,
                  ),
                ),
              ),
              iconTheme: IconThemeData(
                color: R.colors.whiteColor, //change your color here
              ),
              automaticallyImplyLeading: false,
              backgroundColor: R.colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                "Bank Account Details ",
                style: R.textStyle.semiBoldMetropolis().copyWith(
                      fontSize: FetchPixels.getPixelHeight(16),
                    ),
              )),
          body: getPaddingWidget(
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
            SingleChildScrollView(
              child: Form(
                key: formKey = GlobalKey(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getVerSpace(FetchPixels.getPixelHeight(20)),
                      Text(
                        "This information is needed for us to transfer payments to your bank account.",
                        textAlign: TextAlign.start,
                        style: R.textStyle
                            .regularMetropolis()
                            .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                      ),
                      // getVerSpace(FetchPixels.getPixelHeight(20)),
                      // Text(
                      //   "Account Number",
                      //   textAlign: TextAlign.start,
                      //   style: R.textStyle.regularMetropolis().copyWith(
                      //       color: R.colors.theme,
                      //       fontSize: FetchPixels.getPixelHeight(14)),
                      // ),
                      // getVerSpace(FetchPixels.getPixelHeight(5)),
                      // TextFormField(
                      //   cursorColor: R.colors.theme.withOpacity(0.3),
                      //   controller: null,
                      //   style: R.textStyle.mediumMetropolis().copyWith(
                      //       height: 1,
                      //       fontSize: FetchPixels.getPixelHeight(14),
                      //       color: R.colors.theme),
                      //   keyboardType: TextInputType.emailAddress,
                      //   autovalidateMode: AutovalidateMode.onUserInteraction,
                      //   textInputAction: TextInputAction.next,
                      //   validator: (value) =>
                      //       FieldValidator.validateFullName(value!),
                      //   decoration: InputDecoration(
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(10))),
                      // ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      Text(
                        "Account Number",
                        textAlign: TextAlign.start,
                        style: R.textStyle.regularMetropolis().copyWith(
                            color: R.colors.theme,
                            fontSize: FetchPixels.getPixelHeight(14)),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      TextFormField(
                        cursorColor: R.colors.theme.withOpacity(0.3),
                        controller: null,
                        style: R.textStyle.mediumMetropolis().copyWith(
                            height: 1,
                            fontSize: FetchPixels.getPixelHeight(14),
                            color: R.colors.theme),
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            FieldValidator.validateFullName(value!),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      Text(
                        "IBAN Number",
                        textAlign: TextAlign.start,
                        style: R.textStyle.regularMetropolis().copyWith(
                            color: R.colors.theme,
                            fontSize: FetchPixels.getPixelHeight(14)),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      TextFormField(
                        cursorColor: R.colors.theme.withOpacity(0.3),
                        controller: null,
                        style: R.textStyle.mediumMetropolis().copyWith(
                            height: 1,
                            fontSize: FetchPixels.getPixelHeight(14),
                            color: R.colors.theme),
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            FieldValidator.validateFullName(value!),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      Text(
                        "Swift Code ",
                        textAlign: TextAlign.start,
                        style: R.textStyle.regularMetropolis().copyWith(
                            color: R.colors.theme,
                            fontSize: FetchPixels.getPixelHeight(14)),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      TextFormField(
                        cursorColor: R.colors.theme.withOpacity(0.3),
                        controller: null,
                        style: R.textStyle.mediumMetropolis().copyWith(
                            height: 1,
                            fontSize: FetchPixels.getPixelHeight(14),
                            color: R.colors.theme),
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            FieldValidator.validateFullName(value!),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      Text(
                        "Bank Address",
                        textAlign: TextAlign.start,
                        style: R.textStyle.regularMetropolis().copyWith(
                            color: R.colors.theme,
                            fontSize: FetchPixels.getPixelHeight(14)),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      TextFormField(
                        cursorColor: R.colors.theme.withOpacity(0.3),
                        controller: null,
                        style: R.textStyle.mediumMetropolis().copyWith(
                            height: 1,
                            fontSize: FetchPixels.getPixelHeight(14),
                            color: R.colors.theme),
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            FieldValidator.validateFullName(value!),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      Text(
                        "Your Address",
                        textAlign: TextAlign.start,
                        style: R.textStyle.regularMetropolis().copyWith(
                            color: R.colors.theme,
                            fontSize: FetchPixels.getPixelHeight(14)),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      TextFormField(
                        cursorColor: R.colors.theme.withOpacity(0.3),
                        controller: null,
                        style: R.textStyle.mediumMetropolis().copyWith(
                            height: 1,
                            fontSize: FetchPixels.getPixelHeight(14),
                            color: R.colors.theme),
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            FieldValidator.validateFullName(value!),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      Row(
                        children: [
                          SizedBox(
                            child: Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: R.colors.fillColor)),
                                child: Icon(
                                    color: R.colors.fillColor,
                                    size: 30,
                                    Icons.add_a_photo)),
                            height: 100,
                            width: 100,
                          ),
                          Expanded(
                            child: Text(
                              "Please upload a clear image of your IBAN Certificate for a smooth transfer of payments.",
                              textAlign: TextAlign.start,
                              style: R.textStyle.regularMetropolis().copyWith(
                                  color: R.colors.theme,
                                  fontSize: FetchPixels.getPixelHeight(12)),
                            ),
                          ),
                        ],
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(30)),
                      Align(
                          alignment: Alignment.center,
                          child: MyButton(
                              borderRadius: 50,
                              textSize: 16,
                              onTap: () {},
                              buttonText: "Save")),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
