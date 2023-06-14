// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EnglishWord.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnglishWordAdapter extends TypeAdapter<EnglishWord> {
  @override
  final int typeId = 0;



  @override
  EnglishWord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EnglishWord();
  }

  @override
  void write(BinaryWriter writer, EnglishWord obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnglishWordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
