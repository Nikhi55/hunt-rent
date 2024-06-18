import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/category_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/product_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../base/resizer/fetch_pixels.dart';
import '../../../../../base/widget_utils.dart';
import '../../../../../resources/resources.dart';
import '../../../../../widgets/my_button.dart';
import '../../../cart/model/cart_model.dart';
import '../widget/renter_product_widget.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductProvider, AuthProvider>(
      builder: (context, product, auth, child) {
        return Scaffold(
          appBar: AppBar(
              leading: Center(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: FetchPixels.getPixelHeight(22),
                    color: R.colors.whiteColor,
                  ),
                ),
              ),
              iconTheme: IconThemeData(
                color: R.colors.whiteColor, //change your color here
              ),
              automaticallyImplyLeading: false,
              backgroundColor: R.colors.theme,
              elevation: 0.0,
              title: Center(
                child: Text(
                  "Bookings",
                  style: R.textStyle.mediumMetropolis().copyWith(
                      color: R.colors.whiteColor,
                      fontSize: FetchPixels.getPixelHeight(18)),
                ),
              )),
          body: Container(
            padding:
                EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
            child: Column(
              // padding:
              // EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
              children: [
                // getVerSpace(FetchPixels.getPixelHeight(200)),
                // Text(
                //   "Today",
                //   style: R.textStyle
                //       .semiBoldMetropolis()
                //       .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                // ),
                product
                        .bookingsList
                        // .where((element) =>
                        //     element.email == auth.userModel.email)
                        .isEmpty
                    ? Center(
                        child: getAssetImage(
                        R.images.emptyBookings,
                        height: FetchPixels.getPixelHeight(250),
                        width: FetchPixels.getPixelWidth(250),
                      ))
                    : Expanded(
                        // alignment: Alignment.center,
                        child: ListView.builder(
                          itemCount: product
                              .bookingsList
                              // .where((element) =>
                              //     element.vendorId == auth.userModel.email)
                              .length,
                          itemBuilder: (context, index) {
                            print("hi");
                            CartModel model = product.bookingsList
                                // .where((element) =>
                                //     element.vendorId == auth.userModel.email)
                                .toList()[index];
                            return bookings(model, product);
                          },
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget bookings(CartModel model, ProductProvider pro) {
    print("jjej");
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: 60,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircularProfileAvatar(
            "",
            cacheImage: true,
            imageFit: BoxFit.fill,
            child: Image.network(
                pro.products
                        .where((element) => element.docId == model.productId)
                        .toList()[0]
                        .productImage!
                        .first ??
                    "",
                fit: BoxFit.fill),
            radius: 30,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  pro.products
                          .where((element) => element.docId == model.productId)
                          .toList()[0]
                          .productName ??
                      "",
                  style: R.textStyle.regularMetropolis().copyWith(
                        fontSize: FetchPixels.getPixelHeight(14),
                      ),
                ),
              ),
              Text(
                "\QR ${model.productPrice}",
                style: R.textStyle.mediumMetropolis().copyWith(
                      color: R.colors.theme,
                      fontSize: FetchPixels.getPixelHeight(14),
                    ),
              ),
            ],
          ),
          subtitle: Text(
            DateFormat('MMM dd yyyy | hh : mm a').format(model.endDate!),
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
