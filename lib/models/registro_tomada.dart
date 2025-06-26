import 'package:hive/hive.dart';

part 'registro_tomada.g.dart';

@HiveType(typeId: 1)
class RegistroTomada extends HiveObject {
  @HiveField(0)
  String nomeMedicamento;

  @HiveField(1)
  DateTime horarioTomado;

  @HiveField(2)
  String? sintomas;

  RegistroTomada({
    required this.nomeMedicamento,
    required this.horarioTomado,
    this.sintomas,
  });
}
