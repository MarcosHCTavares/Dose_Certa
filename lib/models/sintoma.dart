class Sintoma {
  final DateTime data;
  final String descricao;
  final String intensidade; // leve, moderado, grave
  final String? observacoes;

  Sintoma({
    required this.data,
    required this.descricao,
    required this.intensidade,
    this.observacoes,
  });
}

