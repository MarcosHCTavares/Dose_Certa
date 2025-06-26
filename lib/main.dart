import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/medicamento.dart';
import 'models/registro_tomada.dart';
import 'screens/home_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Hive
  await Hive.initFlutter();

  // Registra os adapters
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(MedicamentoAdapter());
  }

  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(RegistroTomadaAdapter());
  }

  // Abre as boxes necessárias
  await Hive.openBox<Medicamento>('medicamentos');
  await Hive.openBox<RegistroTomada>('registros');

  // Inicializa notificações
  await NotificationService.initialize();

  runApp(const DoseCertaApp());
}

class DoseCertaApp extends StatelessWidget {
  const DoseCertaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dose Certa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
