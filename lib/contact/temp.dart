import 'package:flutter/material.dart';

import 'model/contact.dart';

class ContactAjouter extends StatefulWidget {
  const ContactAjouter({Key? key,}) : super(key: key);

  @override
  State<ContactAjouter> createState() => _ContactAjouterState();
}

class _ContactAjouterState extends State<ContactAjouter> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String nom = "";
  String prenom = "";
  String mail = "";
  String lieux = "";
  int numero = 0;
  String photo = "";


  void _submit() {
    // you can write your
    // own code according to
    // whatever you want to submit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Validation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const ImageIcon(
                    AssetImage('assets/image1.png'),
                    size: 150,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Nom'),
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value) {
                      setState(() {
                        nom = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Invalid nom!';
                      }
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Prenom'),
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value) {
                      setState(() {
                        prenom = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return 'Invalid prenom!';
                      }
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'numero'),
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value) {
                      setState(() {
                        numero = value as int;
                      });
                    },
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return 'Invalid number!';
                      }
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'E-Mail'),
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value) {
                      setState(() {
                        mail = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                    },
                  ),
                  // this is where the
                  // input goes
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'lieux'),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty && value.length < 7) {
                        return 'Invalid password!';
                      }
                    },
                    onFieldSubmitted: (value) {
                      setState(() {
                        lieux = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            // this is where
            // the form field
            // are defined
            const SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                nom.isEmpty ? const Text("No data") : Text(nom),
                const SizedBox(
                  height: 10,
                ),
                prenom.isEmpty ? const Text("No Data") : Text(prenom),
              ],
            )
          ],
        ),
      ),
    );
  }
}
