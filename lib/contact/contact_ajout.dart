import 'package:flutter/material.dart';

import 'contact_page.dart';
import 'model/db_contact.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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

  XFile? image;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    if (this.mounted) {
      setState(() {
        image = img;
      });
    }
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Veuillez selectionner le type de media'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.image),
                        Text('Depuis la galerie'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.camera),
                        Text('Prendre une photo'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

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
            image != null
                ? GestureDetector(
              onTap: () {
                myAlert();
              }, // Image tapped
              child: Image.file(
                File(image!.path),
                fit: BoxFit.cover, // Fixes border issues
                width: 110.0,
                height: 110.0,
              ),
            )
                : GestureDetector(
              onTap: () {
                myAlert();
              }, // Image tapped
              child: Image.asset(
                'assets/image1.png',
                fit: BoxFit.cover, // Fixes border issues
                width: 110.0,
                height: 110.0,
              ),
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
                    final Contacts model;
                    if(image != null) {
                      model = Contacts(nom: nom,
                          prenom: prenom,
                          mail: mail,
                          lieu: lieu,
                          tel: tel,
                          photo: image!.path,
                          id: contact?.id);
                    } else {
                       model = Contacts(nom: nom,
                          prenom: prenom,
                          mail: mail,
                          lieu: lieu,
                          tel: tel,
                          photo: "default",
                          id: contact?.id);
                    }
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
