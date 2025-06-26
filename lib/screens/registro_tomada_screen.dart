import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/registro_tomada.dart';
import '../models/medicamento.dart';

class RegistroTomadaScreen extends StatefulWidget {
  const RegistroTomadaScreen({super.key});

  @override
  State<RegistroTomadaScreen> createState() => _RegistroTomadaScreenState();
}

class _RegistroTomadaScreenState extends State<RegistroTomadaScreen> {
  final _formKey = GlobalKey<FormState>();
  Medicamento? _medSelecionado;
  bool _tomou = true;
  DateTime _horarioTomado = DateTime.now();
  final TextEditingController sintomasController = TextEditingController();

  @override
  void dispose() {
    sintomasController.dispose();
    super.dispose();
  }

  Future<void> _selecionarHorario() async {
    final timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_horarioTomado),
    );
    if (timeOfDay != null) {
      setState(() {
        _horarioTomado = DateTime(
          _horarioTomado.year,
          _horarioTomado.month,
          _horarioTomado.day,
          timeOfDay.hour,
          timeOfDay.minute,
        );
      });
    }
  }

  Future<void> _salvarRegistro() async {
    if (_formKey.currentState?.validate() ?? false) {
      final box = Hive.box<RegistroTomada>('registros');
      await box.add(RegistroTomada(
        nomeMedicamento: _medSelecionado!.nome,
        horarioTomado: _horarioTomado,
        sintomas: sintomasController.text.isNotEmpty ? sintomasController.text : null,
      ));

      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final medicamentos = Hive.box<Medicamento>('medicamentos').values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Tomada')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<Medicamento>(
                decoration: const InputDecoration(labelText: 'Medicamento'),
                items: medicamentos.map((med) {
                  return DropdownMenuItem(
                    value: med,
                    child: Text(med.nome),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _medSelecionado = value),
                validator: (value) => value == null ? 'Selecione um medicamento' : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Horário da tomada'),
                subtitle: Text(
                  '${_horarioTomado.hour.toString().padLeft(2, '0')}:${_horarioTomado.minute.toString().padLeft(2, '0')}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: _selecionarHorario,
                ),
              ),
              SwitchListTile(
                title: const Text('Tomou o medicamento?'),
                value: _tomou,
                onChanged: (val) => setState(() => _tomou = val),
              ),
              TextFormField(
                controller: sintomasController,
                decoration: const InputDecoration(
                  labelText: 'Sintomas (opcional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _salvarRegistro,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Salvar Registro')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
