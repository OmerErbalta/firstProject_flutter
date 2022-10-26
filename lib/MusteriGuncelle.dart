// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:list_gayrimenkul/anasayfa.dart';
import 'package:list_gayrimenkul/main.dart';
import 'package:list_gayrimenkul/model/sabitler.dart';
import '../musteriDetay.dart';
import 'model/Musteri.dart';

class musteriguncelle extends StatefulWidget {
  final Musteri guncellemusteri;
  musteriguncelle({required Musteri this.guncellemusteri, Key? key})
      : super(key: key);

  @override
  State<musteriguncelle> createState() => _musteriguncelleState();
}
class _musteriguncelleState extends State<musteriguncelle> {
  var box = Hive.box<Musteri>("Musteriler");
  late String cinsiyeti = widget.guncellemusteri.cinsiyet;
 late String cinsiyet = widget.guncellemusteri.cinsiyet;
  late DateTime kontratBaslangicTarihi =
      widget.guncellemusteri.kontratBaslangicTarihi;
  late DateTime dogumTarihi2 = widget.guncellemusteri.dogumTarihi;
  late DateTime dogumTarihiDatetime = widget.guncellemusteri.dogumTarihi;
  final TextEditingController isim = TextEditingController();
  final TextEditingController kontratSuresi = TextEditingController();
  final TextEditingController soyisim = TextEditingController();
  final TextEditingController telefon = TextEditingController();
  final TextEditingController adres = TextEditingController();
  final TextEditingController baslangicTarih = TextEditingController();
  final TextEditingController dogumTarihi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    isim.text = widget.guncellemusteri.isim;
    soyisim.text = widget.guncellemusteri.soyisim;
    telefon.text = widget.guncellemusteri.telefon;
    adres.text = widget.guncellemusteri.adres;
    kontratSuresi.text = widget.guncellemusteri.kontratSuresi;

    final gunsayisi = widget.guncellemusteri.kontratBitisTarihi
        .difference(widget.guncellemusteri.kontratBaslangicTarihi)
        .inDays;

    var text =
        "${widget.guncellemusteri.kontratBaslangicTarihi.day.toString()}/${widget.guncellemusteri.kontratBaslangicTarihi.month.toString()}/${widget.guncellemusteri.kontratBaslangicTarihi.year.toString()}";

    var textdogumtarihi =
        "${widget.guncellemusteri.dogumTarihi.day.toString()}/${widget.guncellemusteri.dogumTarihi.month.toString()}/${widget.guncellemusteri.dogumTarihi.year.toString()}";

    var myTextStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Müşteri Düzenleme"),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Text(
                  "${widget.guncellemusteri.isim.toUpperCase()} ${widget.guncellemusteri.soyisim.toUpperCase()}",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      child: resim(200, widget.guncellemusteri),
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              textfield("İSİM", widget.guncellemusteri.isim, isim,
                  Icon(Icons.person)),
              textfield("SOY İSİM", widget.guncellemusteri.soyisim, soyisim,
                  Icon(Icons.person)),
              textfield("TELEFON", widget.guncellemusteri.telefon, telefon,
                  Icon(Icons.phone_iphone)),
              textfield("ADRES", widget.guncellemusteri.adres, adres,
                  Icon(Icons.map_sharp)),
              TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.cake),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "DOĞUM TARİHİ",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: textdogumtarihi,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )),
                controller: dogumTarihi,
                readOnly: true,
                onTap: (() => {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now())
                          .then((value) => {
                                setState(() {
                                  dogumTarihiDatetime = value!;
                                  dogumTarihi.text = formatDate(
                                      value, [dd, '/', mm, '/', yyyy]);
                                })
                              })
                    }),
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CİNSİYET",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                                value: "Erkek",
                                groupValue: cinsiyet,
                                onChanged: (String? index) {
                                  setState(() {
                                    cinsiyet = index!;
                                  });
                                }),
                            Expanded(
                                child: Text(
                              'Erkek',
                            ))
                          ],
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                                value: "Kadın",
                                groupValue: cinsiyet,
                                onChanged: (String? index) {
                                  setState(() {
                                    cinsiyet = index!;
                                  });
                                }),
                            Expanded(
                                child: Text(
                              'Kadın',
                            ))
                          ],
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  Divider(
                    height: 10,
                    color: Colors.black87,
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.date_range),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "KONTRAT BASLANGIC",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: text,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )),
                controller: baslangicTarih,
                readOnly: true,
                onTap: (() {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2050, 1, 1))
                      .then((value) => {
                            setState(() {
                              kontratBaslangicTarihi = value!;
                              baslangicTarih.text =
                                  formatDate(value, [dd, '/', mm, '/', yyyy]);
                              text = baslangicTarih.text;
                            })
                          });
                }),
              ),
              SizedBox(
                height: 35,
              ),
              TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.lock_clock),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "KONTRAT SÜRESİ(AY)",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: widget.guncellemusteri.kontratSuresi,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )),
                keyboardType: TextInputType.number,
                controller: kontratSuresi,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "İPTAL",
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("BİLDİRİM")),
                  ElevatedButton(
                    onPressed: () {
                      if (1 < 2) {
                        verileriguncelle(widget.guncellemusteri);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Güncelleme Basarısız",
                            style: TextStyle(fontSize: 16),
                          ),
                          backgroundColor: Sabitler.anaRenk,
                        ));
                      }
                    },
                    child: Text(
                      "GÜNCELLE",
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void verileriguncelle(Musteri guncellemusteri) async {
    DateTime kontatBitisTarihi = DateTime(
        kontratBaslangicTarihi.year,
        kontratBaslangicTarihi.month + int.parse(kontratSuresi.text),
        kontratBaslangicTarihi.day);
    setState(() {
      box.putAt(
          guncellemusteri.sira,
          Musteri(
              isim.text,
              soyisim.text,
              adres.text,
              telefon.text.toString(),
              cinsiyet.toString(),
              kontratBaslangicTarihi,
              kontatBitisTarihi,
              dogumTarihiDatetime,
              kontratSuresi.text));
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Güncelleme Başarılı ",
        style: TextStyle(fontSize: 16),
      ),
      backgroundColor: Sabitler.anaRenk,
    ));
    isim.clear();
    adres.clear();
    soyisim.clear();
    dogumTarihi.clear();
    kontratSuresi.clear();
    baslangicTarih.clear();
    telefon.clear();
    Navigator.popUntil(context, (route) => false);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AnaSayfa()));
  }

  Widget textfield(String labelText, String placeholder,
      TextEditingController control, Icon icon) {
    var height = 1;
    var maxlenght = null;
    if (labelText == "ADRES") {
      height = 3;
    }
    if (labelText == "TELEFON") {
      maxlenght = 11;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        maxLength: maxlenght,
        maxLines: height,
        controller: control,
        onTap: () {},
        decoration: InputDecoration(
            icon: icon,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
