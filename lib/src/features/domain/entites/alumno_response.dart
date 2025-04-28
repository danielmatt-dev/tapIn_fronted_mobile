enum Estado{
  Activo, Baja
}

class AlumnoResponse {
  String _idNfc;
  Estado _estado;


  AlumnoResponse({
    required String idNfc,
    required Estado estado}):
      _idNfc = idNfc,
      _estado = estado;

  Estado get estado => _estado;

  set estado(Estado value) {
    _estado = value;
  }

  String get idNfc => _idNfc;

  set idNfc(String value) {
    _idNfc = value;
  }

  @override
  String toString() {
    return 'AlumnoResponse(idNfc: $_idNfc, estado: $_estado)';
  }
}