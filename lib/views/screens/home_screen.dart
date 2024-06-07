import 'package:flutter/material.dart';
import 'package:lesson_52_homework/controllers/contacts_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    contactsController.createDatabase();
  }

  final contactsController = ContactsController();
  String data = "Malumot yo'q";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contacts",
        ),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: () async {
              final result = await _showInputDialog(context);
              if (result != null &&
                  result['name'] != null &&
                  result['phone'] != null) {
                await contactsController.addContact(
                    result['name']!, result['phone']!);
                setState(() {});
              }
              data = "Malumot qo'shildi";
              setState(() {});
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: contactsController.list,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final notes = snapshot.data;
          return notes == null || notes.isEmpty
              ? const Center(child: Text("Malumot yoq"))
              : ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      title: Text(notes[index].name),
                      subtitle: Text(notes[index].contact),
                    );
                  },
                );
        },
      ),
    );
  }
}

Future<Map<String, String>?> _showInputDialog(BuildContext context) async {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  return showDialog<Map<String, String>>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text('Enter Details'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(ctx).pop({
                  'name': nameController.text,
                  'phone': phoneController.text,
                });
              }
            },
            child: Text('Submit'),
          ),
        ],
      );
    },
  );
}
