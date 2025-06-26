// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sintoma.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SintomaAdapter extends TypeAdapter<Sintoma> {
  @override
  final int typeId = 2;

  @override
  Sintoma read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sintoma(
      descricao: fields[0] as String,
      dataHora: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Sintoma obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.descricao)
      ..writeByte(1)
      ..write(obj.dataHora);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SintomaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
