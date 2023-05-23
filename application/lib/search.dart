import 'package:flutter/material.dart';

import 'src/group.dart';
import 'package:firebase_core/firebase_core.dart';

class searchPage extends StatelessWidget {
  const searchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      animationDuration: const Duration(milliseconds: 1000),
      child: Text("Search Page"),
      // child: Column(
      //   children: [
      //     Row(
      //       children: [
      //         const TextField(),
      //         IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
      //         IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
      //       ],
      //     ),
      //     // Expanded(
      //     //   child: ListView(),
      //     // )
      //   ],
      // ),
    );
  }
}
