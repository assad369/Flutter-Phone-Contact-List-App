import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../model/contact_list_model.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _phoneNumberTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<ContactListModel> contacts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameTEController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Please enter name';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _phoneNumberTEController,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Please enter Phone number';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    contacts.add(
                      ContactListModel(
                        name: _nameTEController.text,
                        phoneNumber: int.parse(_phoneNumberTEController.text),
                      ),
                    );
                    _clearTextField();
                    setState(() {});
                  }
                },
                child: const Text(
                  'Add',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              contacts.isEmpty
                  ? Center(
                      child: Lottie.network(
                          'https://lottie.host/e0266f05-fb1f-4809-9738-858f978f87cd/LRJa6hT6q0.json',
                          width: 220),
                    )
                  : Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: GestureDetector(
                                onLongPress: () {
                                  print('Long pressed');
                                  _showConfirmationDialogue(index);
                                },
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.person,
                                    color: Colors.green,
                                  ),
                                  title: Text(
                                    contacts[index].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                      contacts[index].phoneNumber.toString()),
                                  trailing: const Icon(
                                    Icons.phone,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialogue(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure to delete this contact?'),
          content: const Text('Deleted contact cant be restored'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                contacts.removeAt(index);
                Navigator.pop(context);

                setState(() {});
              },
              child: const Text('Yes, delete'),
            ),
          ],
        );
      },
    );
  }

  void _clearTextField() {
    _nameTEController.clear();
    _phoneNumberTEController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _nameTEController.dispose();
    _phoneNumberTEController.dispose();
  }
}
