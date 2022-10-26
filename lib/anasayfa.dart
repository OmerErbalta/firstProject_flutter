// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:date_format/date_format.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:list_gayrimenkul/api/notification_api.dart';
import 'package:list_gayrimenkul/model/bildirim.dart';
import 'bildirimSayfası.dart';
import 'model/Musteri.dart';
import 'model/sabitler.dart';
import 'musteriDetay.dart';

late List<Musteri> MusteriListesi = [];
late List<Bildirim> bildirimListesi = [];

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  State<AnaSayfa> createState() => AnaSayfaState();
}

List<Musteri> tumMusteriler = [];

class AnaSayfaState extends State<AnaSayfa> {
  musterileriOku() async {
    tumMusteriler = [];
    try {
      (box.toMap()).forEach((key, value) {
        tumMusteriler.add(value);
        MusteriListesi = tumMusteriler;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String cinsiyetValue = "Erkek";
  var box = Hive.box<Musteri>("Musteriler");
  late DateTime kontratBaslangicTarihi;
  late DateTime dogumTarihiDatetime = DateTime.now();
  final TextEditingController isim = TextEditingController();
  final TextEditingController kontratSuresi = TextEditingController();
  final TextEditingController soyisim = TextEditingController();
  final TextEditingController telefon = TextEditingController();
  final TextEditingController adres = TextEditingController();
  final TextEditingController baslangicTarih = TextEditingController();
  TextEditingController seacrhController = TextEditingController();
  final TextEditingController dogumTarihi = TextEditingController();
  late double progressBar = 0.7;

  @override
  void initState() {
    () async {
      await musterileriOku();
      setState(() {});
    }();
    bildirimler();
    super.initState();
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      musterileriListele(),
      musteriKaydet(),
    ];
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromRGBO(4, 9, 35, 1), Sabitler.anaRenk],
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter)),
      ),
      Scaffold(
        appBar: AppBar(
          leading: ElevatedButton(
            onPressed: ()async {
              await NotificationApi.showSchedulNotification(
                  title: "basardın",
                  body: "Helal lan sana",
                  scheduledDate: DateTime.now().add(Duration(seconds: 10)));
            },
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                primary: Colors.transparent,
                onPrimary: Sabitler.anaRenk),
            child: Icon(
              Icons.list,
              color: Colors.white,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          title: const Text(
            "List Gayrimenkul",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Nisebuschgardens',
            ),
          ),
          backgroundColor: Color.fromARGB(255, 23, 138, 176),
          actions: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        primary: Colors.transparent,
                        onPrimary: Sabitler.anaRenk),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BildirimSayfasi(
                                    bildirimListesi: bildirimListesi,
                                  )));
                    },
                    child: Icon(
                      Icons.notifications,
                      size: 35,
                      color: Colors.white,
                    )),
                Positioned(
                  right: 13,
                  top: 10,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: new Text(
                      '1',
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 23, 138, 176),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 8),
                    child: GNav(
                        rippleColor: Colors.grey[300]!,
                        hoverColor: Colors.grey[100]!,
                        gap: 8,
                        activeColor: Colors.black,
                        iconSize: 24,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        duration: Duration(milliseconds: 300),
                        tabBackgroundColor: Colors.grey[300]!,
                        color: Colors.black,
                        selectedIndex: _selectedIndex,
                        onTabChange: (value) => {_onItemTapped(value)},
                        tabs: bottomNavigatorItems())))),
      ),
    ]);
  }

  musterileriListele() {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: TextField(
              controller: seacrhController,
              onChanged: ((value) {
                search(value);
              }),
              decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  contentPadding: EdgeInsets.only(bottom: 0),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Arama...",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  )),
            )),
        Expanded(
          flex: 12,
          child: ListView.builder(
            itemCount: MusteriListesi.length,
            itemBuilder: ((context, index) {
              MusteriListesi[index].sira = index;
              Musteri oAnkiMusteri = MusteriListesi[index];
              print(index);
              return Slidable(
                closeOnScroll: true,
                startActionPane: ActionPane(motion: DrawerMotion(), children: [
                  SlidableAction(
                    onPressed: (context) {
                      setState(() {
                        whatsappMesaj(oAnkiMusteri);
                      });
                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.whatsapp,
                    label: 'Mesaj At',
                    autoClose: true,
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      setState(() {
                        FlutterPhoneDirectCaller.callNumber(
                            oAnkiMusteri.telefon);
                      });
                    },
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    icon: LineIcons.phone,
                    label: 'Ara',
                    autoClose: true,
                  ),
                ]),
                endActionPane: ActionPane(motion: ScrollMotion(), children: [
                  SlidableAction(
                    onPressed: (context) {
                      setState(() {
                        box.deleteAt(oAnkiMusteri.sira);
                        musterileriOku();
                      });
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: LineIcons.alternateTrash,
                    spacing: 10,
                    label: 'Sil',
                    autoClose: true,
                  ),
                ]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: SizedBox(
                    height: 90,
                    child: Card(
                      shadowColor: Colors.black,
                      elevation: 15,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: Sabitler.borderRadius),
                      child: ListTile(
                        onTap: (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    musteriDetayEkrani(oAnkiMusteri, context)),
                          );
                        }),
                        iconColor: Colors.white,
                        autofocus: true,
                        leading: CircleAvatar(
                          radius: 28,
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromRGBO(39, 105, 171, 1),
                          child: resim(300, oAnkiMusteri),
                        ),
                        title: Text(
                          oAnkiMusteri.isim +
                              " " +
                              oAnkiMusteri.sira.toString(),
                          style: TextStyle(
                            color: Color.fromRGBO(39, 105, 171, 1),
                            fontFamily: 'Nunito',
                            fontSize: 17,
                          ),
                        ),
                        subtitle: Text(
                          oAnkiMusteri.adres,
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<GButton> bottomNavigatorItems() {
    List<GButton> liste = [];
    liste.add(
      GButton(
        icon: Icons.group_outlined,
        text: 'Müşteriler',
      ),
    );
    liste.add(
      GButton(
        icon: AntDesign.adduser,
        text: 'Müşteri Ekle',
      ),
    );

    return liste;
  }

  Widget musteriKaydet() {
    return ListView(
      children: [
        TextField(
            style: Sabitler.textStyle,
            controller: isim,
            decoration: Sabitler.inputDecoration(
                "İsim Giriniz",
                Icon(
                  Icons.person,
                  color: Colors.white,
                ))),
        TextField(
            style: Sabitler.textStyle,
            controller: soyisim,
            decoration: Sabitler.inputDecoration(
                "Soyisim Giriniz",
                Icon(
                  Icons.person,
                  color: Colors.white,
                ))),
        TextField(
          style: Sabitler.textStyle,
          controller: telefon,
          keyboardType: TextInputType.phone,
          maxLength: 11,
          decoration: Sabitler.inputDecoration(
              "Telefon Giriniz",
              Icon(
                Icons.phone_iphone,
                color: Colors.white,
              )),
        ),
        TextField(
            style: Sabitler.textStyle,
            controller: adres,
            maxLines: 5,
            keyboardType: TextInputType.streetAddress,
            decoration: Sabitler.inputDecoration(
                "Adres Giriniz",
                Icon(
                  Icons.map_sharp,
                  color: Colors.white,
                ))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Radio(
                      activeColor: Colors.white,
                      value: "Erkek",
                      groupValue: cinsiyetValue,
                      onChanged: (String? index) {
                        setState(() {
                          cinsiyetValue = index!;
                        });
                      }),
                  Expanded(
                      child: Text(
                    'Erkek',
                    style: Sabitler.textStyle,
                  ))
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Radio(
                      activeColor: Colors.white,
                      value: "Kadın",
                      groupValue: cinsiyetValue,
                      onChanged: (String? index) {
                        setState(() {
                          cinsiyetValue = index!;
                        });
                      }),
                  Expanded(
                      child: Text(
                    'Kadın',
                    style: Sabitler.textStyle,
                  ))
                ],
              ),
            ),
          ],
        ),
        TextField(
            style: Sabitler.textStyle,
            onTap: (() => {
                  DatePicker.showDatePicker(
                    context,
                    initialDateTime: DateTime.now(),
                    minDateTime: DateTime(1950),
                    maxDateTime: DateTime.now(),
                    dateFormat: dd + " " + MM + " " + yyyy,
                    onConfirm: (dateTime, selectedIndex) {
                      setState(() {
                        dogumTarihiDatetime = dateTime;
                        dogumTarihi.text =
                            formatDate(dateTime, [dd, '/', mm, '/', yyyy]);
                      });
                    },
                  )
                }),
            controller: dogumTarihi,
            readOnly: true,
            decoration: Sabitler.inputDecoration(
                "Doğum Tarihi Giriniz",
                Icon(
                  Icons.cake,
                  color: Colors.white,
                ))),
        TextField(
            style: Sabitler.textStyle,
            controller: baslangicTarih,
            readOnly: true,
            onTap: (() => {
                  DatePicker.showDatePicker(
                    context,
                    initialDateTime: DateTime.now(),
                    minDateTime: DateTime(1950),
                    maxDateTime: DateTime(2050, 1, 1),
                    dateFormat: dd + " " + MM + " " + yyyy,
                    onConfirm: (dateTime, selectedIndex) {
                      setState(() {
                        kontratBaslangicTarihi = dateTime;
                        baslangicTarih.text =
                            formatDate(dateTime, [dd, '/', mm, '/', yyyy]);
                      });
                    },
                  )
                }),
            decoration: Sabitler.inputDecoration(
                "Kontrat Başlangıç Tarihi Giriniz",
                Icon(
                  LineIcons.fileSignature,
                  color: Colors.white,
                ))),
        TextField(
            style: Sabitler.textStyle,
            keyboardType: TextInputType.number,
            controller: kontratSuresi,
            decoration: Sabitler.inputDecoration(
                "Kontrat Süresi Giriniz",
                Icon(
                  Icons.timelapse,
                  color: Colors.white,
                ))),
        SizedBox(
          height: 20,
        ),
        ElevatedButton.icon(
            onPressed: () {
              if (isim.text != "" &&
                  soyisim.text != "" &&
                  adres.text != "" &&
                  baslangicTarih.text != "" &&
                  kontratSuresi.text != "") {
                formTamamlandi();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Tüm Alanları Doldurmanız Lazım...",
                    style: TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.blue,
                ));
              }
            },
            icon: Icon(Icons.save),
            label: Text("KAYDET")),
      ],
    );
  }

  void formTamamlandi() async {
    DateTime kontatBitisTarihi = DateTime(
        kontratBaslangicTarihi.year,
        kontratBaslangicTarihi.month + int.parse(kontratSuresi.text),
        kontratBaslangicTarihi.day);
    box.add(Musteri(
        isim.text,
        soyisim.text,
        adres.text,
        telefon.text.toString(),
        cinsiyetValue,
        kontratBaslangicTarihi,
        kontatBitisTarihi,
        dogumTarihiDatetime,
        kontratSuresi.text));
    String result =
        " Kayıt Başarılı \n  ${isim.text} ${soyisim.text}  Müşteri listenize eklendi \n Kontrat Bitiş Tarihi ${formatDate(kontatBitisTarihi, [
          yyyy,
          '/',
          mm,
          '/',
          dd
        ])}";
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        result,
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
    dogumTarihiDatetime = DateTime.now();
    await musterileriOku();
  }

  void search(String query) {
    MusteriListesi = tumMusteriler.where((element) {
      final result = (element.isim + " " + element.soyisim).toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    setState(() {
      musterileriListele();
    });
  }

  void bildirimler() {
    for (int i = 0; i < MusteriListesi.length; i++) {
      Musteri oankiMusteri = MusteriListesi[i];
      DateTime dogumTarihi = oankiMusteri.dogumTarihi;
      int kontratBitis =
          oankiMusteri.kontratBitisTarihi.difference(DateTime.now()).inDays;
      if (dogumTarihi.difference(DateTime.now()).inDays < 0) {
        dogumTarihi = DateTime(DateTime.now().year,
            oankiMusteri.dogumTarihi.month, oankiMusteri.dogumTarihi.day);
      }
      if (dogumTarihi.difference(DateTime.now()).inDays < 0) {
        dogumTarihi = DateTime(DateTime.now().year + 1,
            oankiMusteri.dogumTarihi.month, oankiMusteri.dogumTarihi.day);
      }
      bildirimListesi.add(Bildirim(
          oankiMusteri.sira,
          kontratBitis,
          dogumTarihi.difference(DateTime.now()).inDays,
          oankiMusteri.isim + " " + oankiMusteri.soyisim));
    }
  }
}

List<Musteri> listeleme(List<Musteri> liste) {
  for (int i = 0; i < liste.length; i++) {
    liste[i].sira = i;
  }
  Musteri aktarma;
  for (int i = 0; i < liste.length; i++) {
    int minId = i;
    for (int j = 0; j < liste.length; j++) {
      if (liste[minId].kontratBitisTarihi.difference(DateTime.now()).inDays <
          liste[j].kontratBitisTarihi.difference(DateTime.now()).inDays) {
        minId = j;
        aktarma = liste[j];
        liste[j] = liste[i];
        liste[i] = aktarma;
      }
    }
  }

  return liste;
}
