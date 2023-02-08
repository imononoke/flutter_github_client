import 'dart:developer';

import 'package:github/pages/details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:github/pages/showJson.dart';

Dio dio = Dio();

class RepoList extends StatefulWidget {
  final String category;

  const RepoList({Key? key, required this.category}) : super(key: key);

  @override
  State<RepoList> createState() {
    return RepoListState();
  }
}

class RepoListState extends State<RepoList> {
  int page = 1;
  int pageSize = 10;
  int total = 0;
  var list = [];

  final String baseUrl = 'https://api.github.com/search/repositories?q=';

  void getList() async {
    try {
      var response = await dio.get(baseUrl + widget.category);
      var res = response.data;
      if (kDebugMode) {
        print(res);
      }

      setState(() {
        total = res['total_count'];
        list = res['items'];
      });

      EasyLoading.dismiss();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: "loading...");
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext cxt, int index) {
          var item = list[index];
          return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RepoDetail(
                    name: item['name'],
                    fullName: item['full_name'],
                    htmlUrl: item['html_url'],
                  );
                }));
              },
              child: Container(
                  height: 160,
                  padding: const EdgeInsets.only(left: 10, top: 15),
                  decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey))),
                  child: Align(
                      alignment: Alignment.center,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // avatar
                            if (item['owner']['avatar_url'] != null)
                              Image.network(
                                item['owner']['avatar_url'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),

                            // info
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              width: 240,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        item["name"],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          item["full_name"],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    Expanded(
                                        child: Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 15),
                                            child: SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: Text(
                                                    // if description is null, show empty
                                                    item['description'] ?? ' ',
                                                    style: const TextStyle(
                                                        fontSize: 16)))))
                                  ]),
                            ),

                            Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                    onPressed: () {
                                      // show json file
                                      var url = item['url'];
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return ShowJson(url: url);
                                      }));
                                    },
                                    iconSize: 24,
                                    icon: const Icon(Icons.file_open)))
                          ]))));
        });
  }
}
