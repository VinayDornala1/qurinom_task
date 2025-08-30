import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/borcode/barcode_state.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class BarcodeCubit extends Cubit<BarcodeState> {
  BarcodeCubit() : super(BarcodeInitial());
  Future<void> fetchProductDetails(
      {required String barcode, required String token}) async {
    try {
      final response = await http.post(
          Uri.parse(
              'https://prodbackendv1.ingredo.in/api/productRoutes/product'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode({"code": barcode}));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final product = data["product"];

        final productName = product["product_name"] ?? "";
        final quantity = product["quantity"] ?? product["product_quantity"]?.toString() ?? "";
        final brand = product["brands"] ?? "";
        final imageUrl = product["imageurls"]["ingredients"] ?? "";
        emit(BarcodeLoaded(
            imageUrl: imageUrl,
            productName: productName,
            brand: brand,
            quantity: quantity));
      }else{
        emit(BarcodeError(error: "No data found"));
      }
    } catch (e) {
      emit(BarcodeError(error: e.toString()));
    }
  }
}
