import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class Contactmain {

  static Future<Database> getDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'Contacts_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE Contacts(id INTEGER PRIMARY KEY, nom TEXT, prenom TEXT,mail TEXT,lieu TEXT,tel TEXT,photo TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }


  static Future<void> insertContact(Contacts contact) async {
    // Get a reference to the database.
    final db = await getDB();

    await db.insert(
      'Contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Contacts>> getcontacts() async {
    // Get a reference to the database.
    final db = await getDB();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('contacts');

    // Convert the List<Map<String, dynamic> into a List<Dog>.

    return List.generate(maps.length, (i) {
      return Contacts(
        id: maps[i]['id'],
        nom: maps[i]['nom'],
        prenom: maps[i]['prenom'],
        mail: maps[i]['mail'],
        lieu: maps[i]['lieu'],
        tel: maps[i]['tel'],
        photo: maps[i]['photo'],
      );

    });
  }

  static Future<Contacts> getcontactsbyname(String name) async {
    // Get a reference to the database.
    List<String> split = name.split(' ');
    String nom = split[0];

    final db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query('contacts');
    List<Map> result = await db.rawQuery('SELECT * FROM Contacts WHERE nom=?', [nom]);

    Contacts contact = Contacts(
        id: result[0]['id'],
        nom: result[0]['nom'],
        prenom: result[0]['prenom'],
        mail: result[0]['mail'],
        lieu: result[0]['lieu'],
        tel: result[0]['tel'],
        photo: result[0]['photo'],
    );
   return contact;

  }

  static Future<int> getnbenregistrement() async {
    final db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query('contacts');
    return maps.length;
  }


  static Future<void> updateContact(Contacts contacts) async {
    // Get a reference to the database.
    final db = await getDB();

    // Update the given Dog.
    await db.update(
      'contacts',
      contacts.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [contacts.id],
    );
  }

  static Future<void> deleteContact(int id) async {
    // Get a reference to the database.
    final db = await getDB();

    // Remove the Dog from the database.
    await db.delete(
      'contacts',

      where: 'id = ?',

      whereArgs: [id],
    );
  }



}








class Contacts {
  final int? id;
  final String nom;
  final String prenom;
  final String mail;
  final String lieu;
  final String tel;
  final String photo;

  const Contacts({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.mail,
    required this.lieu,
    required this.tel,
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'mail': mail,
      'lieu': lieu,
      'tel': tel,
      'photo': photo,
    };
  }

  @override
  String toString() {
    return 'contact{id: $id, name: $nom, age: $prenom , mail: $mail, lieu: $lieu, tel: $tel, photo: $photo}';
  }



}

