// To parse this JSON data, do
//
//     final musteri = musteriFromMap(jsonString);

import 'package:hive_flutter/adapters.dart';
part 'Musteri.g.dart';

@HiveType(typeId: 1)
class Musteri {
  @HiveField(0)
  final String isim;

  @HiveField(1)
  final String soyisim;

  @HiveField(2)
  final String adres;
  @HiveField(3)
  final String telefon;
  @HiveField(4)
  final String cinsiyet;
  @HiveField(5)
  final DateTime kontratBaslangicTarihi;

  @HiveField(6)
  final DateTime kontratBitisTarihi;

  @HiveField(7)
  final DateTime dogumTarihi;
  @HiveField(8)
  final String kontratSuresi;
  late int sira;

  Musteri(
      this.isim,
      this.soyisim,
      this.adres,
      this.telefon,
      this.cinsiyet,
      this.kontratBaslangicTarihi,
      this.kontratBitisTarihi,
      this.dogumTarihi,
      this.kontratSuresi);
  @override
  String toString() {
    return "$isim $soyisim $adres  $kontratBaslangicTarihi $kontratBitisTarihi $dogumTarihi";
  }
}
