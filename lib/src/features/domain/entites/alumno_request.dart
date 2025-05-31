enum TipoAcceso{
  Entrada, Salida
}

class AlumnoRequest{
  String? _idNfc;
  String? _correo;
  String _fecha;
  String _hora;
  TipoAcceso _tipoAcceso;
  final String _estado = 'Habilitado';

  AlumnoRequest({
    String? idNfc,
    required String fecha,
    required hora,
    required TipoAcceso tipoAcceso,
    String? correo
  }):
        _idNfc = idNfc,
        _fecha = fecha,
        _hora = hora,
        _tipoAcceso = tipoAcceso,
        _correo = correo;

  @override
  String toString() {
    return 'AlumnoRequest(idNfc: $_idNfc, fecha: $_fecha, hora: $_hora, tipoAcceso: $_tipoAcceso)';
  }

  String get estado => _estado;

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

  String? get correo => _correo;

  set correo(String? value) {
    _correo = value;
  }

  String? get idNfc => _idNfc;

  set idNfc(String? value) {
    _idNfc = value;
  }
}