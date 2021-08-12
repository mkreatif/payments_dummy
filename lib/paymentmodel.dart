import 'package:flutter/foundation.dart';

const List<String> payments = [
  "echannel",
  "bca_va",
  "bni_va",
  "bri_va",
  "gopay"
];

class PAddress {
  String fname;
  String lname;
  String email;
  String phone;
  String cpost;
  String ccountry;
  String address;
  String city;

  PAddress(
      {this.fname = "",
      this.lname = "",
      this.email = "",
      this.phone = "",
      this.address = "",
      this.city = "",
      this.cpost = "",
      this.ccountry = ""});

  Map<String, dynamic> toMap() => {
        'first_name': this.fname,
        "last_name": this.lname,
        "email": this.email,
        "phone": this.phone,
        "address": this.address,
        "city": this.city,
        "postal_code": this.cpost,
        "country_code": this.ccountry
      };
}

class PCustomerDetail {
  String fname;
  String lname;
  String email;
  String phone;
  PAddress billingAddress;
  PAddress shipingAddress;

  PCustomerDetail(
      {this.fname = '',
      this.lname = '',
      @required this.email,
      this.phone = '',
      this.billingAddress,
      this.shipingAddress});

  Map<String, dynamic> toMap() => {
        'first_name': this.fname,
        "last_name": this.lname,
        "email": this.email,
        "phone": this.phone,
        "billing_address":
            this.billingAddress != null ? this.billingAddress.toMap() : {},
        "shipping_address":
            this.shipingAddress != null ? this.shipingAddress.toMap() : {}
      };
}

class PItemDetail {
  String id;
  int price;
  int quantity;
  String name;
  String brand;
  String category;
  String merchantName;

  PItemDetail(
      {this.id = '',
      @required this.price,
      this.quantity = 1,
      @required this.name,
      this.brand = '',
      this.category = '',
      this.merchantName = ''});

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "price": this.price,
        "quantity": this.quantity,
        "name": this.name,
        "brand": this.brand,
        "category": this.category,
        "merchant_name": this.merchantName
      };
}

class PaymentModel {
  String orderId;
  int grossAmount;
  PCustomerDetail customerDetails;
  List<PItemDetail> itemDetails;
  List<String> enablePayments;

  PaymentModel(
      {@required this.orderId,
      @required this.grossAmount,
      @required this.customerDetails,
      @required this.itemDetails,
      this.enablePayments = payments});

  List<Map<String, dynamic>> getItemDetails() {
    if (itemDetails != null) {
      return itemDetails.map((e) => e.toMap()).toList();
    }
    return [];
  }

  Map<String, dynamic> toMap() => {
        "transaction_details": {
          "order_id": this.orderId,
          "gross_amount": this.grossAmount
        },
        "item_details": getItemDetails(),
        "customer_details":
            customerDetails != null ? customerDetails.toMap() : {},
        "enabled_payments": this.enablePayments
      };
}
