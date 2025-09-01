import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl =
      "https://prodbackendv1.ingredo.in/api/productRoutes/product";
  final String loginUrl = "https://prodbackendv1.ingredo.in/api/auth/login";
  Future<Map<String, dynamic>> checkUserDetails(
      {required String email, required String password}) async {
    final response = await http.post(Uri.parse(loginUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}));
    if (response.statusCode == 200) {
      final body = await jsonDecode(response.body);
      final token = body['token'] ?? "";
      return body;
    } else {
      throw Exception("Failed Login");
    }
  }

  Future<Map<String, dynamic>> fetchProductDetails({
    required String barcode,
    required String token,
  }) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"code": barcode}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["product"] ?? {};
    } else {
      throw Exception("Failed to load product details");
    }
  }

}
