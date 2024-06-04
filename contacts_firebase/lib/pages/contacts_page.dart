import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_firebase/bloc/save_bloc.dart';
import 'package:contacts_firebase/pages/update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsPage extends StatelessWidget {
  final Stream<QuerySnapshot> usersStream;

  const ContactsPage({super.key, required this.usersStream});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: BlocConsumer<SaveBloc, SaveState>(
        listener: (context, state) {
          if (state is DeleteFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error ?? 'Delete failed'),
              ),
            );
          } else if (state is DeleteUserFromDBLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Contact deleted successfully'),
              ),
            );
          }
        },
        builder: (context, state) {
          return StreamBuilder<QuerySnapshot>(
            stream: usersStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic>? data =
                      document.data() as Map<String, dynamic>?;

                  if (data != null &&
                      data['name'] != null &&
                      data['phoneNumber'] != null) {
                    final phoneNumber = data['phoneNumber']?.toString() ?? '';
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        leading: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 125, 106, 127),
                          child: Icon(
                            Icons.contact_page,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          data['name'] ?? '',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 118, 106, 121),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          phoneNumber,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdatePage(
                                      userId: data['userId'],
                                      name: data['name'],
                                      phoneNumber: data['phoneNumber'],
                                    ),
                                  ),
                                );
                              },
                              child: const Icon(Icons.edit),
                            ),
                            const SizedBox(width: 16),
                            GestureDetector(
                              onTap: () => _showDeleteDialog(
                                context,
                                data['userId'],
                                data['name'],
                                phoneNumber,
                              ),
                              child:
                                  const Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context, String userId, String name, String phoneNumber) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete Contact'),
        content: const Text('Are you sure you want to delete this contact?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<SaveBloc>().add(
                    DeleteUserFromDBEvent(
                      userId: userId,
                      name: name,
                      phoneNumber: int.tryParse(phoneNumber),
                    ),
                  );
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
