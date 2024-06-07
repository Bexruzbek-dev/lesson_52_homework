

import 'package:lesson_52_homework/models/contact.dart';
import 'package:lesson_52_homework/services/local_database/contacts_database.dart';

class ContactsController {
  final _contactsDatabase = ContactsDatabase();
  List<Contact> _list = [];

  void createDatabase() async {
    _contactsDatabase.createDatabase();
  }

  Future<void> addContact(String name,String contact) async {
    _contactsDatabase.addContact(name,contact);
  }

  Future<List<Contact>> get list async {
    _list = await _contactsDatabase.getContact();
    return [..._list];
  }
}
