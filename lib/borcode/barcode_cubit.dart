import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/borcode/barcode_state.dart';
import 'package:task/repositary/api.dart';

class BarcodeCubit extends Cubit<BarcodeState> {
  final ApiService apiService;

  BarcodeCubit({required this.apiService}) : super(BarcodeInitial());

  Future<void> fetchProductDetails({
    required String barcode,
    required String token,
  }) async {
    try {
      final product =
      await apiService.fetchProductDetails(barcode: barcode, token: token);

      final productName = product["product_name"] ?? "";
      final quantity = product["quantity"] ??
          product["product_quantity"]?.toString() ??
          "";
      final brand = product["brands"] ?? "";
      final imageUrl = product["imageurls"]?["ingredients"] ?? "";

      emit(BarcodeLoaded(
        imageUrl: imageUrl,
        productName: productName,
        brand: brand,
        quantity: quantity,
      ));
    } catch (e) {
      emit(BarcodeError(error: e.toString()));
    }
  }
}
