// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Musteri.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MusteriAdapter extends TypeAdapter<Musteri> {
  @override
  final int typeId = 1;

  @override
  Musteri read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Musteri(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as DateTime,
      fields[6] as DateTime,
      fields[7] as DateTime,
      fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Musteri obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.isim)
      ..writeByte(1)
      ..write(obj.soyisim)
      ..writeByte(2)
      ..write(obj.adres)
      ..writeByte(3)
      ..write(obj.telefon)
      ..writeByte(4)
      ..write(obj.cinsiyet)
      ..writeByte(5)
      ..write(obj.kontratBaslangicTarihi)
      ..writeByte(6)
      ..write(obj.kontratBitisTarihi)
      ..writeByte(7)
      ..write(obj.dogumTarihi)
      ..writeByte(8)
      ..write(obj.kontratSuresi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusteriAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
