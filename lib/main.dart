import 'package:example/add_rule_view.dart';
import 'package:example/manage_rule_view.dart';
import 'package:flutter/material.dart';

import 'filtered_stream_view.dart';

void main() {
  runApp(MaterialApp(
    home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  'ルール追加',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'ルール管理',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'ストリーム',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AddRuleView(),
            ManageRuleView(),
            FilteredStreamView(),
          ],
        ),
      ),
    ),
    theme: ThemeData(useMaterial3: true),
  ));
}
