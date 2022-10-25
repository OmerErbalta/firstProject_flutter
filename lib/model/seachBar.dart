/*// ignore_for_file: body_might_complete_normally_nullable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:list_gayrimenkul/model/Musteri.dart';
import '../anasayfa.dart';
import '../musteriDetay.dart';

class MyseachDelegete extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear_sharp));
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Musteri> liste = MusteriListesi.where((element) {
      final result = (element.isim + " " + element.soyisim).toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView.builder(
      itemCount: liste.length,
      itemBuilder: ((context, index) {
        final oankiMusteri = liste[index];
        return ListTile(
          title: Text(oankiMusteri.isim + " " + oankiMusteri.soyisim),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      musteriDetayEkrani(oankiMusteri, context)),
            );
          },
        );
      }),
    );
  }
}
*/




