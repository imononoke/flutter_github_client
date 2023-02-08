import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'category.dart';

/*
test
 */

var testContent = '''
{
  "login": "DuGuQiuBai",
  "id": 15995080,
  "node_id": "MDEyOk9yZ2FuaXphdGlvbjE1OTk1MDgw",
  "avatar_url": "https://avatars.githubusercontent.com/u/15995080?v=4",
  "gravatar_id": "",
  "url": "https://api.github.com/users/DuGuQiuBai",
  "html_url": "https://github.com/DuGuQiuBai",
  "followers_url": "https://api.github.com/users/DuGuQiuBai/followers",
  "following_url": "https://api.github.com/users/DuGuQiuBai/following{/other_user}",
  "gists_url": "https://api.github.com/users/DuGuQiuBai/gists{/gist_id}",
  "starred_url": "https://api.github.com/users/DuGuQiuBai/starred{/owner}{/repo}",
  "subscriptions_url": "https://api.github.com/users/DuGuQiuBai/subscriptions",
  "organizations_url": "https://api.github.com/users/DuGuQiuBai/orgs",
  "repos_url": "https://api.github.com/users/DuGuQiuBai/repos",
  "events_url": "https://api.github.com/users/DuGuQiuBai/events{/privacy}",
  "received_events_url": "https://api.github.com/users/DuGuQiuBai/received_events",
  "type": "Organization",
  "site_admin": false,
  "name": "独孤求败",
  "company": null,
  "blog": "",
  "location": "中国",
  "email": null,
  "hireable": null,
  "bio": "专注于Android",
  "twitter_username": null,
  "public_repos": 6,
  "public_gists": 0,
  "followers": 53,
  "following": 0,
  "created_at": "2015-11-24T07:53:00Z",
  "updated_at": "2015-11-24T08:41:22Z"
}
''';

class ShowJson extends StatefulWidget {
  final String url;

  const ShowJson({Key? key, required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ShowJsonState();
  }
}

class _ShowJsonState extends State<ShowJson> {
  String content = "";

  @override
  void initState() {
    super.initState();
    // EasyLoading.show(status: "loading...");
    // fetchData();
  }

  Future<void> fetchData() async {
    try {
      // https://api.github.com/repos/flutter/flutter
      var response = await dio.get(widget.url);
      var res = response;
      if (kDebugMode) {
        print(res);
      }

      setState(() {
        content = res as String;
      });

      // EasyLoading.dismiss();
    } catch (e) {
      log(e.toString());
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("url content"), centerTitle: true),
        body: Column(children: [
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(testContent,
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontStyle: FontStyle.italic))))
        ]));
  }
}
