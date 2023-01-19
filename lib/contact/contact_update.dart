import 'package:flutter/material.dart';
import 'package:projet_contact/contact/contact_detail.dart';

import 'model/contact.dart';
import 'model/db_contact.dart';

class ContactUpdate extends StatefulWidget {
  final Contacts? contact;
  const ContactUpdate({Key? key, this.contact}) : super(key: key);

  Contacts? Getcontact()
  {
    return contact;
  }

  @override
  State<ContactUpdate> createState() => _ContactUpdateState();
}

class _ContactUpdateState extends State<ContactUpdate> {
  Contacts? contact = const ContactUpdate().Getcontact();

  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final mailController = TextEditingController();
  final lieuController = TextEditingController();
  final telController = TextEditingController();


  @override
  void initState() {
    super.initState();
    nomController.text = widget.contact!.nom;
    prenomController.text = widget.contact!.prenom;
    mailController.text = widget.contact!.mail;
    lieuController.text = widget.contact!.lieu;
    telController.text = widget.contact!.tel.toString();
  }

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    mailController.dispose();
    lieuController.dispose();
    telController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier contact'),
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
                        MaterialPageRoute(builder: (context)=> ContactDetail(nom: nom, prenom: prenom, mail: mail, lieux: lieu, numero: , photo: widget.contact.)));
                  },
                  child: Text('Valider les Modifications'),
                )
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

