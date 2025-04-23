enum TipoAcceso{
  Entrada, Salida
}

class AlumnoRequest{
  String _idNfc;
  String _fecha;
  String _hora;
  TipoAcceso _tipoAcceso;

  AlumnoRequest({
    required String idNfc,
    required String fecha,
    required hora,
    required TipoAcceso tipoAcceso}):
        _idNfc = idNfc,
        _fecha = fecha,
        _hora = hora,
        _tipoAcceso = tipoAcceso;

  TipoAcceso get tipoAcceso => _tipoAcceso;

  set tipoAcceso(TipoAcceso value) {
    _tipoAcceso = value;
  }

  String get hora => _hora;

  set hora(String value) {
    _hora = value;
  }

  String get fecha => _fecha;

  set fecha(String value) {
    _fecha = value;
  }

  String get idNfc => _idNfc;

  set idNfc(String value) {
    _idNfc = value;
  }
}