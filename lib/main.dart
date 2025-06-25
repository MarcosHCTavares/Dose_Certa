import 'package:flutter/material.dart';

void main() {
  runApp(const DoseCertaApp());
}

class DoseCertaApp extends StatelessWidget {
  const DoseCertaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dose Certa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dose Certa')),
      body: const Center(
        child: Text('Bem-vindo ao Dose Certa!'),
      ),
    );
  }
}

