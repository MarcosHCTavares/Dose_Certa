class Medicamento {
  final String nome;
  final String dosagem;
  final List<String> horarios; // Ex: ['08:00', '14:00']
  final DateTime? dataFinal;
  final String? observacoes;

  Medicamento({
    required this.nome,
    required this.dosagem,
    required this.horarios,
    this.dataFinal,
    this.observacoes,
  });
}
