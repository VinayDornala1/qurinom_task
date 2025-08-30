
abstract class BarcodeState {}

final class BarcodeInitial extends BarcodeState {}

final class BarcodeLoading extends BarcodeState {}

final class BarcodeLoaded extends BarcodeState {
  final String imageUrl;
  final String productName;
  final String brand;
  final String quantity;
  BarcodeLoaded({required this.imageUrl,required this.productName,required this.brand,required this.quantity});
}
final class BarcodeError extends BarcodeState {
  final String error;
  BarcodeError({required this.error});
}
