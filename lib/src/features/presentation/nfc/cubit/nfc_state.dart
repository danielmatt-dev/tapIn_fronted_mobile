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
  final String id;
  final String email;
  final String name;
  const NfcCheckSuccess({ required this.id, required this.email, required this.name });
}

class NfcCheckError extends NfcState {
  const NfcCheckError();
}

class NfcInactivityTimeout extends NfcState {
  const NfcInactivityTimeout();
}

class NfcUnavailable extends NfcState {
  const NfcUnavailable();
}

class NfcUnavailableAlumno extends NfcState {
  const NfcUnavailableAlumno();
}

class NfcNoData extends NfcState {
  const NfcNoData();
}

class NfcTimeout extends NfcState {
  const NfcTimeout();
}