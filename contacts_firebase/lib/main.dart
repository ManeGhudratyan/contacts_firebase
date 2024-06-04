import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_firebase/bloc/save_bloc.dart';
import 'package:contacts_firebase/pages/home_page.dart';
import 'package:contacts_firebase/services/add_db_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAPdwkiN8PYPgaT0EVD5smxxWSosY-DNuA',
      appId: '1:385183977119:android:b90260c206f5628f2d9caa',
      messagingSenderId: '',
      projectId: 'fir-project-8ec61',
      storageBucket: '',
    ),
  );

  runApp(
    BlocProvider(
      create: (context) => SaveBloc(AddDbService(FirebaseFirestore.instance)),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    ),
  );
}
