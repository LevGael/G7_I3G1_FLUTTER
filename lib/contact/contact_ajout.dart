import 'package:flutter/material.dart';

import 'contact_page.dart';
import 'model/db_contact.dart';

class ContactAjouter extends StatefulWidget {
  final Contacts? contact;
  const ContactAjouter({Key? key,this.contact}) : super(key: key);

  Contacts? Getcontact()
  {
   return contact;
  }

  @override
  State<ContactAjouter> createState() => _ContactAjouterState();
}

class _ContactAjouterState extends State<ContactAjouter> {

 // List<Contact> contacts = [];
  Contacts? contact = const ContactAjouter().Getcontact();
  @override
  Widget build(BuildContext context) {

    final nomController = TextEditingController();
    final prenomController = TextEditingController();
    final mailController = TextEditingController();
    final lieuController = TextEditingController();
    final telController = TextEditingController();
    if(contact != null){
      nomController.text = contact!.nom;
      prenomController.text = contact!.prenom;
      mailController.text = contact!.mail;
      lieuController.text = contact!.lieu;
      telController.text = contact!.tel.toString();

    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un contact'),
        actions: const <Widget>[
          Icon(
              Icons.more_vert
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.8),
        child: Column(
          children: <Widget>[
            const ImageIcon(
              AssetImage('assets/image1.png'),
              size: 120,
            ),
             Expanded(
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: telController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Numéro de téléphone',
                ),
              ),
            ),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.text,
                controller: nomController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Votre nom',
                ),
              ),
            ),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.text,
                controller: prenomController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Prenom',
                ),
              ),
            ),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: mailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Adresse mail',
                ),
              ),
            ),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.text,
                controller: lieuController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Adresse postal, lieux',

                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(40.0),
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white70),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                  ),
                  onPressed: () async {
                    final nom = nomController.value.text;
                    final prenom = prenomController.value.text;
                    final mail = mailController.value.text;
                    final lieu = lieuController.value.text;
                    final tel = telController.value.text;

                    if(nom.isEmpty || prenom.isEmpty || mail.isEmpty || lieu.isEmpty || tel.isEmpty ){
                      return;
                    }


                    final Contacts model = Contacts(nom: nom, prenom: prenom, mail: mail, lieu: lieu, tel: tel, id: contact?.id);

                      await Contactmain.insertContact(model);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> const ContactList()));
                  },
                  child: Text('Ajouter'),
                )
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onPressed() {}
}
