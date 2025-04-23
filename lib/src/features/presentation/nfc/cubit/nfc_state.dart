part of 'nfc_cubit.dart';

// Estados del nfc para el cubit
sealed class NfcState {
  const NfcState();
}

class NfcInitial extends NfcState {
  const NfcInitial();
}

class NfcLoading extends NfcState {
  const NfcLoading();
}

class NfcCheckSuccess extends NfcState {
  const NfcCheckSuccess();
}

class NfcCheckError extends NfcState {
  const NfcCheckError();
}

class NfcUnavailable extends NfcState {
  const NfcUnavailable();
}

class NfcNoData extends NfcState {
  const NfcNoData();
}