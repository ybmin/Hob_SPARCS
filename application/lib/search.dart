import 'package:flutter/material.dart';

import 'src/group.dart';
import 'package:firebase_core/firebase_core.dart';

class searchPage extends StatelessWidget {
  const searchPage({super.key});

  @override
  Widget build(BuildContext context) {
    String _keyword;
    return Material(
      animationDuration: const Duration(milliseconds: 1000),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "Search",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              TextField(
                onChanged: (keyword) => _keyword = keyword,
              ),
            ],
          ),
          /* 소모임 리스트 */
        ],
      ),
    );
  }
}
