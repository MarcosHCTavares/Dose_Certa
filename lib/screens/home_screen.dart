import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/medicamento.dart';
import '../models/registro_tomada.dart';
import '../services/notification_service.dart';
import 'cadastro_medicamento_screen.dart';
import 'registro_tomada_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Medicamento> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<Medicamento>('medicamentos');

    NotificationService.initialize().then((_) {
      _scheduleAllNotifications();
    });
  }

  void _scheduleAllNotifications() {
    NotificationService.cancelAll();

    final now = DateTime.now();

    for (var i = 0; i < box.length; i++) {
      final med = box.getAt(i)!;

      for (var hora in med.horarios) {
        final partes = hora.split(':');
        if (partes.length != 2) continue;

        final scheduledDate = DateTime(
          now.year,
          now.month,
          now.day,
          int.tryParse(partes[0]) ?? 0,
          int.tryParse(partes[1]) ?? 0,
        );

        final id = i * 100 + med.horarios.indexOf(hora);

        NotificationService.scheduleNotification(
          id: id,
          title: 'Hora do remédio',
          body: '${med.nome} - ${med.dose}',
          scheduledDate: scheduledDate,
        );
      }
    }
  }

  void _abrirCadastro() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CadastroMedicamentoScreen()),
    );
    setState(() {});
    _scheduleAllNotifications();
  }

  void _abrirRegistroTomada() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegistroTomadaScreen()),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dose Certa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.medication_outlined),
            tooltip: 'Registrar Tomada',
            onPressed: _abrirRegistroTomada,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Medicamentos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<Box<Medicamento>>(
            valueListenable: box.listenable(),
            builder: (context, box, _) {
              if (box.isEmpty) {
                return const Text('Nenhum medicamento cadastrado.');
              }

              return Column(
                children: box.values.map((medicamento) {
                  return ListTile(
                    title: Text(medicamento.nome),
                    subtitle: Text('${medicamento.dose} - ${medicamento.horarios.join(', ')}'),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          const Text(
            'Registros Recentes',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<Box<RegistroTomada>>(
            valueListenable: Hive.box<RegistroTomada>('registros').listenable(),
            builder: (context, box, _) {
              final registros = box.values.toList().reversed.toList();

              if (registros.isEmpty) {
                return const Text('Nenhum registro de tomada.');
              }

              return Column(
                children: registros.map((r) {
                  final data = '${r.horarioTomado.day}/${r.horarioTomado.month} ${r.horarioTomado.hour.toString().padLeft(2, '0')}:${r.horarioTomado.minute.toString().padLeft(2, '0')}';
                  return ListTile(
                    title: Text(r.nomeMedicamento),
                    subtitle: Text('Tomado em $data\nSintomas: ${r.sintomas?.trim().isNotEmpty == true ? r.sintomas : 'Nenhum'}'),
                    isThreeLine: true,
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirCadastro,
        tooltip: 'Cadastrar Medicamento',
        child: const Icon(Icons.add),
      ),
    );
  }
}
