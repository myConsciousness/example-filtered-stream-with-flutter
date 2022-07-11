import 'package:flutter/material.dart';
import 'package:twitter_api_v2/twitter_api_v2.dart';

class ManageRuleView extends StatefulWidget {
  const ManageRuleView({Key? key}) : super(key: key);

  @override
  State<ManageRuleView> createState() => _ManageRuleViewState();
}

class _ManageRuleViewState extends State<ManageRuleView> {
  final _twitter = TwitterApi(bearerToken: 'Bearerトークンを渡してください。');

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(70, 30, 70, 30),
          child: FutureBuilder(
            future: _twitter.tweetsService.lookupFilteringRules(),
            builder: (_, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final rules = snapshot.data;

              return ListView.builder(
                itemCount: rules.data.length,
                itemBuilder: (__, int index) {
                  return ListTile(
                    title: Text(rules.data[index].value),
                    trailing: ElevatedButton(
                      onPressed: () async {
                        await _twitter.tweetsService.destroyFilteringRules(
                          ruleIds: [rules.data[index].id],
                        );

                        super.setState(() {});
                      },
                      child: const Text('削除'),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
}
