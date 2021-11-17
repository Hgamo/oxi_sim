import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SimulatorDataScreen extends StatelessWidget {
  const SimulatorDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: const Text('OxiSim'),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('sim_data')
            .doc(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HF: ${snapshot.data!.data()!['hf']}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'SpO2: ${snapshot.data!.data()!['sp']}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
