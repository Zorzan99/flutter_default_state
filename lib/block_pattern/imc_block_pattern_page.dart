import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/block_pattern/imc_block_pattern_controller.dart';
import 'package:flutter_default_state_manager/block_pattern/imc_state.dart';
import 'package:flutter_default_state_manager/widgets/imc_gaunge.dart';
import 'package:intl/intl.dart';

class ImcBlockPatternPage extends StatefulWidget {
  const ImcBlockPatternPage({Key? key}) : super(key: key);

  @override
  State<ImcBlockPatternPage> createState() => _ImcBlockPatternPageState();
}

class _ImcBlockPatternPageState extends State<ImcBlockPatternPage> {
  final controller = ImcBlockPatternController();
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pesoController.dispose();
    alturaController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Block Pattern'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                StreamBuilder<ImcState>(
                    stream: controller.imcOut,
                    builder: (context, snapshot) {
                      var imc = snapshot.data?.imc ?? 0;
                      return ImcGauge(imc: imc);
                    }),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder<ImcState>(
                  stream: controller.imcOut,
                  builder: (context, snapshot) {
                    final dataValue = snapshot.data;
                    if (dataValue is ImcStateLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (dataValue is ImcStateError) {
                      return Text(dataValue.message);
                    }
                    return const SizedBox.shrink();
                  },
                ),
                TextFormField(
                    controller: pesoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Peso',
                    ),
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'pt_BR',
                        symbol: '',
                        turnOffGrouping: true,
                        decimalDigits: 2,
                      ),
                    ],
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Peso obrigatório';
                      }
                    }),
                TextFormField(
                    controller: alturaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Altura',
                    ),
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'pt_BR',
                        symbol: '',
                        turnOffGrouping: true,
                        decimalDigits: 2,
                      ),
                    ],
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Altura obrigatória';
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    var formValid = formKey.currentState?.validate() ?? false;
                    if (formValid) {
                      var formater = NumberFormat.simpleCurrency(
                        locale: 'pt_BR',
                        decimalDigits: 2,
                      );
                      double peso =
                          formater.parse(pesoController.text) as double;
                      double altura =
                          formater.parse(alturaController.text) as double;
                      controller.calcularImc(peso: peso, altura: altura);
                    }
                  },
                  child: const Text('Calcular IMC'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
