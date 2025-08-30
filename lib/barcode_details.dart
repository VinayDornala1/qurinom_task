import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/borcode/barcode_cubit.dart';
import 'package:task/borcode/barcode_state.dart';

import 'package:task/borcode/barcode_state.dart';
import 'package:task/components/image_comp.dart';
import 'package:task/components/text_comp.dart';

class BarcodeDetails extends StatefulWidget {
  final String imageUrl;
  final String productName;
  final String brand;
  final String quantity;
  const BarcodeDetails(
      {super.key,
      required this.imageUrl,
      required this.productName,
      required this.brand,
      required this.quantity});

  @override
  State<BarcodeDetails> createState() => _BarcodeDetailsState();
}

class _BarcodeDetailsState extends State<BarcodeDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('imageUrl///${widget.imageUrl}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BarcodeCubit, BarcodeState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImage(imageUrl: widget.imageUrl,),
                CustomText(text: widget.productName),
                CustomText(text: widget.brand),
                CustomText(text: widget.quantity)
              ],
            );
          },
          listener: (context, state) {}),
    );
  }
}
