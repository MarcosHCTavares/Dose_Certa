import 'package:hive/hive.dart';

part 'medicamento.g.dart';

@HiveType(typeId: 0)
class Medicamento extends HiveObject {
  @HiveField(0)
  String nome;

  @HiveField(1)
  String descricao;

  @HiveField(2)
  String dose;

  @HiveField(3)
  List<String> horarios; // Horários em formato "HH:mm"

  Medicamento({
    required this.nome,
    required this.descricao,
    required this.dose,
    required this.horarios,
  });
}
