import 'package:hive/hive.dart';
part 'sintoma.g.dart';

@HiveType(typeId: 2)
class Sintoma extends HiveObject {
  @HiveField(0)
  final String descricao;

  @HiveField(1)
  final DateTime dataHora;

  Sintoma({
    required this.descricao,
    required this.dataHora,
  });
}
