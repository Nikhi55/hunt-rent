import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hunt_and_rent/screens/auth/model/user_model.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/cart/cardDetails.dart';
import 'package:hunt_and_rent/screens/dashboard/cart/payment_config.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../resources/resources.dart';
import '../../../widgets/my_button.dart';
import '../home/model/product_model.dart';
import '../home/widgets/featured_product_widget.dart';

class CheckOutPage extends StatefulWidget {
  final ProductModel model;
  CheckOutPage({super.key, required this.model});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  List<String> paymentImages = [
    R.images.cardLogo,
    R.images.credit,
    R.images.cash,
    R.images.huntPay,
  ];
  List<String> payName = [
    "Debit/MasterCard",
    "Pay With Google Pay/Apple Pay",
    "Cash on Delivery",
  ];
  int currentPay = 0;
  int currentSelected = 0;
  var total = 0;
  double selectedTip = 0.0;

  // @override
  // void initState() {
  //   super.initState();
  //   addTotalValue();
  // }

  // void addTotalValue() {
  //   final pro = Provider.of<ProductProvider>(context, listen: false);
  //   double initialPrice = double.parse(pro.totalPrice.toString());
  //   pro.setTotalPrice(initialPrice);
  // }

  String os = Platform.operatingSystem;
  var applePayButton = ApplePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
    paymentItems: const [
      PaymentItem(
        label: 'Item A',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      ),
      PaymentItem(
        label: 'Item B',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      ),
      PaymentItem(
        label: 'Total',
        amount: '0.02',
        status: PaymentItemStatus.final_price,
      )
    ],
    style: ApplePayButtonStyle.black,
    width: double.infinity,
    height: 50,
    type: ApplePayButtonType.buy,
    margin: const EdgeInsets.only(top: 15.0),
    onPaymentResult: (result) => debugPrint('Payment Result $result'),
    loadingIndicator: const Center(
      child: CircularProgressIndicator(),
    ),
  );

  var googlePayButton = GooglePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
    paymentItems: const [
      PaymentItem(
        label: 'Total',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      )
    ],
    type: GooglePayButtonType.pay,
    margin: const EdgeInsets.only(top: 15.0),
    onPaymentResult: (result) => debugPrint('Payment Result $result'),
    loadingIndicator: const Center(
      child: CircularProgressIndicator(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductProvider, AuthProvider>(
        builder: (context, pro, auth, child) {
      // int totalValue = 0;
      // for (var product in pro.products
      //     .where((element) => auth.cartDocList.contains(element.docId))) {
      //   totalValue += int.parse(product.productPrice!);
      // }
      // double? totalPrice = auth.userModel.cart!
      //     .firstWhere((element) => element.productId == widget.model.docId,
      //         orElse: () => UserCart(
      //               startDate: Timestamp.now(),
      //               endDate: Timestamp.now(),
      //               productId: widget.model.docId,
      //               price: double.tryParse(widget.model.productPrice!) ?? 0.0,
      //             ))
      //     .price;
      // double totalPrice = widget.totalPrice;
      double totalPrice = 0.0;
      for (var cartItem in auth.userModel.cart!) {
        var product = pro.products
            .firstWhere((element) => element.docId == cartItem.productId);
        totalPrice += double.parse(product.productPrice!);
      }
      return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              size: FetchPixels.getPixelHeight(25),
              color: R.colors.blackColor,
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
            "Checkout",
            style: R.textStyle.mediumMetropolis().copyWith(
                  fontSize: FetchPixels.getPixelHeight(18),
                ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: pro.products
                    .where(
                        (element) => auth.cartDocList.contains(element.docId))
                    .length,
                padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelWidth(10),
                ),
                itemBuilder: (context, index) {
                  ProductModel model = pro.products
                      .where(
                          (element) => auth.cartDocList.contains(element.docId))
                      .toList()[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: R.colors.fillColor),
                    ),
                    borderOnForeground: true,
                    color: R.colors.whiteColor,
                    elevation: 0.4,
                    shadowColor: R.colors.containerBG1,
                    child: FeaturedWidget1(
                      model: model,
                      isCart: true,
                      index1: index,
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: R.colors.fillColor),
                  ),
                  borderOnForeground: true,
                  color: R.colors.whiteColor,
                  elevation: 0.4,
                  shadowColor: R.colors.containerBG1,
                  child: ListView(
                    primary: true,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getPixelWidth(10),
                    ),
                    children: [
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: getAssetImage(R.images.locationIcon,
                            scale: FetchPixels.getPixelHeight(3)),
                        title: Text(
                          "My Home Address",
                          style: R.textStyle.mediumMetropolis().copyWith(
                              fontSize: FetchPixels.getPixelHeight(16)),
                        ),
                        subtitle: Text(
                          "${pro.locationAddress}",
                          style: R.textStyle.regularMetropolis().copyWith(
                              fontSize: FetchPixels.getPixelHeight(12)),
                        ),
                      ),
                      // ListTile(
                      //   contentPadding: EdgeInsets.zero,
                      //   leading: getAssetImage(R.images.locationIcon,
                      //       scale: FetchPixels.getPixelHeight(3)),
                      //   title: TextFormField(
                      //     autovalidateMode: AutovalidateMode.always,
                      //     validator: (value) {},
                      //     scribbleEnabled: true,
                      //     textAlign: TextAlign.start,
                      //     decoration: InputDecoration(
                      //       contentPadding:
                      //           EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      //       label: Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      //         child: Text(
                      //           'Enter Your Adress',
                      //           style: R.textStyle.regularMetropolis().copyWith(
                      //               fontSize: FetchPixels.getPixelHeight(14)),
                      //         ),
                      //       ),
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(25)),
                      //       isCollapsed: true,
                      //     ),
                      //   ),
                      // ),
                      Container(
                        height: FetchPixels.getPixelHeight(250),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Consumer<ProductProvider>(
                            builder: (context, pro, child) {
                              double lat = double.tryParse(pro.lat) ?? 0.0;
                              double lng = double.tryParse(pro.lng) ?? 0.0;
                              return GoogleMap(
                                initialCameraPosition: CameraPosition(
                                    target: LatLng(lat, lng), zoom: 11),
                                mapType: MapType.normal,
                                scrollGesturesEnabled: true,
                                zoomControlsEnabled: true,
                                zoomGesturesEnabled: true,
                                myLocationEnabled: true,
                                myLocationButtonEnabled: true,
                                onTap: (latLng) {
                                  pro.lat = latLng.latitude.toString();
                                  pro.lng = latLng.longitude.toString();
                                  pro.markers.clear();
                                  pro.markers.add(
                                    Marker(
                                      markerId: MarkerId('marker_1'),
                                      position: LatLng(
                                          latLng.latitude, latLng.longitude),
                                      infoWindow: InfoWindow(
                                          title: "${pro.locationAddress}"),
                                      icon:
                                          BitmapDescriptor.defaultMarkerWithHue(
                                              BitmapDescriptor.hueViolet),
                                    ),
                                  );
                                  pro.fetchLocationAddress();
                                  // pro.notifyListeners();
                                },
                                onMapCreated: (GoogleMapController controller) {
                                  // _controller.complete(controller);
                                },
                                markers: Set<Marker>.of(pro.markers),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListView(
                primary: true,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelWidth(10)),
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: R.colors.fillColor)),
                    borderOnForeground: true,
                    color: R.colors.whiteColor,
                    elevation: 0.4,
                    shadowColor: R.colors.containerBG1,
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          leading: getAssetImage(R.images.clock,
                              scale: FetchPixels.getPixelHeight(3)),
                          title: Text(
                            "Within 1 Day",
                            style: R.textStyle.mediumMetropolis().copyWith(
                                fontSize: FetchPixels.getPixelHeight(16)),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          leading: getAssetImage(R.images.reward,
                              scale: FetchPixels.getPixelHeight(3)),
                          title: Text(
                            "Reward your rider with a tip",
                            style: R.textStyle.mediumMetropolis().copyWith(
                                fontSize: FetchPixels.getPixelHeight(16)),
                          ),
                          subtitle: Text(
                            "Your rider keeps 100% of the tips",
                            style: R.textStyle.regularMetropolis().copyWith(
                                color: R.colors.blackColor.withOpacity(0.6),
                                fontSize: FetchPixels.getPixelHeight(12)),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          title: Text(
                            "If you want to give tips on your rider?",
                            style: R.textStyle.regularMetropolis().copyWith(
                                color: R.colors.theme,
                                fontSize: FetchPixels.getPixelHeight(14)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                            bottom: 8.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildTipContainer(5.0),
                              _buildTipContainer(10.0),
                              _buildTipContainer(15.0),
                              _buildTipContainer(15.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // getVerSpace(FetchPixels.getPixelHeight(10)),
                  // Text(
                  //   "Pay with",
                  //   style: R.textStyle
                  //       .mediumMetropolis()
                  //       .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                  // ),
                  // getVerSpace(FetchPixels.getPixelHeight(10)),
                  // Column(
                  //   children: List.generate(3, (index) {
                  //     return pay(index);
                  //   }),
                  // ),
                  // getVerSpace(FetchPixels.getPixelHeight(10)),
                  // Text(
                  //   "Items Summary",
                  //   style: R.textStyle
                  //       .semiBoldMetropolis()
                  //       .copyWith(fontSize: FetchPixels.getPixelHeight(18)),
                  // ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: List.generate(
                  //       pro.products
                  //           .where((element) =>
                  //               auth.cartDocList.contains(element.docId))
                  //           .length, (index) {
                  //     ProductModel model = pro.products
                  //         .where((element) =>
                  //             auth.cartDocList.contains(element.docId))
                  //         .toList()[index];
                  //     return Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: Row(
                  //         children: [
                  //           Text(
                  //             "${index + 1} : ",
                  //             style: R.textStyle.regularMetropolis().copyWith(
                  //                 fontSize: FetchPixels.getPixelHeight(15)),
                  //           ),
                  //           Text(
                  //             "${model.productName}",
                  //             style: R.textStyle.regularMetropolis().copyWith(
                  //                 fontSize: FetchPixels.getPixelHeight(15)),
                  //           ),
                  //           Spacer(),
                  //           Text(
                  //             "QR ${model.productPrice}",
                  //             style: R.textStyle.regularMetropolis().copyWith(
                  //                 fontSize: FetchPixels.getPixelHeight(15)),
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   }),
                  // ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: R.colors.fillColor)),
                    borderOnForeground: true,
                    color: R.colors.whiteColor,
                    elevation: 0.4,
                    shadowColor: R.colors.containerBG1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Payment Summary",
                              style: R.textStyle.mediumMetropolis().copyWith(
                                  fontSize: FetchPixels.getPixelHeight(16)),
                            ),
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(10)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Basket Total",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                              Text(
                                "QR \$${totalPrice.toStringAsFixed(2)}",
                                style: R.textStyle.mediumMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                            ],
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery Fee",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                              Text(
                                "QR 10.00",
                                style: R.textStyle.mediumMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(15)),
                              ),
                            ],
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Dry Cleaning Fee",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                              Text(
                                "QR 5.00",
                                style: R.textStyle.mediumMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                            ],
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(20)),
                          DottedLine(
                            dashLength: 11,
                            lineThickness: 2,
                            dashColor: R.colors.fillColor,
                          ),
                          Container(
                            // padding: EdgeInsets.symmetric(
                            //     horizontal: FetchPixels.getPixelWidth(10)),
                            height: FetchPixels.getPixelHeight(50),
                            width: FetchPixels.width,
                            decoration: BoxDecoration(
                                color: R.colors.whiteColor,
                                borderRadius: BorderRadius.circular(
                                    FetchPixels.getPixelHeight(5))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Amount",
                                  style: R.textStyle
                                      .mediumMetropolis()
                                      .copyWith(
                                          fontSize:
                                              FetchPixels.getPixelHeight(16)),
                                ),
                                Text(
                                  "QR ${totalPrice! + 15 + selectedTip}",
                                  style: R.textStyle
                                      .semiBoldMetropolis()
                                      .copyWith(
                                          color: R.colors.theme,
                                          fontSize:
                                              FetchPixels.getPixelHeight(17)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "By placing the order you agree to the Credit Card Payment Terms and Conditions.",
                            style: R.textStyle.regularMetropolis().copyWith(
                                fontSize: FetchPixels.getPixelHeight(12),
                                color: R.colors.blackColor.withOpacity(0.5)),
                          ),
                          TextSpan(
                            text: "Terms and Conditions",
                            style: R.textStyle.regularMetropolis().copyWith(
                                fontSize: FetchPixels.getPixelHeight(14),
                                color: R.colors.theme),
                          ),
                        ],
                      ),
                    ),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  MyButton(
                    // onTap: () {
                    //   if (currentPay == 0) {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) {
                    //           return FatoraPay(
                    //             currencyCode: 'QAR',
                    //             // Pass your desired values here
                    //             amount: total + 15,
                    //             customerEmail: '${auth.userModel.email}',
                    //             customerName: '${auth.userModel.userName}',
                    //             customerPhone: '1234567890',
                    //             customerCountry: 'LK',
                    //             lang: 'en',
                    //             note: 'This is a test note',
                    //           );
                    //         },
                    //       ),
                    //     );
                    //   } else {
                    //     Get.dialog(
                    //       OnTapFunctionDialog(
                    //         onTap: () async {
                    //           for (int i = 0;
                    //               i < auth.userModel.cart!.length;
                    //               i++) {
                    //             CartModel cartModel = CartModel(
                    //               productId: auth.userModel.cart![i].productId,
                    //               docId: "",
                    //               productPrice: pro.products
                    //                   .where((element) =>
                    //                       element.docId == auth.cartDocList[i])
                    //                   .first
                    //                   .productPrice,
                    //               customerId: auth.userModel.email,
                    //               customerName: auth.userModel.userName,
                    //               vendorId: pro.products
                    //                   .where((element) =>
                    //                       element.docId == auth.cartDocList[i])
                    //                   .first
                    //                   .email,
                    //               startDate: auth.userModel.cart![i].startDate!,
                    //               endDate: auth.userModel.cart![i].endDate!,
                    //               orderStatus: OrderStatus.Active.name,
                    //               submitStatus: "",
                    //             );
                    //             await FirebaseFirestore.instance
                    //                 .collection("placeOrder")
                    //                 .add(cartModel.toJson())
                    //                 .then((value) async {
                    //               await FirebaseFirestore.instance
                    //                   .collection("placeOrder")
                    //                   .doc(value.id)
                    //                   .update({"doc_id": value.id});
                    //             });
                    //             if (pro.products
                    //                     .where((element) => auth.cartDocList
                    //                         .contains(element.docId))
                    //                     .toList()[i]
                    //                     .productType ==
                    //                 ProductsTypes.sell.name) {
                    //               await FirebaseFirestore.instance
                    //                   .collection("products")
                    //                   .doc(auth.userModel.cart![i].productId)
                    //                   .update({
                    //                 "product_type": ProductsTypes.sold.name
                    //               });
                    //             } else {
                    //               await FirebaseFirestore.instance
                    //                   .collection("products")
                    //                   .doc(auth.userModel.cart![i].productId)
                    //                   .update({
                    //                 "product_type": ProductsTypes.rented.name
                    //               });
                    //             }
                    //           }
                    //           auth.userModel.cart!.clear();
                    //           auth.updateUser(auth.userModel);
                    //           pro.getEarningRecord();
                    //           Get.toNamed(Routes.paymentDetails);
                    //         },
                    //         text: "Are You Sure You Want to Place Your Order?",
                    //         headingText: "Order Place!",
                    //       ),
                    //     );
                    //   }
                    // },
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(),
                        ),
                      );
                    },
                    buttonText: "Place Your Order",
                  ),
                  getVerSpace(
                    FetchPixels.getPixelHeight(30),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTipContainer(double tipAmount) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTip = tipAmount;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: selectedTip == tipAmount
              ? R.colors.theme1
              : R.colors.containerBG1,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "QR $tipAmount",
          style: R.textStyle.mediumMetropolis().copyWith(
              fontSize: FetchPixels.getPixelHeight(14),
              color: selectedTip == tipAmount
                  ? R.colors.whiteColor
                  : R.colors.blackColor),
        ),
      ),
    );
  }

  tip(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: FetchPixels.getPixelHeight(35),
        width: FetchPixels.getPixelWidth(100),
        decoration: BoxDecoration(
            color: R.colors.containerBG,
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(5))),
        child: Center(
            child: Text(
          index == 0
              ? "QR 5"
              : index == 1
                  ? "QR 10"
                  : "Others",
          style: R.textStyle.regularMetropolis().copyWith(
              fontSize: FetchPixels.getPixelHeight(16),
              color: R.colors.blackColor),
        )),
      ),
    );
  }

  pay(index) {
    return getPaddingWidget(
      EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(8)),
      InkWell(
        onTap: () {
          currentPay = index;
          print(currentPay);
          setState(() {});
        },
        child: Container(
          height: FetchPixels.getPixelHeight(50),
          padding:
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(10)),
          decoration: BoxDecoration(
              color: R.colors.containerBG1,
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(9))),
          child: Row(
            children: [
              Container(
                height: FetchPixels.getPixelHeight(25),
                width: FetchPixels.getPixelWidth(25),
                decoration: BoxDecoration(
                    color: R.colors.whiteColor, shape: BoxShape.circle),
                child: Center(
                  child: Container(
                    height: FetchPixels.getPixelHeight(15),
                    width: FetchPixels.getPixelWidth(15),
                    decoration: BoxDecoration(
                        color: currentPay == index
                            ? R.colors.theme
                            : R.colors.whiteColor,
                        shape: BoxShape.circle),
                  ),
                ),
              ),
              getHorSpace(FetchPixels.getPixelWidth(10)),
              getAssetImage(paymentImages[index],
                  scale: FetchPixels.getPixelHeight(4)),
              getHorSpace(FetchPixels.getPixelWidth(10)),
              Text(
                payName[index],
                style: R.textStyle
                    .regularMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
