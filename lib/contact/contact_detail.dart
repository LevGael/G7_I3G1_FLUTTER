import 'package:flutter/material.dart';
import 'package:projet_contact/contact/model/db_contact.dart';

import 'model/contact.dart';
import 'dart:io';
class ContactDetail extends StatefulWidget {
  const ContactDetail({Key? key,
  required this.contact}) : super(key: key);
  final Contacts contact;

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  List<Contact> contacts = [];

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
                  child: widget.contact.photo == "default"
                      ?
                  Image.asset(
                    'assets/image1.png',
                    fit: BoxFit.cover, // Fixes border issues
                    width: 150.0,
                    height: 150.0,
                  )
                  :
                  Image.file(
                    File(widget.contact.photo),
                    height: 150.0,
                    width: 150.0,
                    fit:BoxFit.cover, //change image fill type
                  ),
                )
            ),
            Card(
              child: Text(widget.contact.nom, textAlign: TextAlign.center, style: const TextStyle(
                  fontSize: 26.0
              )),
            ),
            const SizedBox(
              height: 26,
            ),
            Card(
              child: ListTile(
                title: Text('Tel: ${widget.contact.tel}', style: const TextStyle(
                    fontSize: 26.0
                )),
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            Card(
              child: ListTile(
                title: Text('Nom: ${widget.contact.nom}', style: const TextStyle(
                    fontSize: 26.0
                )),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Prenom: ${widget.contact.prenom}', style: const TextStyle(
                    fontSize: 26.0
                )),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Mail: ${widget.contact.mail}', style: const TextStyle(
                    fontSize: 26.0
                )),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Lieux: ${widget.contact.lieu}', style: const TextStyle(
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
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () async {
                      },
                      child: const Text('  Appel  ', style: TextStyle(
                          fontSize: 26.0
                      )),
                    ),
                  ),
                  Card(
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () { },
                      child: const Text('Modifier', style: TextStyle(
                          fontSize: 26.0
                      )),
                    ),
                  ),
                  Card(
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () { },
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
