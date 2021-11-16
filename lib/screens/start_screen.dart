import 'package:flutter/material.dart';
import 'package:oxi_sim/screens/simulator_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oxi Sim'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Wähle einen Modus',
            style: Theme.of(context).textTheme.headline5,
          ),
          Expanded(
            child: Material(
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SimulatorScreen(),
                    )),
                child: const Text('Simulator'),
              ),
            ),
          ),
          const Expanded(
            child: Material(
              child: InkWell(
                onTap: null,
                child: Text('Anweiser'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
