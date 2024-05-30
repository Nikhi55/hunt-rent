import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  dynamic? docId;
  String? customerName;
  String? customerId;
  String? productId;
  String? productPrice;
  String? vendorId;
  Timestamp? startDate;
  Timestamp? endDate;
  String? orderStatus;
  String? submitStatus;

  CartModel({
    this.docId,
    this.customerName,
    this.customerId,
    this.productId,
    this.productPrice,
    this.vendorId,
    this.startDate,
    this.endDate,
    this.orderStatus,
    this.submitStatus,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    docId = json['doc_id'];
    customerName = json['customer_name'];
    customerId = json['customer_id'];
    productId = json['product_id'];
    productPrice = json['product_price'];
    vendorId = json['vendor_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    orderStatus = json['order_status'];
    submitStatus = json['submit_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doc_id'] = this.docId;
    data['customer_name'] = this.customerName;
    data['customer_id'] = this.customerId;
    data['product_id'] = this.productId;
    data['product_price'] = this.productPrice;
    data['vendor_id'] = this.vendorId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['order_status'] = this.orderStatus;
    data['submit_status'] = this.submitStatus;
    return data;
  }
}
