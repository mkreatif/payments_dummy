import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:cobapluginmidpay/paymentmodel.dart';
import 'package:http/http.dart';

class ApiService {
  static final String baseUrl = "https://nata.id";
  static final String baseUrlapi = baseUrl + "/api-psikologimu/Cmidtrans";

  Client client = new Client();

  Future<Map<String, dynamic>> getMidtrans(String orderId) async {
    PaymentModel paymentModel = new PaymentModel(
        orderId: orderId,
        grossAmount: 10000,
        customerDetails:
            new PCustomerDetail(email: "marlina.kreatif@gmail.com"),
        itemDetails: [new PItemDetail(name: "Konsultasi Chat", price: 10000)]);

    try {
      var response = await client.post(
        "$baseUrlapi/charge/$orderId/",
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(paymentModel.toMap()),
      );

      return jsonDecode(response.body);
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
      return null;
    } on SocketException catch (e) {
      print('Socket Error: $e');
      return null;
    } on Error catch (e) {
      print('General Error: $e');
      return null;
    } on HttpException catch (e) {
      print('HttpException Error: $e');
      return null;
    }
  }
}
