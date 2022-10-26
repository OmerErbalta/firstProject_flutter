// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, unused_local_variable
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:list_gayrimenkul/model/sabitler.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'MusteriGuncelle.dart';
import 'model/Musteri.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:url_launcher/url_launcher.dart';

musteriDetayEkrani(Musteri detayMusteri, BuildContext context) {
  Musteri oankimusteri = detayMusteri;
  final gunSayisi =
      oankimusteri.kontratBitisTarihi.difference(DateTime.now()).inDays;
  double progressBar = 0;
  if (gunSayisi <= 100) {
    progressBar = gunSayisi / 100;
  } else if (gunSayisi > 100) {
    progressBar = 1;
  }
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  TextEditingController adresController = TextEditingController();
  adresController.text = oankimusteri.adres;
  return Stack(
    fit: StackFit.expand,
    children: [
      Container(
        decoration: BoxDecoration(
            // ignore: prefer_const_literals_to_create_immutables
            gradient: LinearGradient(
                colors: [Color.fromRGBO(4, 9, 35, 1), Sabitler.anaRenk],
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter)),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(AntDesign.arrowleft),
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'List\nProfili',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontFamily: 'Nisebuschgardens',
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Container(
                  height: height * 0.6,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double innerHeight = constraints.maxHeight;
                      double innerWidth = constraints.maxWidth;
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: innerHeight * 0.76,
                              width: innerWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 80,
                                  ),
                                  Text(
                                    oankimusteri.isim +
                                        " " +
                                        oankimusteri.soyisim,
                                    style: TextStyle(
                                      color: Color.fromRGBO(39, 105, 171, 1),
                                      fontFamily: 'Nunito',
                                      fontSize: 37,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'İletişim',
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontFamily: 'Nunito',
                                              fontSize: 25,
                                            ),
                                          ),
                                          ElevatedButton.icon(
                                              onPressed: () {
                                                whatsappMesaj(oankimusteri);
                                              },
                                              icon: Icon(
                                                Icons.whatsapp,
                                              ),
                                              label: Text(
                                                oankimusteri.telefon,
                                              )),
                                          ElevatedButton.icon(
                                              onPressed: () {
                                                FlutterPhoneDirectCaller
                                                    .callNumber(
                                                        oankimusteri.telefon);
                                              },
                                              icon: Icon(
                                                Icons.phone,
                                              ),
                                              label: Text(
                                                oankimusteri.telefon,
                                              ))
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                          vertical: 8,
                                        ),
                                        child: Container(
                                          height: 50,
                                          width: 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Kontrat',
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontFamily: 'Nunito',
                                              fontSize: 25,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircularPercentIndicator(
                                              radius: 47.0,
                                              lineWidth: 12.0,
                                              animation: true,
                                              percent: progressBar,
                                              animationDuration: 1000,
                                              circularStrokeCap:
                                                  CircularStrokeCap.round,
                                              center: Text(
                                                (gunSayisi).toString() + " Gün",
                                                style: TextStyle(
                                                    color: Sabitler.anaRenk,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              progressColor: Sabitler.anaRenk,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 130,
                            right: 20,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.transparent,
                                  primary: Colors.white,
                                  onPrimary: Sabitler.anaRenk),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => musteriguncelle(
                                            guncellemusteri: oankimusteri,
                                          )),
                                );
                              },
                              child: Icon(
                                AntDesign.edit,
                                color: Colors.grey[700],
                                size: 30,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                  child: resim(innerWidth, oankimusteri)),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: height * 1,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Bilgileri',
                          style: TextStyle(
                            color: Color.fromRGBO(39, 105, 171, 1),
                            fontSize: 27,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        Divider(
                          thickness: 2.5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            alignment: Alignment.center,
                            height: height * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                Text("Adres",
                                    style: TextStyle(
                                      color: Color.fromRGBO(39, 105, 171, 1),
                                      fontSize: 27,
                                      fontFamily: 'Nunito',
                                    )),
                                TextField(
                                  enabled: false,
                                  maxLines: 5,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Nunito',
                                  ),
                                  textAlign: TextAlign.center,
                                  controller: adresController,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            alignment: Alignment.center,
                            height: height * 0.2,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                Text("Kişisel Bilgiler",
                                    style: TextStyle(
                                      color: Color.fromRGBO(39, 105, 171, 1),
                                      fontSize: 27,
                                      fontFamily: 'Nunito',
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "İsim Soyisim: " +
                                        oankimusteri.isim +
                                        " " +
                                        oankimusteri.soyisim,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: 'Nunito',
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "Doğum Tarihi:" +
                                        formatDate(oankimusteri.dogumTarihi,
                                            [dd, '/', mm, '/', yyyy]),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: 'Nunito',
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "Telefon Numarası: " + oankimusteri.telefon,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: 'Nunito',
                                    )),
                              ],
                            )),
                        SizedBox(height: 10),
                        Container(
                            alignment: Alignment.center,
                            height: height * 0.2,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                Text("Kontrat Bilgileri",
                                    style: TextStyle(
                                      color: Color.fromRGBO(39, 105, 171, 1),
                                      fontSize: 27,
                                      fontFamily: 'Nunito',
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "Kontrat Başlangıç Tarihi: " +
                                        formatDate(
                                            oankimusteri.kontratBaslangicTarihi,
                                            [dd, '/', mm, '/', yyyy]),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: 'Nunito',
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "Kontrat Bitiş Tarihi: " +
                                        formatDate(
                                            oankimusteri.kontratBitisTarihi,
                                            [dd, '/', mm, '/', yyyy]),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: 'Nunito',
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "Bitmesine Kalan Süre: " +
                                        gunSayisi.toString() +
                                        " Gün",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: 'Nunito',
                                    )),
                              ],
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    ],
  );
}

Image resim(double e, Musteri oAnkiMusteri) {
  if (formatDate(oAnkiMusteri.dogumTarihi, [dd, '/', mm, '/', yyyy]) ==
      formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy])) {
    return Image.asset(
      'assets/img/cake.png',
      width: e * 0.45,
      fit: BoxFit.fitWidth,
    );
  } else if (oAnkiMusteri.cinsiyet == "Erkek") {
    return Image.asset(
      'assets/img/profile.png',
      width: e * 0.45,
      fit: BoxFit.fitWidth,
    );
  } else {
    return Image.asset(
      'assets/img/profile_woman.png',
      width: e * 0.45,
      fit: BoxFit.fitWidth,
    );
  }
}

void whatsappMesaj(Musteri e) async {
  if (e.cinsiyet == "Erkek") {
    await launchUrl(
        Uri.parse('whatsapp://send?phone=90${e.telefon}?&text=Merhaba ' +
            e.isim +
            " Bey Ben List Gayrimenkulden Ömer"),
        mode: LaunchMode.externalApplication);
  } else {
    await launchUrl(
        Uri.parse('whatsapp://send?phone=90${e.telefon}?&text=Merhaba ' +
            e.isim +
            " Hanım Ben List Gayrimenkulden Ömer"),
        mode: LaunchMode.externalApplication);
  }
}
