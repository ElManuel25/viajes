import 'package:flutter/material.dart';
import 'package:viajes/pages/crear_viaje.dart';
import 'package:viajes/pages/home.dart';
import 'package:viajes/pages/login.dart';
import 'package:viajes/pages/register.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) =>  Login(), 
        '/register': (context) => Register(),
        '/crear_viaje': (context) => CrearViaje(),
        '/home': (context) => HomePage(),

      },
      initialRoute: '/home',
    );  
    
  }
}

