import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge_range.dart';
import 'package:flutter_default_state_manager/widgets/imc_gaunge.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcSetstatePage extends StatefulWidget {
  const ImcSetstatePage({Key? key}) : super(key: key);

  @override
  State<ImcSetstatePage> createState() => _ImcSetstatePageState();
}

class _ImcSetstatePageState extends State<ImcSetstatePage> {
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();
  var imc = 0.0;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pesoController.dispose();
    alturaController.dispose();
    super.dispose();
  }

  Future<void> _calcularIMC({
    required double peso,
    required double altura,
  }) async {
    setState(() {
      imc = 0;
    });

    await Future.delayed(Duration(seconds: 1));
    setState(() {
      imc = peso / pow(altura, 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imc SetState'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ImcGauge(imc: imc),
                const SizedBox(
                  height: 20,
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
                      _calcularIMC(peso: peso, altura: altura);
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
