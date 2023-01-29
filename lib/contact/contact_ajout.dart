import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  Contacts? contact = const ContactAjouter().Getcontact();
  @override
  Widget build(BuildContext context) {

    final nomController = TextEditingController();
    final prenomController = TextEditingController();
    final mailController = TextEditingController();
    final lieuController = TextEditingController();
    final telController = TextEditingController();
    final photoController = TextEditingController();
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
          //padding: const EdgeInsets.all(8.8),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(9),
                    child:ClipOval( //no need to provide border radius to make circular image
                      child: image != null
                          ? GestureDetector(
                        onTap: () {
                          myAlert();
                        }, // Image tapped
                        child: Image.file(
                          File(image!.path), // Fixes border issues
                          width: 150.0,
                          height: 150.0,
                          fit: BoxFit.cover,
                        ),
                      )
                          : GestureDetector(
                        onTap: () {
                          myAlert();
                        }, // Image tapped
                        child: Image.asset(
                          'assets/image1.png', // Fixes border issues
                          width: 150.0,
                          height: 150.0,
                          fit:BoxFit.cover,
                        ),
                      ),
                    )
                ),

                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: telController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Numéro de téléphone',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: nomController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Votre nom',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: prenomController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Prenom',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: mailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Adresse mail',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: lieuController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Adresse postal, lieux',
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
                    child: const Text('Ajouter', style: TextStyle(fontSize: 20),),
                  ),
                )

              ],
            ),

          ),
        ),

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onPressed() {}
}