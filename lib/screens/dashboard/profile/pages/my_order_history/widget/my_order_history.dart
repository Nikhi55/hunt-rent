import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/dashboard/cart/model/cart_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/category_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/product_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/home/track_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../../base/resizer/fetch_pixels.dart';
import '../../../../../../base/widget_utils.dart';
import '../../../../../../resources/resources.dart';
import '../../../../../../widgets/my_button.dart';
import '../../../../../auth/provider/auth_provider.dart';

class MyOrderHistory extends StatelessWidget {
  MyOrderHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ProductProvider>(
      builder: (context, auth, pro, child) {
        return FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('placeOrder')
              .where('customer_id', isEqualTo: auth.userModel.email)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No orders found.'));
            }

            var orders = snapshot.data!.docs.map((doc) {
              return CartModel.fromJson(doc.data() as Map<String, dynamic>);
            }).toList();

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                var order = orders[index];
                var product = pro.products.firstWhere(
                    (product) => product.docId == order.productId,
                    orElse: () => ProductModel());

                return InkWell(
                  onTap: () {
                    Get.to(() => TrackOrder(
                          model: product,
                          index01: index,
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(FetchPixels.getPixelHeight(10)),
                    margin: EdgeInsets.symmetric(
                        vertical: FetchPixels.getPixelHeight(10)),
                    decoration: BoxDecoration(
                      border: Border.all(color: R.colors.containerBG),
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(10)),
                      color: R.colors.containerBG1.withOpacity(0.3),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: FetchPixels.getPixelHeight(150),
                          width: FetchPixels.getPixelWidth(130),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                FetchPixels.getPixelHeight(10)),
                            image: getDecorationNetworkImage(
                                context, product.productImage!.first,
                                fit: BoxFit.cover),
                            color: R.colors.blackColor,
                          ),
                        ),
                        getHorSpace(FetchPixels.getPixelWidth(10)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Text(product.productName ?? '',
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        softWrap: true,
                                        style: R.textStyle
                                            .mediumMetropolis()
                                            .copyWith(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize:
                                                    FetchPixels.getPixelHeight(
                                                        16))),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: FetchPixels.getPixelHeight(5),
                                      horizontal: FetchPixels.getPixelWidth(10),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          FetchPixels.getPixelHeight(8),
                                        ),
                                        color: Color.fromRGBO(84, 183, 84, 1)),
                                    child: Text(
                                      order.orderStatus!,
                                      style: R.textStyle
                                          .mediumMetropolis()
                                          .copyWith(
                                              fontSize:
                                                  FetchPixels.getPixelHeight(
                                                      12),
                                              color: R.colors.whiteColor),
                                    ),
                                  )
                                ],
                              ),
                              getVerSpace(FetchPixels.getPixelHeight(10)),
                              // order.orderStatus == OrderStatus.Completed.name
                              //     ? SizedBox()
                              //     : Container(
                              //         padding: EdgeInsets.symmetric(
                              //             vertical:
                              //                 FetchPixels.getPixelHeight(5),
                              //             horizontal:
                              //                 FetchPixels.getPixelWidth(10)),
                              //         decoration: BoxDecoration(
                              //             color: R.colors.transparent,
                              //             borderRadius: BorderRadius.circular(
                              //                 FetchPixels.getPixelHeight(5))),
                              //         child: Text(
                              //           "${order.endDate!.toDate().difference(order.startDate!.toDate()).inDays} days remaining",
                              //           style: R.textStyle
                              //               .regularMetropolis()
                              //               .copyWith(
                              //                   fontSize:
                              //                       FetchPixels.getPixelHeight(
                              //                           12)),
                              //         ),
                              //       ),
                              // getVerSpace(FetchPixels.getPixelHeight(10)),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Expanded(
                              //       flex: 1,
                              //       child: Column(
                              //         crossAxisAlignment: product.productType ==
                              //                     ProductsTypes.sell.name ||
                              //                 product.productType ==
                              //                     ProductsTypes.sold.name
                              //             ? CrossAxisAlignment.end
                              //             : CrossAxisAlignment.start,
                              //         children: [
                              //           product.productType ==
                              //                       ProductsTypes.sell.name ||
                              //                   product.productType ==
                              //                       ProductsTypes.sold.name
                              //               ? Text("Retail Price",
                              //                   style: R.textStyle
                              //                       .regularMetropolis()
                              //                       .copyWith(
                              //                           fontSize: FetchPixels
                              //                               .getPixelHeight(
                              //                                   12)))
                              //               : Text("Rental Price",
                              //                   style: R.textStyle
                              //                       .regularMetropolis()
                              //                       .copyWith(
                              //                           fontSize: FetchPixels
                              //                               .getPixelHeight(
                              //                                   12))),
                              //           getVerSpace(
                              //               FetchPixels.getPixelWidth(10)),
                              //           Text(
                              //             "QR ${order.productPrice}",
                              //             style: R.textStyle
                              //                 .semiBoldMetropolis()
                              //                 .copyWith(
                              //                   color: R.colors.theme,
                              //                   fontSize:
                              //                       FetchPixels.getPixelHeight(
                              //                           16),
                              //                 ),
                              //           )
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              getVerSpace(FetchPixels.getPixelHeight(10)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class MyOrderWidgets extends StatelessWidget {
  final ProductModel model;
  int? index;

  MyOrderWidgets({super.key, required this.model, this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ProductProvider>(
      builder: (context, auth, pro, child) {
        return Container(
          padding: EdgeInsets.all(FetchPixels.getPixelHeight(10)),
          margin:
              EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(10)),
          // height: FetchPixels.getPixelHeight(150),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(10)),
              color: R.colors.containerBG1),
          child: Row(children: [
            Container(
              height: FetchPixels.getPixelHeight(150),
              width: FetchPixels.getPixelWidth(130),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(10)),
                  image: getDecorationNetworkImage(
                      context, model.productImage!.first,
                      fit: BoxFit.cover),
                  color: R.colors.blackColor),
            ),
            getHorSpace(FetchPixels.getPixelWidth(15)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(model.productName ?? '',
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            softWrap: true,
                            style: R.textStyle.mediumMetropolis().copyWith(
                                overflow: TextOverflow.ellipsis,
                                fontSize: FetchPixels.getPixelHeight(16))),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                            vertical: FetchPixels.getPixelHeight(5),
                            horizontal: FetchPixels.getPixelWidth(10),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                FetchPixels.getPixelHeight(8),
                              ),
                              color: Color.fromRGBO(84, 183, 84, 1)),
                          child: Text(
                            pro.earningsList[index!].orderStatus.toString(),
                            style: R.textStyle.mediumMetropolis().copyWith(
                                fontSize: FetchPixels.getPixelHeight(12),
                                color: R.colors.whiteColor),
                          ))
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  pro.earningsList[index!].orderStatus.toString() ==
                          OrderStatus.Completed.name
                      ? SizedBox()
                      : Container(
                          padding: EdgeInsets.symmetric(
                              vertical: FetchPixels.getPixelHeight(5),
                              horizontal: FetchPixels.getPixelWidth(10)),
                          decoration: BoxDecoration(
                              color: R.colors.transparent,
                              borderRadius: BorderRadius.circular(
                                  FetchPixels.getPixelHeight(5))),
                          child: Text(
                            "${pro.earningsList[index!].endDate!.toDate().difference(pro.earningsList[index!].startDate!.toDate()).inDays} days remaining",
                            style: R.textStyle.regularMetropolis().copyWith(
                                fontSize: FetchPixels.getPixelHeight(12)),
                          ),
                        ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: model.productType ==
                                      ProductsTypes.sell.name ||
                                  model.productType == ProductsTypes.sold.name
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            model.productType == ProductsTypes.sell.name ||
                                    model.productType == ProductsTypes.sold.name
                                ? Text("Retail Price",
                                    style: R.textStyle
                                        .regularMetropolis()
                                        .copyWith(
                                            fontSize:
                                                FetchPixels.getPixelHeight(12)))
                                : Text("Rental Price",
                                    style: R.textStyle
                                        .regularMetropolis()
                                        .copyWith(
                                            fontSize:
                                                FetchPixels.getPixelHeight(
                                                    12))),
                            getVerSpace(FetchPixels.getPixelWidth(5)),
                            Text(
                              "QR ${model.productPrice!}",
                              style: R.textStyle.semiBoldMetropolis().copyWith(
                                    color: R.colors.theme1,
                                    fontSize: FetchPixels.getPixelHeight(16),
                                  ),
                            )
                          ],
                        ),
                      ),
                      // Expanded( flex: 1,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //     Text("Rental\nPrice",
                      //         style: R.textStyle
                      //             .regularMetropolis()
                      //             .copyWith(fontSize: FetchPixels.getPixelHeight(10))),
                      //     getVerSpace(FetchPixels.getPixelWidth(5)),
                      //     Text("QR${model.productPrice!}",
                      //         style: R.textStyle
                      //             .semiBoldMetropolis()
                      //             .copyWith(fontSize: FetchPixels.getPixelHeight(9)))
                      //   ],),
                      // ),
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: pro.isLoading == true
                  //       ? Center(
                  //           child: CircularProgressIndicator(
                  //           color: R.colors.theme,
                  //         ))
                  //       : MyButton(
                  //           color: R.colors.transparent,
                  //           textColor: R.colors.g1,
                  //           textSize: 12,
                  //           width: FetchPixels.getPixelWidth(110),
                  //           height: FetchPixels.getPixelHeight(30),
                  //           onTap: () async {
                  //             pro.startLoader();
                  //             var data = pro.earningsList[index!];
                  //             if (data.submitStatus == SubmitStatus.Yes.name) {
                  //               data.submitStatus = SubmitStatus.No.name;
                  //               await FirebaseFirestore.instance
                  //                   .collection("placeOrder")
                  //                   .doc(data.docId)
                  //                   .update(data.toJson());
                  //             } else {
                  //               data.submitStatus = SubmitStatus.Yes.name;
                  //               data.orderStatus == OrderStatus.Completed.name;
                  //               await FirebaseFirestore.instance
                  //                   .collection("placeOrder")
                  //                   .doc(data.docId)
                  //                   .update(data.toJson());
                  //             }
                  //             pro.getEarningRecord();
                  //             pro.stopLoader();
                  //             pro.update();

                  //             // if (isCart == true &&
                  //             //     auth.userModel.cart!.contains(model)) {
                  //             //   auth.userModel.cart!.remove(model);
                  //             //   auth.update();
                  //             // }
                  //           },
                  //           buttonText: pro.earningsList[index!].submitStatus
                  //                       .toString() ==
                  //                   SubmitStatus.No.name
                  //               ? "Submit"
                  //               : "Submitted"),
                  // ),
                ],
              ),
            )
          ]),
        );
      },
    );
  }
}
