import 'package:flutter/material.dart';
import 'package:twitter_api_v2/twitter_api_v2.dart';

class FilteredStreamView extends StatefulWidget {
  const FilteredStreamView({Key? key}) : super(key: key);

  @override
  State<FilteredStreamView> createState() => _FilteredStreamViewState();
}

class _FilteredStreamViewState extends State<FilteredStreamView> {
  final _twitter = TwitterApi(
      bearerToken:
          'AAAAAAAAAAAAAAAAAAAAAH%2BScQEAAAAATMRDfzf6qRUHVZrmGxsxR6WW%2B6s%3DXYRA0LC2CCcZxtEEjrHhJypot5JtSMBkEXknkSRJEsKZfmyaVG');

  final _tweets = <TweetData>[];

  late Future<TwitterStreamResponse<FilteredStreamResponse>> _stream;

  @override
  void initState() {
    super.initState();
    _stream = _twitter.tweetsService.connectFilteredStream();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureBuilder(
          future: _stream,
          builder: (_, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final stream = snapshot.data.stream;

            return StreamBuilder(
              stream: stream,
              builder: (__, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                _tweets.add(snapshot.data.data);

                return ListView.builder(
                  itemCount: _tweets.length,
                  itemBuilder: (___, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(_tweets[index].id),
                        subtitle: Text(_tweets[index].text),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      );
}
