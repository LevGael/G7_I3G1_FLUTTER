import 'package:flutter/material.dart';
import 'package:projet_contact/contact/contact_ajout.dart';
import 'package:projet_contact/contact/model/db_contact.dart';
import 'package:projet_contact/contact/widgets/contact_tile.dart';
import 'package:projet_contact/contact/widgets/message_input.dart';

import 'contact_detail.dart';
import 'model/contact.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);
  @override
  State<ContactList> createState() => _ContactListState();

  static void GetListe() async  {
    var contacttest = const Contacts(
        id: 0,
        nom: 'Dechamp',
        prenom: 'Paul',
        mail: 'Dechamp@mail.com',
        lieu: 'Limoges',
        tel: "0650467791",
    );

    Contactmain.insertContact(contacttest);
  }
}

class _ContactListState extends State<ContactList> {
  //List<Contacts> Lescontacts = Contactmain.getcontacts() as List<Contacts>;




  final List<Contact> _message = [];
 // List<Contact> contacts = [
   // Contact(nom: 'Dupont', prenom: 'Jean',mail: 'duponjean@gmail.com',lieux: 'Limoges',numero: 060444565, photo: 'image1.png'),
   // Contact(nom: 'Dupont', prenom: 'Serge',mail: 'duponsg@gmail.com',lieux: 'Lyon',numero: 060654434, photo: 'image1.png'),
   // Contact(nom: 'Dupont', prenom: 'Paul',mail: 'duponpl@gmail.com',lieux: 'Bordeaux',numero: 060444432, photo: 'image1.png'),
   // Contact(nom: 'Jean', prenom: 'Paul',mail: 'jeanpl@gmail.com',lieux: 'Paris',numero: 056545654, photo: 'image1.png'),
   // Contact(nom: 'Jean', prenom: 'Pierre',mail: 'jeanpr@gmail.com',lieux: 'Limoges',numero: 075990854, photo: 'image1.png'),
   // Contact(nom: 'Jean', prenom: 'Marie',mail: 'jeanmar@gmail.com',lieux: 'Limoges',numero: 054245543, photo: 'image1.png'),
   // Contact(nom: 'Jean', prenom: 'DeDieu',mail: 'jeandedieu@gmail.com',lieux: 'Paris',numero: 0588944543, photo: 'image1.png'),
   // Contact(nom: 'Heme', prenom: 'Biscuit',mail: 'aimebis@gmail.com',lieux: 'Lyon',numero: 0655443435, photo: 'image1.png'),
   // Contact(nom: 'Heme', prenom: 'Pimpim',mail: 'aimepp@gmail.com',lieux: 'Marseille',numero: 0549022234, photo: 'image1.png'),
   // Contact(nom: 'Dupont', prenom: 'Jean',mail: 'duponjean@gmail.com',lieux: 'Limoges',numero: 060444565, photo: 'image1.png'),
   // Contact(nom: 'Dupont', prenom: 'Serge',mail: 'duponsg@gmail.com',lieux: 'Lyon',numero: 060654434, photo: 'image1.png'),
   // Contact(nom: 'Dupont', prenom: 'Paul',mail: 'duponpl@gmail.com',lieux: 'Bordeaux',numero: 060444432, photo: 'image1.png'),
   // Contact(nom: 'Jean', prenom: 'Paul',mail: 'jeanpl@gmail.com',lieux: 'Paris',numero: 056545654, photo: 'image1.png'),
   // Contact(nom: 'Jean', prenom: 'Pierre',mail: 'jeanpr@gmail.com',lieux: 'Limoges',numero: 075990854, photo: 'image1.png'),
   // Contact(nom: 'Jean', prenom: 'Marie',mail: 'jeanmar@gmail.com',lieux: 'Limoges',numero: 054245543, photo: 'image1.png'),
   // Contact(nom: 'Jean', prenom: 'DeDieu',mail: 'jeandedieu@gmail.com',lieux: 'Paris',numero: 0588944543, photo: 'image1.png'),
   // Contact(nom: 'Heme', prenom: 'Biscuit',mail: 'aimebis@gmail.com',lieux: 'Lyon',numero: 0655443435, photo: 'image1.png'),
   // Contact(nom: 'Heme', prenom: 'Pimpim',mail: 'aimepp@gmail.com',lieux: 'Marseille',numero: 0549022234, photo: 'image1.png'),
  //];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mes Contacts',
        ),
        actions: const <Widget>[
          Icon(
            Icons.search,
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

                        return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) => ContactTile(

                                message: snapshot.data![index].nom,
                                user: snapshot.data![index].prenom,
                                onPressed: (){
                                  setState(() {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context)=> ContactDetail(nom: snapshot.data![index].nom, prenom: snapshot.data![index].prenom,
                                                mail: snapshot.data![index].mail, lieux: snapshot.data![index].lieu, numero: int.parse(snapshot.data![index].tel),
                                                photo: 'image1.png')

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
             // ListView.builder(
              //    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
               //   itemCount: contacts.length,
                //  itemBuilder: (context, index) {

                  //  return ContactTile(message: contacts[index].nom, user: contacts[index].prenom, onPressed: (){
                  //    setState(() {
                   //     Navigator.of(context).push(
                    //        MaterialPageRoute(
                     //           builder: (context)=> ContactDetail(nom: contacts[index].nom, prenom: contacts[index].prenom,
                     //             mail: contacts[index].mail, lieux: contacts[index].lieux, numero: contacts[index].numero,
                     //             photo: contacts[index].photo)
                     //       )
                     //   );
                       // Navigator.push(context,MaterialPageRoute(builder: builder))
                    //  });
                   // },);
                  //}),
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
