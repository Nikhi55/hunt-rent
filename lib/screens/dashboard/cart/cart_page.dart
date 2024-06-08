import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/base/widget_utils.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/dashboard_view.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/product_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:hunt_and_rent/widgets/my_button.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../resources/resources.dart';
import '../home/widgets/featured_product_widget.dart';
import 'check_out_pay.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  loc.Location location = loc.Location();
  bool? _serviceEnabled;
  loc.LocationData? _locationData;

  @override
  void initState() {
    var auth = Provider.of<AuthProvider>(context, listen: false);
    auth.getAllProductDoc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ProductProvider>(
      builder: (context, auth, pro, child) {
        // Debugging information
        print('Cart Doc List: ${auth.cartDocList}');
        print('Products: ${pro.products}');

        // Filtered products in the cart
        List<ProductModel> cartProducts = pro.products
            .where((element) => auth.cartDocList.contains(element.docId))
            .toList();

        return Scaffold(
          body: SizedBox(
            width: FetchPixels.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getVerSpace(FetchPixels.getPixelHeight(10)),
                Row(
                  children: [
                    getHorSpace(FetchPixels.getPixelWidth(10)),
                    InkWell(
                      onTap: () {
                        Get.offAll(() => DashboardView(
                              index: 0,
                            ));
                      },
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                      ),
                    ),
                    getHorSpace(FetchPixels.getPixelWidth(20)),
                    Center(
                      child: Text(
                        "My Basket",
                        style: R.textStyle.semiBoldMetropolis().copyWith(
                              fontSize: FetchPixels.getPixelHeight(16),
                            ),
                      ),
                    ),
                  ],
                ),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                cartProducts.isEmpty
                    ? Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getAssetImage(
                              R.images.Cartempty,
                              height: FetchPixels.getPixelHeight(100),
                              width: FetchPixels.getPixelWidth(100),
                            ),
                            Text('Your cart is empty'),
                            Text('Explore more and add some Items'),
                            getVerSpace(FetchPixels.getPixelHeight(10)),
                            MyButton(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return DashboardView(
                                      index: 1,
                                    );
                                  },
                                ));
                              },
                              buttonText: 'Start Shopping',
                            )
                          ],
                        ),
                      )
                    : Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: cartProducts.length,
                                padding: EdgeInsets.symmetric(
                                    horizontal: FetchPixels.getPixelWidth(20)),
                                itemBuilder: (context, index) {
                                  ProductModel model = cartProducts[index];
                                  return Column(
                                    children: [
                                      FeaturedWidget1(
                                        model: model,
                                        isCart: true,
                                        index1: index,
                                      ),
                                      Divider(
                                        height: 0,
                                        color: R.colors.theme.withOpacity(0.4),
                                        indent: 10,
                                        endIndent: 10,
                                      ),
                                      getVerSpace(
                                          FetchPixels.getPixelHeight(10)),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: FetchPixels.getPixelWidth(10),
                                  vertical: FetchPixels.getPixelHeight(10)),
                              child: MyButton(
                                onTap: () {
                                  if (cartProducts.isNotEmpty) {
                                    ProductModel model = cartProducts.first;
                                    Get.to(
                                      () => CheckOutPage(
                                        model: model,
                                      ),
                                    );
                                  }
                                },
                                buttonText: "CHECKOUT",
                                borderRadius: 40,
                                height: FetchPixels.getPixelHeight(50),
                                textSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  getLocationInfo() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }
    _locationData = await location.getLocation();
    var c = Provider.of<ProductProvider>(context, listen: false);
    c.lat = _locationData!.latitude.toString();
    c.lng = _locationData!.longitude.toString();
    print("lat ${c.lat} lng ${c.lng}");
    c.fetchLocationAddress();
    c.update();
  }
}
