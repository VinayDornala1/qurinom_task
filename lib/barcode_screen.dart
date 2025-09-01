import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:task/barcode_details.dart';
import 'package:task/borcode/barcode_cubit.dart';
import 'package:task/borcode/barcode_state.dart';
import 'package:task/components/text_comp.dart';

class BarcodeScreen extends StatefulWidget {
  final String token;

  const BarcodeScreen({super.key, required this.token});

  @override
  State<BarcodeScreen> createState() => _BarcodeScreenState();
}

class _BarcodeScreenState extends State<BarcodeScreen> {
  String? barcodeValue;
  Map<String, dynamic>? productDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BarcodeCubit, BarcodeState>(
        listener: (context, state) {
          if (state is BarcodeLoading) {
            Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BarcodeLoaded) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BarcodeDetails(
                        imageUrl: state.imageUrl,
                        productName: state.productName,
                        brand: state.brand,
                        quantity: state.quantity)));
            print('navigationnnn');
          }else{

          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 120, 10, 120),
                  child: MobileScanner(
                    onDetect: (capture) {
                      final List<Barcode> barcodes = capture.barcodes;
                      for (final barcode in barcodes) {
                        final String code = barcode.rawValue ?? "---";
                        if (barcodeValue != code) {
                          setState(() {
                            barcodeValue = code;
                          });
                          print('barcodeValue///$barcodeValue');
                          context.read<BarcodeCubit>().fetchProductDetails(
                              barcode: barcodeValue.toString(),
                              token: widget.token);
                          // fetchBarcodeDetails(code); // fetch details
                        }
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: barcodeValue == null
                      ? CustomText(text: "Scan a barcode")
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(text: "Barcode: $barcodeValue"),
                            SizedBox(height: 10),
                            productDetails == null
                                ? CircularProgressIndicator()
                                : CustomText(text: productDetails.toString()),
                          ],
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
