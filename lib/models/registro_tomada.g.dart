// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registro_tomada.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegistroTomadaAdapter extends TypeAdapter<RegistroTomada> {
  @override
  final int typeId = 1;

  @override
  RegistroTomada read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegistroTomada(
      nomeMedicamento: fields[0] as String,
      horarioTomado: fields[1] as DateTime,
      sintomas: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RegistroTomada obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nomeMedicamento)
      ..writeByte(1)
      ..write(obj.horarioTomado)
      ..writeByte(2)
      ..write(obj.sintomas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegistroTomadaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
