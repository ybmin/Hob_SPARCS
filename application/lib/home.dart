import 'package:flutter/material.dart';

import 'search.dart';
import 'group_detail.dart';
import 'group_create.dart';
import 'user_info.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [Column(), Column(), ListView()],
      ),
    );
  }
}
