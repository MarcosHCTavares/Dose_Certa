class RegistroTomada {
  final DateTime dataHora;
  final String nomeMedicamento;
  final bool tomou; // true: tomou, false: não tomou

  RegistroTomada({
    required this.dataHora,
    required this.nomeMedicamento,
    required this.tomou,
  });
}

