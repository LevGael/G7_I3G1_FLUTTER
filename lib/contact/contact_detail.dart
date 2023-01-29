import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:projet_contact/contact/model/db_contact.dart';
import 'package:projet_contact/contact/contact_modifier.dart';
import 'package:projet_contact/contact/contact_modifier.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact_page.dart';

class ContactDetail extends StatefulWidget {
  const ContactDetail({Key? key, required this.contacts}) : super(key: key);
  final Contacts contacts;

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  //List<Contact> contacts = [];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail du contact',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.8),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(9),
                child:ClipOval( //no need to provide border radius to make circular image
                  child: widget.contacts.photo == "default"
                      ?
                  Image.asset(
                    'assets/image1.png',
                    fit: BoxFit.cover, // Fixes border issues
                    width: 150.0,
                    height: 150.0,
                  )
                      :
                  Image.file(
                    File(widget.contacts.photo),
                    height: 150.0,
                    width: 150.0,
                    fit:BoxFit.cover, //change image fill type
                  ),
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => '',
                  icon: const Icon(
                    Icons.mail,
                    color: Colors.purple,
                    size: 30,
                  ),

                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () => '',
                  icon: const Icon(
                    Icons.message,
                    color: Colors.purple,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () => '',
                  icon: const Icon(
                    Icons.location_on,
                    color: Colors.purple,
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 26,
            ),
            Card(
              child: ListTile(
                title: Text('Tel: ${widget.contacts.tel}', style: const TextStyle(
                    fontSize: 26.0
                )),
              ),
            ),
            //const SizedBox(height: 26,),
            Card(
              child: ListTile(
                title: Text('Nom: ${widget.contacts.nom}', style: const TextStyle(
                    fontSize: 26.0
                )),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Prenom: ${widget.contacts.prenom}', style: const TextStyle(
                    fontSize: 26.0
                )),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Mail: ${widget.contacts.mail}', style: const TextStyle(
                    fontSize: 26.0
                )),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Lieux: ${widget.contacts.lieu}', style: const TextStyle(
                    fontSize: 26.0
                  // ignore: prefer_const_constructors
                )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Card(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () async {
                      await FlutterPhoneDirectCaller.callNumber(widget.contacts.tel);
                    },
                    child: const Text('  Appel  ', style: TextStyle(
                        fontSize: 26.0
                    )),
                  ),
                ),
                Card(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: (){
                      final int idc = widget.contacts.id!;
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context)=> ModifierContact(
                                contacts: Contacts(
                                    id: widget.contacts.id!,
                                    nom: widget.contacts.nom,
                                    prenom: widget.contacts.prenom,
                                    mail: widget.contacts.mail,
                                    lieu: widget.contacts.lieu,
                                    tel: widget.contacts.tel,
                                    photo: widget.contacts.photo
                                ),

                              )
                          )
                      );
                    },
                    child: const Text('Modifier', style: TextStyle(
                        fontSize: 26.0
                    )),
                  ),
                ),
                Card(
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {
                        await Contactmain.deleteContact(widget.contacts.id!);

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> ContactList()));
                      },
                      child: const Text('Supprimer', style: TextStyle(
                          fontSize: 26.0
                      )),
                    )
                ),
              ],
            ),
          ],
          //CircleAvatar(backgroundImage: AssetImage(''),),
        ),
      ),
    );
  }
}

