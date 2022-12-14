import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/block_pattern/imc_block_pattern_page.dart';
import 'package:flutter_default_state_manager/change_notifier/imc_change_notifier_page.dart';
import 'package:flutter_default_state_manager/setState/imc_setstate_page.dart';
import 'package:flutter_default_state_manager/value_notifier/imc_value_notifier_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _goToPage(context, const ImcSetstatePage()),
              child: const Text('SetState'),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, const ImcValueNotifierPage()),
              child: const Text('ValueNotifier'),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, const ImcChangeNotifier()),
              child: const Text('ChangeNotifier'),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, const ImcBlockPatternPage()),
              child: const Text('Block Pattern (Streams)'),
            ),
          ],
        ),
      ),
    );
  }
}
