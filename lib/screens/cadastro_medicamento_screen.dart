import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/medicamento.dart';

class CadastroMedicamentoScreen extends StatefulWidget {
  const CadastroMedicamentoScreen({super.key});

  @override
  State<CadastroMedicamentoScreen> createState() => _CadastroMedicamentoScreenState();
}

class _CadastroMedicamentoScreenState extends State<CadastroMedicamentoScreen> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();
  final doseController = TextEditingController();
  final horariosController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    descricaoController.dispose();
    doseController.dispose();
    horariosController.dispose();
    super.dispose();
  }

  Future<void> salvarMedicamento() async {
    if (_formKey.currentState!.validate()) {
      final box = Hive.box<Medicamento>('medicamentos');

      List<String> horarios = horariosController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      final med = Medicamento(
        nome: nomeController.text,
        descricao: descricaoController.text,
        dose: doseController.text,
        horarios: horarios,
      );

      await box.add(med);

      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Medicamento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) => value == null || value.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              TextFormField(
                controller: doseController,
                decoration: const InputDecoration(labelText: 'Dose'),
                validator: (value) => value == null || value.isEmpty ? 'Informe a dose' : null,
              ),
              TextFormField(
                controller: horariosController,
                decoration: const InputDecoration(
                  labelText: 'Horários (separados por vírgula, ex: 08:00, 20:00)',
                ),
                validator: (value) => value == null || value.isEmpty ? 'Informe pelo menos um horário' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: salvarMedicamento,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
