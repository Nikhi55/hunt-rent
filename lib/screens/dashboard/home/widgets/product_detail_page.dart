import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/base/widget_utils.dart';
import 'package:hunt_and_rent/forum/cpmments_view.dart';
import 'package:hunt_and_rent/forum/forum_page.dart';
import 'package:hunt_and_rent/forum/model/forum_model.dart';
import 'package:hunt_and_rent/forum/widget/post_widget.dart';
import 'package:hunt_and_rent/screens/auth/model/user_model.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/dashboard_view.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:hunt_and_rent/widgets/my_button.dart';
import 'package:hunt_and_rent/widgets/table_calender.dart';
import 'package:hunt_and_rent/widgets/utils.dart';

// import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../resources/resources.dart';
import '../model/product_model.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel model;
  bool? isCart;

  ProductDetails({super.key, required this.model, this.isCart});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List<int> dates = [1, 3, 7, 14];
  double totalPrice = 0.0;
  TextEditingController postCT = TextEditingController();
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    // Initialize totalPrice in provider
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    double initialPrice = double.tryParse(widget.model.productPrice!) ?? 0.0;
    productProvider.setTotalPrice(initialPrice);
  }

  void onDatesSelected(List<DateTime> dates, double price) {
    setState(() {
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.setTotalPrice(price);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ProductProvider>(
      builder: (context, auth, pro, child) {
        double totalPrice = pro.totalPrice;
        return Scaffold(
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("forum_room_chat")
                .snapshots(),
            builder: (context, snapshot) {
              List<QueryDocumentSnapshot> query = snapshot.data!.docs;
              List<ForumChatRoomModel> forumChatRoomModel = query
                  .map((e) => ForumChatRoomModel.fromJson(
                      e.data() as Map<String, dynamic>))
                  .toList();
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: R.colors.transparent,
                    expandedHeight: FetchPixels.getPixelHeight(320),
                    pinned: true,
                    floating: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: CarouselSlider(
                        items: List.generate(
                          widget.model.productImage!.length,
                          (index) {
                            return Container(
                              width: FetchPixels.width,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    widget.model.productImage![index],
                                    maxWidth: FetchPixels.width.toInt(),
                                    maxHeight:
                                        FetchPixels.getPixelHeight(450).toInt(),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        options: CarouselOptions(
                          pageSnapping: true,
                          height: FetchPixels.getPixelHeight(350),
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.ease,
                          // enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          onPageChanged: (index, reason) {
                            // Timer(Duration(milliseconds: 22));
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: FetchPixels.getPixelWidth(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: FetchPixels.getPixelHeight(20)),
                              Row(
                                children: [
                                  Text(
                                    widget.model.productName ?? "Not found",
                                    style: R.textStyle
                                        .mediumMetropolis()
                                        .copyWith(
                                            fontSize:
                                                FetchPixels.getPixelHeight(18)),
                                  ),
                                ],
                              ),
                              SizedBox(height: FetchPixels.getPixelHeight(10)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: FetchPixels.getPixelHeight(10),
                                      horizontal: FetchPixels.getPixelWidth(10),
                                    ),
                                    decoration: BoxDecoration(
                                      color: R.colors.transparent,
                                      borderRadius: BorderRadius.circular(
                                        FetchPixels.getPixelHeight(5),
                                      ),
                                    ),
                                    child: Text(
                                      widget.model.productBrand!,
                                      style: R.textStyle
                                          .regularMetropolis()
                                          .copyWith(
                                              fontSize:
                                                  FetchPixels.getPixelHeight(
                                                      12),
                                              color: R.colors.theme),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "QR $totalPrice",
                                    style: R.textStyle
                                        .semiBoldMetropolis()
                                        .copyWith(
                                            color: R.colors.theme,
                                            fontSize:
                                                FetchPixels.getPixelHeight(20)),
                                  ),
                                  SizedBox(
                                      width: FetchPixels.getPixelWidth(10)),
                                ],
                              ),
                              Divider(),
                              SizedBox(height: FetchPixels.getPixelHeight(5)),
                              Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Select Colour",
                                        style: R.textStyle
                                            .mediumMetropolis()
                                            .copyWith(
                                                color: R.colors.fillColor,
                                                fontSize:
                                                    FetchPixels.getPixelHeight(
                                                        14)),
                                      ),
                                      SizedBox(
                                          height:
                                              FetchPixels.getPixelHeight(5)),
                                      Row(
                                        children: List.generate(
                                          widget.model.productColors!.length,
                                          (index) {
                                            return InkWell(
                                              onTap: () {
                                                auth.selectedColor = index;
                                                auth.update();
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(
                                                  FetchPixels.getPixelHeight(5),
                                                ),
                                                height:
                                                    FetchPixels.getPixelHeight(
                                                        28),
                                                width:
                                                    FetchPixels.getPixelWidth(
                                                        28),
                                                decoration: BoxDecoration(
                                                  color: Color(int.parse(widget
                                                      .model
                                                      .productColors![index])),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.check,
                                                    color: auth.selectedColor ==
                                                            index
                                                        ? R.colors.whiteColor
                                                        : R.colors.transparent,
                                                    size: FetchPixels
                                                        .getPixelHeight(18),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Select Size",
                                        style: R.textStyle
                                            .mediumMetropolis()
                                            .copyWith(
                                                color: R.colors.fillColor,
                                                fontSize:
                                                    FetchPixels.getPixelHeight(
                                                        14)),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: FetchPixels.getPixelHeight(28),
                                        width: FetchPixels.getPixelWidth(28),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: R.colors.containerBG1),
                                        child: Center(
                                          child: Text(
                                            'EU',
                                            style: R.textStyle
                                                .regularMetropolis()
                                                .copyWith(
                                                  fontSize: FetchPixels
                                                      .getPixelHeight(12),
                                                ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: FetchPixels.getPixelHeight(50),
                                    width: FetchPixels.getPixelWidth(200),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          widget.model.productSize!.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            auth.selectedSize = index;
                                            auth.update();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(
                                                FetchPixels.getPixelHeight(5)),
                                            height:
                                                FetchPixels.getPixelHeight(28),
                                            width:
                                                FetchPixels.getPixelWidth(28),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: R.colors.theme
                                                      .withOpacity(0.5)),
                                              shape: BoxShape.circle,
                                              color: auth.selectedSize == index
                                                  ? R.colors.theme
                                                  : R.colors.whiteColor,
                                            ),
                                            child: Center(
                                              child: Text(
                                                getInitials(widget
                                                    .model.productSize![index]
                                                    .toString()
                                                    .toUpperCase()),
                                                style: R.textStyle
                                                    .regularMetropolis()
                                                    .copyWith(
                                                      fontSize: FetchPixels
                                                          .getPixelHeight(12),
                                                      color:
                                                          auth.selectedSize ==
                                                                  index
                                                              ? R.colors
                                                                  .whiteColor
                                                              : R.colors.theme,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              SizedBox(height: FetchPixels.getPixelHeight(5)),
                              Text(
                                "Description",
                                style: R.textStyle.mediumMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(18)),
                              ),
                              SizedBox(height: FetchPixels.getPixelHeight(5)),
                              Text(
                                widget.model.productDescription!,
                                style: R.textStyle.regularMetropolis().copyWith(
                                    color: R.colors.blackColor.withOpacity(0.7),
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                              SizedBox(height: FetchPixels.getPixelHeight(10)),
                              widget.isCart != null
                                  ? SizedBox()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        widget.model.productType == "sell"
                                            ? SizedBox()
                                            : Text(
                                                "Booking Date",
                                                style: R.textStyle
                                                    .mediumMetropolis()
                                                    .copyWith(
                                                      fontSize: FetchPixels
                                                          .getPixelHeight(
                                                        18,
                                                      ),
                                                    ),
                                              ),
                                        // SizedBox(
                                        //     height: FetchPixels.getPixelHeight(5)),
                                        SizedBox(
                                            height:
                                                FetchPixels.getPixelHeight(10)),
                                        widget.model.productType == "sell"
                                            ? SizedBox()
                                            : SizedBox(
                                                height:
                                                    FetchPixels.getPixelHeight(
                                                        420),
                                                child: CalendarScreen(
                                                  productPrice: totalPrice,
                                                  onDatesSelected:
                                                      onDatesSelected,
                                                ),
                                              ),
                                        Divider(),
                                        // ForumView(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Ratings & Reviews",
                                              style: R.textStyle
                                                  .mediumMetropolis()
                                                  .copyWith(
                                                      color:
                                                          R.colors.blackColor,
                                                      fontSize: FetchPixels
                                                          .getPixelHeight(22)),
                                            ),
                                            IconButton.outlined(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  enableDrag: false,
                                                  context: context,
                                                  builder: (context) =>
                                                      Container(
                                                    height: FetchPixels
                                                        .getPixelHeight(500),
                                                    padding: EdgeInsets.all(16),
                                                    child: Column(
                                                      children: [
                                                        getPaddingWidget(
                                                          EdgeInsets.only(
                                                              left: FetchPixels
                                                                  .getPixelWidth(
                                                                      20),
                                                              right: FetchPixels
                                                                  .getPixelWidth(
                                                                      20)),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                  "Create new forum",
                                                                  style: R
                                                                      .textStyle
                                                                      .semiBoldMetropolis()
                                                                      .copyWith(
                                                                          color: R
                                                                              .colors
                                                                              .blackColor,
                                                                          fontSize:
                                                                              FetchPixels.getPixelHeight(16))),
                                                              Spacer(),
                                                              SizedBox(
                                                                height: FetchPixels
                                                                    .getPixelHeight(
                                                                        20),
                                                                width: FetchPixels
                                                                    .getPixelWidth(
                                                                        20),
                                                                child: Checkbox(
                                                                  activeColor: R
                                                                      .colors
                                                                      .theme,
                                                                  value:
                                                                      isChecked,
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      isChecked =
                                                                          !isChecked;
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              getHorSpace(
                                                                  FetchPixels
                                                                      .getPixelWidth(
                                                                          10)),
                                                              Text(
                                                                  "Anonymous Post",
                                                                  style: R
                                                                      .textStyle
                                                                      .regularMetropolis()
                                                                      .copyWith(
                                                                          color: R
                                                                              .colors
                                                                              .blackColor,
                                                                          fontSize:
                                                                              FetchPixels.getPixelHeight(13))),
                                                            ],
                                                          ),
                                                        ),
                                                        getVerSpace(FetchPixels
                                                            .getPixelWidth(20)),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                                  FetchPixels
                                                                      .getPixelWidth(
                                                                          15)),
                                                          width:
                                                              FetchPixels.width,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: R.colors
                                                                .containerBG,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    FetchPixels
                                                                        .getPixelHeight(
                                                                            10)),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              getVerSpace(
                                                                  FetchPixels
                                                                      .getPixelWidth(
                                                                          5)),
                                                              TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return "enter some text";
                                                                  }
                                                                },
                                                                controller:
                                                                    postCT,
                                                                cursorColor: R
                                                                    .colors
                                                                    .blackColor,
                                                                maxLines: 5,
                                                                decoration: InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "Please post your comment, or any feedback. ",
                                                                    hintStyle: R
                                                                        .textStyle
                                                                        .regularMetropolis()
                                                                        .copyWith(
                                                                            fontSize:
                                                                                FetchPixels.getPixelHeight(13),
                                                                            color: R.colors.blackColor.withOpacity(0.5))),
                                                              ),
                                                              getVerSpace(
                                                                  FetchPixels
                                                                      .getPixelWidth(
                                                                          20)),
                                                            ],
                                                          ),
                                                        ),
                                                        getVerSpace(FetchPixels
                                                            .getPixelWidth(10)),
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              getPaddingWidget(
                                                            EdgeInsets.only(
                                                                right: FetchPixels
                                                                    .getPixelWidth(
                                                                        10)),
                                                            InkWell(
                                                              onTap: () async {
                                                                if (postCT
                                                                        .text !=
                                                                    '') {
                                                                  print(postCT
                                                                      .text);
                                                                  ForumChatRoomModel
                                                                      chatRoom =
                                                                      ForumChatRoomModel(
                                                                    createdAt:
                                                                        Timestamp
                                                                            .now(),
                                                                    createdBy: auth
                                                                        .userModel
                                                                        .email,
                                                                    postContent:
                                                                        postCT
                                                                            .text,
                                                                    peerId:
                                                                        "admin@admin.com",
                                                                    roomId: "",
                                                                  );
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "forum_room_chat")
                                                                      .add(chatRoom
                                                                          .toJson())
                                                                      .then(
                                                                          (value) async {
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "forum_room_chat")
                                                                        .doc(value
                                                                            .id)
                                                                        .update({
                                                                      "room_id":
                                                                          value
                                                                              .id
                                                                    });
                                                                  });
                                                                  // PostDataModel chatData = PostDataModel(
                                                                  //     message: postCT.text,
                                                                  //     roomId: widget.forumRoomData.roomId,
                                                                  //     senderId: auth.userModel!.email,
                                                                  //     receiverId:"",
                                                                  //     type: 0,
                                                                  //     isSeen: false,
                                                                  //     createdAt: Timestamp.now());
                                                                  // postCT.clear();
                                                                  //
                                                                  // await FirebaseFirestore.instance.collection("forum").doc().set(chatData.toJson());
                                                                  // setState(() {});
                                                                } else {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(SnackBar(
                                                                          duration: Duration(milliseconds: 500),
                                                                          content: Text(
                                                                            'Please Write Something',
                                                                          )));
                                                                }
                                                                postCT.clear();
                                                                Get.snackbar(
                                                                    "Alert!",
                                                                    "Your Post is Added Successfully!");
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            FetchPixels.getPixelWidth(15)),
                                                                height: FetchPixels
                                                                    .getPixelHeight(
                                                                        40),
                                                                width: FetchPixels
                                                                    .getPixelWidth(
                                                                        160),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: R
                                                                      .colors
                                                                      .theme,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              FetchPixels.getPixelHeight(5)),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                      "Save & Post",
                                                                      style: R
                                                                          .textStyle
                                                                          .mediumMetropolis()
                                                                          .copyWith(
                                                                              color: R.colors.whiteColor,
                                                                              fontSize: FetchPixels.getPixelHeight(15))),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                color: R.colors.g1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        getVerSpace(
                                            FetchPixels.getPixelWidth(10)),
                                        Column(
                                          children: List.generate(
                                              forumChatRoomModel.length,
                                              (index) {
                                            return PostWidget(
                                              model: forumChatRoomModel[index],
                                            );
                                          }),
                                        ),

                                        SizedBox(
                                            height:
                                                FetchPixels.getPixelHeight(10)),
                                        auth.isLoading
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: R.colors.theme))
                                            : MyButton(
                                                // isPrefixIcon: true,
                                                onTap: () async {
                                                  if (!auth.isLoggedIn) {
                                                    Get.snackbar(
                                                      "Please login",
                                                      "You need to be logged in to add items to the cart",
                                                      backgroundColor:
                                                          R.colors.whiteColor,
                                                    );
                                                    return;
                                                  }
                                                  print(auth.userModel.cart!
                                                      .map((e) => e.toJson()));
                                                  if (auth.userModel.cart!
                                                      .where((element) =>
                                                          element.productId ==
                                                          widget.model.docId)
                                                      .toList()
                                                      .isNotEmpty) {
                                                    Get.snackbar(
                                                        backgroundColor:
                                                            R.colors.whiteColor,
                                                        "",
                                                        "This Item is Already in Cart");
                                                    auth.update();
                                                  } else {
                                                    // double pricePerDay =
                                                    //     double.tryParse(widget.model
                                                    //             .productPrice!) ??
                                                    //         0.0;
                                                    // int numberOfDays =
                                                    //     auth.selectedDates.length;
                                                    double updatedTotalPrice =
                                                        totalPrice;
                                                    // print(
                                                    //     "Price Per Day: $pricePerDay");
                                                    // // print(
                                                    // //     // "Selected Dates: $selectedDates");
                                                    // print(
                                                    //     "Number of Days: $numberOfDays");
                                                    // print(
                                                    //     "Updated total price: $updatedTotalPrice");
                                                    UserCart userCart =
                                                        UserCart(
                                                      startDate: Timestamp
                                                          .fromDate(auth
                                                                  .startDate ??
                                                              DateTime.now()),
                                                      endDate: Timestamp
                                                          .fromDate(auth
                                                                  .endDate ??
                                                              DateTime.now()),
                                                      productId:
                                                          widget.model.docId,
                                                      price: updatedTotalPrice,
                                                    );
                                                    auth.userModel.cart!
                                                        .add(userCart);
                                                    await auth.updateUser(
                                                        auth.userModel);
                                                    Get.snackbar(
                                                        backgroundColor:
                                                            R.colors.whiteColor,
                                                        "",
                                                        icon: Icon(
                                                          Icons.check_circle,
                                                          color: Colors.green,
                                                        ),
                                                        "Your Item is Successfully Added in Cart");
                                                    Get.to(() => DashboardView(
                                                        index: 2));
                                                    print(
                                                        "userCart Value ${auth.userModel.cart!.map((e) => e.toJson())}");
                                                    auth.update();
                                                  }
                                                },
                                                borderRadius: 50,
                                                buttonText: auth.userModel.cart!
                                                        .contains(widget.model)
                                                    ? "Go To Cart"
                                                    : "Add to Cart",
                                              ),
                                        SizedBox(
                                            height:
                                                FetchPixels.getPixelHeight(20)),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

String getInitials(String bankAccountName) => bankAccountName.isNotEmpty
    ? bankAccountName.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
    : '';

class CalendarScreen extends StatefulWidget {
  final void Function(List<DateTime> selectedDates, double totalPrice)
      onDatesSelected;
  final double productPrice;

  CalendarScreen({required this.onDatesSelected, required this.productPrice});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  List<DateTime> _selectedDays = [];

  @override
  void initState() {
    super.initState();
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
    });
    _selectedEvents.value = _getEventsForDay(selectedDay);

    double totalPrice = calculateTotalPrice(_selectedDays.length);
    widget.onDatesSelected(_selectedDays, totalPrice);
  }

  double calculateTotalPrice(int selectedDatesCount) {
    double totalPrice = widget.productPrice;
    if (selectedDatesCount > 1) {
      totalPrice += (selectedDatesCount - 1) *
          0.1 *
          widget.productPrice; // 10% extra charge for each additional date
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TableCalendar<Event>(
        focusedDay: _focusedDay,
        firstDay: DateTime(2000),
        lastDay: DateTime(2050),
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return _selectedDays.contains(day);
        },
        onDaySelected: _onDaySelected,
        onPageChanged: (focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
        },
        calendarStyle: CalendarStyle(
          selectedDecoration: ShapeDecoration(
            color: R.colors.theme,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
