import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_contact/contact/contact_detail.dart';
import 'package:projet_contact/contact/model/db_contact.dart';


class ModifierContact extends StatefulWidget {
  const ModifierContact({Key? key, required this.contacts}) : super(key: key);
  final Contacts contacts;

  @override
  State<ModifierContact> createState() => _ModifierContactState();
}

class _ModifierContactState extends State<ModifierContact> {


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
                    //if user c8lick this button, user can upload image from gallery
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

  @override
  Widget build(BuildContext context) {

    int idContact = widget.contacts.id!;
    String nomContact= widget.contacts.nom;
    String prenomContact = widget.contacts.prenom;
    String mailContact = widget.contacts.mail;
    String lieuContact = widget.contacts.lieu;
    String telContact = widget.contacts.tel;
    String photoContact = widget.contacts.photo;
    //image = photoContact as XFile?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier un contact'),
        actions: const <Widget>[
          Icon(
              Icons.more_vert
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
          child: Form(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(9),
                    child:ClipOval( //no need to provide border radius to make circular image
                      child: photoContact != "default"
                          ? GestureDetector(
                        onTap: () {
                          myAlert();
                        }, // Image tapped
                        child: Image.file(
                          File(photoContact), // Fixes border issues
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
                          'assets/image1.png',
                          fit: BoxFit.cover, // Fixes border issues
                          width: 150.0,
                          height: 150.0,
                        ),
                      ),
                    )
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  initialValue: telContact,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Numéro de téléphone',
                  ),
                  validator: (val) => val!.isEmpty ? 'Entrez votre téléphone': null,
                  onChanged: (val) => telContact = val,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  initialValue: nomContact,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Votre nom',
                  ),
                  validator: (val) => val!.isEmpty ? 'Entrez votre nom': null,
                  onChanged: (val) => nomContact = val,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  initialValue: prenomContact,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Prenom',
                  ),
                  validator: (val) => val!.isEmpty ? 'Entrez votre Prenom': null,
                  onChanged: (val) => prenomContact = val,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  initialValue: mailContact,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Adresse mail',
                  ),
                  validator: (val) => val!.isEmpty ? 'Entrez votre Adresse mail': null,
                  onChanged: (val) => mailContact = val,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  initialValue: lieuContact,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Adresse postal',
                  ),
                  validator: (val) => val!.isEmpty ? 'Entrez votre lieu': null,
                  onChanged: (val) => lieuContact = val,
                ),
                const SizedBox(height: 10),
                Card(
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {

                        if(nomContact.isEmpty || prenomContact.isEmpty || mailContact.isEmpty || lieuContact.isEmpty || telContact.isEmpty ){
                          return;
                        }

                        final Contacts model;

                        if(image == null){
                          model = Contacts(nom: nomContact, prenom: prenomContact, mail: mailContact, lieu: lieuContact, tel: telContact, photo: photoContact, id: idContact);

                        } else {
                          model = Contacts(nom: nomContact, prenom: prenomContact, mail: mailContact, lieu: lieuContact, tel: telContact, photo: image!.path, id: idContact);
                        }


                        await Contactmain.updateContact(model);

                        if(image != null){
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context)=> ContactDetail(
                                    contacts: Contacts(
                                        id: idContact,
                                        nom: nomContact,
                                        prenom: prenomContact,
                                        mail: mailContact,
                                        lieu: lieuContact,
                                        tel: telContact,
                                        photo: image!.path
                                    ),

                                  )
                              )
                          );
                        }else{
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context)=> ContactDetail(
                                    contacts: Contacts(
                                        id: idContact,
                                        nom: nomContact,
                                        prenom: prenomContact,
                                        mail: mailContact,
                                        lieu: lieuContact,
                                        tel: telContact,
                                        photo: photoContact
                                    ),

                                  )
                              )
                          );
                        }
                      },
                      child: const Text('Modidier', style: TextStyle(fontSize: 20),),
                    )
                ),
              ],
            ),

          ),
        ),

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onPressed() {}
}
