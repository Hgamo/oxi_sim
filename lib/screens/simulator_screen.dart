import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oxi_sim/helpers/simulator/init_simulator.dart';
import 'package:oxi_sim/screens/simulator_data_screen.dart';
import 'package:provider/provider.dart';

class SimulatorScreen extends StatelessWidget {
  SimulatorScreen({Key? key}) : super(key: key);
  final int code = Random().nextInt(10000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulator'),
      ),
      body: FutureBuilder<String>(
        future: initSimulator(context.read(), code),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            FirebaseFirestore.instance
                .collection('init_connection')
                .doc(snapshot.data)
                .snapshots()
                .listen((doc) {
              final data = doc.data();
              if (data == null) return;
              if (data['found'] != null && data['found']) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SimulatorDataScreen()),
                );
              }
            });
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dein Code:'),
                  Text(code.toString()),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
