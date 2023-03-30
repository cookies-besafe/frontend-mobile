import 'package:besafe/pages/articles/detail.dart';
import 'package:besafe/pages/articles/list.dart';
import 'package:besafe/pages/sos_request_history.dart';
import 'package:besafe/pages/trusted_contact/add.dart';
import 'package:besafe/pages/trusted_contact/edit.dart';
import 'package:besafe/pages/trusted_contact/list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:besafe/pages/home.dart';
import 'package:besafe/pages/login.dart';
import 'package:besafe/pages/registration.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        '/registration': (context) => const Registration(),
        '/home': (context) => const Home(),

        '/trustedContact/add': (context) => const TrustedContactAdd(),
        '/trustedContact/edit': (context) => const TrustedContactEdit(),
        '/trustedContact/list': (context) => const TrustedContactList(),

        '/sosRequests/history': (context) => const SosRequestHistory(),

        '/articles/list': (context) => const ArticleList(),
        '/articles/detail': (context) => const ArticleDetail(),
      },
    );
  }
}
