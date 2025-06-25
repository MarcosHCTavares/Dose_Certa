class Medicamento {
  String nome;
  String dosagem;
  List<String> horarios; // formato "08:00", "14:00"
  DateTime? dataFinal;

  Medicamento({
    required this.nome,
    required this.dosagem,
    required this.horarios,
    this.dataFinal,
  });
}

