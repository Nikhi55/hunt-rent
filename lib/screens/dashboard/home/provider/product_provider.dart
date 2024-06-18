import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/cart/model/cart_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/category_model.dart';
import 'package:provider/provider.dart';
import '../../../../resources/resources.dart';
import '../../../../services/product_service.dart';
import '../model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  // Function to notify listeners safely
  void _notifyListeners() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void updateLocationAddress(String newAddress) {
    locationAddress = newAddress;
    notifyListeners();
  }

  update() {
    _notifyListeners();
  }

  List<bool>? selections;
  List<bool>? selectionsOcc;

  bool isLoading = false;

  startLoader() {
    isLoading = true;
    _notifyListeners();
  }

  stopLoader() {
    isLoading = false;
    _notifyListeners();
  }

  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  void setTotalPrice(double price) {
    _totalPrice = price;
    _notifyListeners();
  }

  StreamSubscription? _ssProducts;
  StreamSubscription? _ssMajorCat;
  StreamSubscription? _ssCat;
  String selectedCatId = "";
  String selectedCatName = "All";
  String selectedSubCatName = "";
  bool isSubClicked = false;
  String lat = "0.0";
  String lng = "0.0";
  String locationAddress = "";

  List<MajorCategory> majorCatList = []; // List of Major Categories
  List<CategoriesModel> subCatList = []; // List of Categories
  List<String> brandNames = [];
  List<String> occasionNames = [];
  List<String> sizesNames = [];
  List<String> majorCatNameList = []; // List of Brands
  List<String> subCatNameList = []; // List of Brands
  List<CartModel> earningsList = [];
  List<String> myList = [];
  List<ProductModel> myOwnProducts = [];

  List<CartModel> bookingsList = [];

  Set<Marker> markers = {};

  Future fetchLocationAddress() async {
    try {
      double latitude = double.tryParse(lat) ?? 0.0;
      double longitude = double.tryParse(lng) ?? 0.0;
      var placemarks = await placemarkFromCoordinates(latitude, longitude);
      locationAddress =
          "${placemarks.first.subLocality ?? ''}, ${placemarks.first.locality ?? ''}, ${placemarks.first.administrativeArea ?? ''}, ${placemarks.first.country ?? ''}";

      // Update markers
      markers = {
        Marker(
          markerId: MarkerId('marker_1'),
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(title: "Current Location"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        ),
      };

      print("locationAddress: $locationAddress");
    } catch (e) {
      print("Error fetching location address: $e");
    } finally {
      notifyListeners(); // Ensure listeners are notified after updating state
    }
  }

  getEarningRecord() async {
    await FirebaseFirestore.instance
        .collection("placeOrder")
        .get()
        .then((value) async {
      earningsList =
          value.docs.map((e) => CartModel.fromJson(e.data())).toList();
      print(
          "total expenseList == ************************** ${earningsList.length}");
      _notifyListeners();
    });
  }

  getBookingsRecord() async {
    print("value");
    await FirebaseFirestore.instance
        .collection("placeOrder")
        .get()
        .then((value) async {
      bookingsList =
          value.docs.map((e) => CartModel.fromJson(e.data())).toList();
      print(
          "total expenseList == ************************** ${bookingsList.length}");
      _notifyListeners();
    });
  }

  Future<void> fetchProducts() async {
    print("fetch Products");
    var value = await ProductService.products();
    if (_ssProducts == null) {
      _ssProducts = value.listen((event) {
        products = event;
        print("length of products ${products.length}");
        stopLoader();
      });
    }
  }

  Future<void> fetchMajorCat() async {
    print("fetch fetchMajorCat");
    var value = await ProductService.majCat();
    if (_ssMajorCat == null) {
      _ssMajorCat = value.listen((event) {
        majorCatList = event;
        print("length of majorCatList ${majorCatList.length}");
        stopLoader();
      });
    }
  }

  Future<void> fetchCat() async {
    print("fetch Products");
    var value = await ProductService.subCat();
    if (_ssCat == null) {
      _ssCat = value.listen((event) {
        subCatList = event;
        print("length of subCatList ${subCatList.length}");
        update();
      });
    }
  }

  Future fetchBrandNames() async {
    await FirebaseFirestore.instance
        .collection("brands")
        .doc("branding")
        .get()
        .then((value) {
      brandNames = List.from(value.data()!["brandList"]);
      print("length of brandNames ${brandNames.length}");
      _notifyListeners();
    });
    await FirebaseFirestore.instance
        .collection("brands")
        .doc("occasion")
        .get()
        .then((value) {
      occasionNames = List.from(value.data()!["occasionList"]);
      print("length of occasionNames ${occasionNames.length}");
      _notifyListeners();
    });
    await FirebaseFirestore.instance
        .collection("brands")
        .doc("sizes")
        .get()
        .then((value) {
      sizesNames = List.from(value.data()!["cloth_size"]);
      print("length of sizesNames ${sizesNames.length}");
      _notifyListeners();
    });
  }

  Future fetchMajorData() async {
    await fetchMajorCat();
    await fetchCat();
    await fetchProducts();
    await fetchBrandNames();
    await getEarningRecord();
    await getBookingsRecord();
  }

  getMajorCatNames() {
    for (var i = 0; i < majorCatList.length; i++) {
      majorCatNameList.add(majorCatList[i].catName!);
    }
    print("majorCatNameList $majorCatNameList");
    _notifyListeners();
  }

  getSubCatNames() {
    for (var i = 0; i < subCatList.length; i++) {
      subCatNameList.add(subCatList[i].categoryName!);
    }
    print("subCatNameList $subCatNameList");
    _notifyListeners();
  }

  List<ProductModel> products = [];
}
