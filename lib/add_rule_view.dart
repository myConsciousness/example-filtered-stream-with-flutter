import 'package:flutter/material.dart';

// twitter_api_v2を使用するためには以下のimportだけで大丈夫です。
import 'package:twitter_api_v2/twitter_api_v2.dart';

class AddRuleView extends StatefulWidget {
  const AddRuleView({Key? key}) : super(key: key);

  @override
  State<AddRuleView> createState() => _AddRuleViewState();
}

class _AddRuleViewState extends State<AddRuleView> {
  final _twitter = TwitterApi(bearerToken: 'Bearerトークンを渡してください。');

  final _addingRule = TextEditingController();

  String _addedRule = 'NONE';

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(controller: _addingRule),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  // 入力されたルールを追加します。
                  // 追加したルールデータが返却されます。
                  final result = await _twitter.tweets.createFilteringRules(
                    rules: [
                      FilteringRuleParam(value: _addingRule.text),
                    ],
                  );

                  // 追加したルールのIDから再検索をして、
                  // 本当に入力したルールが登録されたのか確認してみます。
                  final addedRule = await _twitter.tweets.lookupFilteringRules(
                    ruleIds: [result.data.first.id],
                  );

                  super.setState(() {
                    _addedRule = addedRule.data.first.value;
                  });
                },
                child: const Text('ルール追加'),
              ),
              const SizedBox(height: 50),
              Text(
                '追加されたルール: $_addedRule',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
}
