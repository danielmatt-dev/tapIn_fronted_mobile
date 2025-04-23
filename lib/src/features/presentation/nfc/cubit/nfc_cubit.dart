import 'package:flutter_bloc/flutter_bloc.dart';

part 'nfc_state.dart';

// <>
class NfcCubit extends Cubit<NfcState> {

  NfcCubit(): super(const NfcInitial());

  Future<void> escanearNfcEvent() async {
    emit(const NfcLoading());
  }

}