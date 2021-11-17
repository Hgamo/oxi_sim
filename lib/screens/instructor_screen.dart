import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oxi_sim/screens/instructor_data_screen.dart';

class InstructorScreen extends StatefulWidget {
  const InstructorScreen({Key? key}) : super(key: key);

  @override
  State<InstructorScreen> createState() => _InstructorScreenState();
}

class _InstructorScreenState extends State<InstructorScreen> {
  var code = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anweiser'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Anweiser',
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              'Bitte gib den Code ein',
              style: Theme.of(context).textTheme.headline5,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Code',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    code = value;
                  });
                },
              ),
            ),
            ElevatedButton(
              child: const Text('Finden'),
              onPressed: code.isEmpty || code.length != 4
                  ? null
                  : () async {
                      final data = await FirebaseFirestore.instance
                          .collection('init_connection')
                          .where('code', isEqualTo: int.parse(code))
                          .get();
                      if (data.docs.isEmpty || data.docs.length != 1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Code nicht gefunden'),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InstructorDataScreen(
                                  simId: data.docs[0]['id']),
                            ));
                        await data.docs[0].reference.update({'found': true});
                        await FirebaseFirestore.instance
                            .collection('sim_data')
                            .doc(data.docs[0]['id'])
                            .set({
                              'hf' : 100,
                              'sp': 90,
                            });
                        data.docs[0].reference.delete();
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
