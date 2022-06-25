// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final int typeId = 0;

  @override
  Transaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transaction()
      ..name = fields[0] as String
      ..unitprice = fields[4] as String
      ..sp = fields[5] as int
      ..id = fields[6] as int
      ..variantavailable = fields[7] as bool;
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.unitprice)
      ..writeByte(5)
      ..write(obj.sp)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.variantavailable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
