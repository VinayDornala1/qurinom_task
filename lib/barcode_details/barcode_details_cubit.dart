

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/barcode_details/barcode_details_state.dart';

class BarcodeDetailsCubit extends Cubit<BarcodeDetailsState> {
  BarcodeDetailsCubit() : super(BarcodeDetailsInitial());
}
