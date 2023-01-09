import 'package:flutter/material.dart';

import 'model/contact.dart';

class ContactDetail extends StatefulWidget {
  const ContactDetail({Key? key,
  required this.nom,required this.prenom,
  required this.mail,required this.lieux,
    required this.numero,required this.photo}) : super(key: key);
  final String nom;
  final String prenom;
  final String mail;
  final String lieux;
  final int numero;
  final String photo;

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
                  child: Image.asset(
                    "assets/${widget.photo}",
                    height: 150.0,
                    width: 150.0,
                    fit:BoxFit.cover, //change image fill type
                  ),
                )
            ),
            Card(
              child: Text(widget.nom, textAlign: TextAlign.center, style: const TextStyle(
                  fontSize: 26.0
              )),
            ),
            const SizedBox(
              height: 26,
            ),
            Card(
              child: ListTile(
                title: Text('Tel: ${widget.numero}', style: const TextStyle(
                    fontSize: 26.0
                )),
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            Card(
              child: ListTile(
                title: Text('Nom: ${widget.nom}', style: const TextStyle(
                    fontSize: 26.0
                )),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Prenom: ${widget.prenom}', style: const TextStyle(
                    fontSize: 26.0
                )),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Mail: ${widget.mail}', style: const TextStyle(
                    fontSize: 26.0
                )),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Lieux: ${widget.lieux}', style: const TextStyle(
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
                      onPressed: () { },
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
