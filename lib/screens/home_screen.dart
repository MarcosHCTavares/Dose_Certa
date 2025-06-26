import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/medicamento.dart';
import '../services/notification_service.dart';
import 'cadastro_medicamento_screen.dart';

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
    setState(() {}); // Atualiza a tela após voltar
    _scheduleAllNotifications(); // Reagenda notificações após alteração
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicamentos'),
      ),
      body: ValueListenableBuilder<Box<Medicamento>>(
        valueListenable: box.listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('Nenhum medicamento cadastrado.'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final medicamento = box.getAt(index)!;
              return ListTile(
                title: Text(medicamento.nome),
                subtitle: Text('${medicamento.dose} - ${medicamento.horarios.join(', ')}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirCadastro,
        child: const Icon(Icons.add),
      ),
    );
  }
}
