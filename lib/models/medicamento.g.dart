// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicamento.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicamentoAdapter extends TypeAdapter<Medicamento> {
  @override
  final int typeId = 0;

  @override
  Medicamento read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Medicamento(
      nome: fields[0] as String,
      descricao: fields[1] as String,
      dose: fields[2] as String,
      horarios: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Medicamento obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.descricao)
      ..writeByte(2)
      ..write(obj.dose)
      ..writeByte(3)
      ..write(obj.horarios);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicamentoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
