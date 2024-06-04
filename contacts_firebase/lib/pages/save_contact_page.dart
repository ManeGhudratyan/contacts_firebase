import 'package:contacts_firebase/bloc/save_bloc.dart';
import 'package:contacts_firebase/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SaveContactPage extends StatefulWidget {
  const SaveContactPage({super.key, this.userModel});
  final UserModel? userModel;

  @override
  State<SaveContactPage> createState() => _SaveContactPageState();
}

class _SaveContactPageState extends State<SaveContactPage> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocConsumer<SaveBloc, SaveState>(
        listener: (context, state) {
          if (state is SaveFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error ?? ''),
              ),
            );
          } else if (state is SaveLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Number saved successfully'),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add phone number'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _nameEditingController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  IntlPhoneField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Phone number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () {
                      final String name = _nameEditingController.text;
                      final int phoneNumber = int.parse(_phoneNumberController.text);
                      context.read<SaveBloc>().add(
                            SaveDbEvent(
                              name,
                              phoneNumber,
                            ),
                          );
                    },
                    child: const Text(
                      'Save number',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
