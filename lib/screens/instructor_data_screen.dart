import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InstructorDataScreen extends StatefulWidget {
  final String simId;
  const InstructorDataScreen({required this.simId, Key? key}) : super(key: key);

  @override
  State<InstructorDataScreen> createState() => _InstructorDataScreenState();
}

class _InstructorDataScreenState extends State<InstructorDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anweiser'),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('sim_data')
              .doc(widget.simId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              double hf = snapshot.data!.data()!['hf'] ?? 100;
              double sp = snapshot.data!.data()!['sp'] ?? 90;
              return Column(
                children: [
                  Text(
                    'HF',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Slider(
                    value: hf,
                    label: '$hf',
                    onChanged: (value) {
                      setState(() {
                        hf = value;
                      });
                      FirebaseFirestore.instance
                          .collection('sim_data')
                          .doc(widget.simId)
                          .set(
                        {'hf': value},
                        SetOptions(merge: true),
                      );
                    },
                    min: 20,
                    max: 220,
                    divisions: 200,
                  ),
                  Text(
                    'SpO2',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Slider(
                    value: sp,
                    label: '$sp',
                    onChanged: (value) {
                      setState(() {
                        sp = value;
                      });
                      FirebaseFirestore.instance
                          .collection('sim_data')
                          .doc(widget.simId)
                          .set(
                        {'sp': value},
                        SetOptions(merge: true),
                      );
                    },
                    min: 70,
                    max: 100,
                    divisions: 30,
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
