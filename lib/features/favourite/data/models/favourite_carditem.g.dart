// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_carditem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardItemModelAdapter extends TypeAdapter<CardItemModel> {
  @override
  final int typeId = 0;

  @override
  CardItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardItemModel(
      imageUrl: fields[0] as String,
      name: fields[1] as String,
      price: fields[2] as double,
      oldPrice: fields[3] as double,
      timestamp: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CardItemModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.oldPrice)
      ..writeByte(4)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
