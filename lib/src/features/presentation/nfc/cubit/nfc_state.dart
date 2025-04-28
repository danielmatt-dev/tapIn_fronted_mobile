part of 'nfc_cubit.dart';

// Estados del nfc para el cubit
sealed class NfcState {
  final String message;
  const NfcState(this.message);
}

class NfcInitial extends NfcState {
  const NfcInitial(): super('');
}

class NfcLoading extends NfcState {
  const NfcLoading(): super('');
}

class NfcCheckSuccess extends NfcState {
  final List<String> data;
  const NfcCheckSuccess(this.data, super.message);
}

class NfcCheckError extends NfcState {
  const NfcCheckError(super.message);
}

class NfcUnavailable extends NfcState {
  const NfcUnavailable(super.message);
}

class NfcNoData extends NfcState {
  const NfcNoData(super.message);
}