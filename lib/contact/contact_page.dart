import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projet_contact/contact/contact_ajout.dart';
import 'package:projet_contact/contact/model/db_contact.dart';
import 'package:projet_contact/contact/widgets/contact_tile.dart';
import 'package:projet_contact/contact/widgets/message_input.dart';

import 'contact_detail.dart';
import 'model/contact.dart';
List<String> allNames = [];
class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);
  @override
  State<ContactList> createState() => _ContactListState();

  static void GetListe() async  {

  }
}

class _ContactListState extends State<ContactList> {
  //List<Contacts> Lescontacts = Contactmain.getcontacts() as List<Contacts>;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mes Contacts',
        ),
        actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
            );
          },
        ),
          Icon(
            Icons.more_vert
          )
        ],
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(8.8),
        child: Column(
          children: <Widget>[

            Expanded(
              child:

              FutureBuilder<List<Contacts>>(
                  future: Contactmain.getcontacts(),
                  builder: (context, AsyncSnapshot<List<Contacts>> snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError){
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.hasData){
                      if (snapshot.data != null){
                        var length = snapshot.data?.length?.toInt() ?? 0;
                        for (var i = 0; i < length; i++) {
                       allNames.add(snapshot.data![i].nom+" "+snapshot.data![i].prenom);
                     }
                        return ListView.builder(

                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) => ContactTile(

                                message: snapshot.data![index].nom,
                                user: snapshot.data![index].prenom,
                                onPressed: (){
                                  setState(() {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context)=> ContactDetail(contacts: snapshot.data![index])

                                        )
                                    );
                                    // Navigator.push(context,MaterialPageRoute(builder: builder))
                                  });
                                }
                            )
                        );

                      }
                    }
                    return const CircularProgressIndicator();
                  }
              ),
            ),
            FloatingActionButton(
                child: const Icon(
                  Icons.add,
                ),
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> const ContactAjouter()));
                }),
          ],
        ),
      ),
    );
  }

}

class CustomSearchDelegate extends SearchDelegate {
  var suggestion = [];
  List<String> searchResult = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchResult.clear();
    searchResult =
        allNames.where((element) => element.startsWith(query)).toList();
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView(

          padding: EdgeInsets.only(top: 8, bottom: 8),
          scrollDirection: Axis.vertical,
          children: List.generate(suggestion.length, (index) {
            var item = suggestion[index];
            return Card(

              color: Colors.white,
              child: Container(padding: EdgeInsets.all(16), child: Text(item)),
            );
          })),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    debugPrint(allNames.length.toString());
    final suggestionList = query.isEmpty
        ? suggestion
        : allNames.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {

          if (query.isEmpty) {
            query = suggestion[index];
          }
        },
        leading: Icon(query.isEmpty ? Icons.history : Icons.search),
        title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () async {


                      Contacts Cont = await Contactmain.getcontactsbyname(suggestionList[index]) ;
                       Navigator.of(context).push(
                          MaterialPageRoute(
                           builder: (context)=> ContactDetail(contacts: Cont)

                            )
                        );
                         //Navigator.push(context,MaterialPageRoute(builder: builder))

                    },
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Color(0xff727272)),
                  )
                ])),

      ),

      itemCount: suggestionList.length,

    );

  }
}


