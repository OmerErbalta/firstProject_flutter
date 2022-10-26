// ignore_for_file: sort_child_properties_last, unnecessary_const, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:list_gayrimenkul/model/bildirim.dart';

class BildirimSayfasi extends StatefulWidget {
  final List<Bildirim> bildirimListesi;
  const BildirimSayfasi(
      {required List<Bildirim> this.bildirimListesi, super.key});

  @override
  State<BildirimSayfasi> createState() => _BildirimSayfasiState();
}

class _BildirimSayfasiState extends State<BildirimSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bildirimler")),
      body: bildirimListesi(),
    );
  }

  ListView bildirimListesi() {
    List<String> yeniListe = [];
    for (int i = 0; i < widget.bildirimListesi.length; i++) {
      if (widget.bildirimListesi[i].kontratTarihiSure < 5) {
        yeniListe.add(widget.bildirimListesi[i].isim +
            " 'nin  Kontrat Süresine Son" +
            widget.bildirimListesi[i].kontratTarihiSure.toString() +
            " gün kaldı");
      }
      if (widget.bildirimListesi[i].dogumTarihiSure < 5) {
        yeniListe.add(widget.bildirimListesi[i].isim +
            " 'nin  Doğum Tarihine Son" +
            widget.bildirimListesi[i].dogumTarihiSure.toString() +
            " gün kaldı");
      }
    }
    return ListView.builder(
      itemCount: yeniListe.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: const EdgeInsets.all(6),
          shadowColor: Colors.black,
          color: Colors.white,
          child: ListTile(
            onTap: (() {}),
            iconColor: Colors.white,
            autofocus: true,
            leading: const CircleAvatar(
              child: Icon(Icons.warning, size: 55),
              radius: 25,
              foregroundColor: Color.fromARGB(255, 255, 0, 0),
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
            ),
            title: Text(
              yeniListe[index],
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'Nunito',
                fontSize: 17,
              ),
            ),
            subtitle: Text(
              "Yeni Bildirim  ",
              style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
        );
      },
    );
  }
}
