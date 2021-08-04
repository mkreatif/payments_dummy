import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart';

class ApiService {
  static final String baseUrl = "https://nata.id";
  static final String baseUrlapi = baseUrl + "/api-psikologimu/Cmidtrans";

  Client client = new Client();

  Future<Map<String, dynamic>> getMidtrans(String orderId) async {
    try {
      var response = await client.post(
        "$baseUrlapi/charge/$orderId/",
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          <String, dynamic>{
            "transaction_details": {"order_id": orderId, "gross_amount": 10000}
          },
        ),
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
