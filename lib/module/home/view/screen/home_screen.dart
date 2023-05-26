// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: const Text("Jake's Git"),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 14),
                const Icon(Icons.book, size: 40),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "abs.io",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      const Text(
                        "dssdfsfcwsf  ",
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.code, size: 15),
                          SizedBox(width: 5),
                          Text(
                            "Java",
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.bug_report, size: 15),
                          SizedBox(width: 5),
                          Text(
                            "0",
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.person_2, size: 15),
                          SizedBox(width: 5),
                          Text(
                            "90",
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(width: 10),
                          Text(
                            index.toString(),
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 14),
              ],
            ),
            SizedBox(height: 10),
            const Divider(height: 1)
          ],
        ),
      ),
    );
  }
}
