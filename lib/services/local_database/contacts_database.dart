
import 'package:lesson_52_homework/models/contact.dart';
import 'package:lesson_52_homework/services/local_database/local_database.dart';

class ContactsDatabase {
  final _localDatabase = LocalDatabase();

  void createDatabase() async {
    final db = await _localDatabase.database;
  }

  Future<void> addContact(String name,String phone) async {
    final db = await _localDatabase.database;

    await db.insert(
      "contacts",
      {
        "name": name,
        "contact": phone,
      },
    );
  }

  Future<List<Contact>> getContact() async {
    final db = await _localDatabase.database;

    final rows = await db.query("contacts");
    List<Contact> contacts = [];
    for (var row in rows) {
      contacts.add(
        Contact(
          id: row["id"] as int,
          name: row["name"] as String,
          contact: row["contact"] as String,
        ),
      );
    }

    return contacts;
  }
}


