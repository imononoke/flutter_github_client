import 'dart:developer';

import 'package:github/pages/details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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

  void getList() async {
    try {
      var response = await dio.get(
          'https://api.github.com/search/repositories?q=${widget.category}');
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
    return //Expanded(
        // child:
    ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext cxt, int index) {
              var item = list[index];
              return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RepoDetail(
                        name: item['name'],
                        fullName: item['full_name'],
                        htmlUrl: item['html_url'],
                      );
                    }));
                  },
                  child: Container(
                      height: 160,
                      padding: const EdgeInsets.only(left: 12),
                      decoration: const BoxDecoration(
                          border: Border(top: BorderSide(color: Colors.grey))),
                      child: Align(
                          alignment: Alignment.center,
                          child: Row(children: <Widget>[
                            // avatar
                            if (item['owner']['avatar_url'] != null)
                              Image.network(
                                item['owner']['avatar_url'],
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),

                            // info
                            Container(
                              padding: const EdgeInsets.only(left: 12),
                              height: 120,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      item["name"],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),

                                    SizedBox(
                                        width: 260,
                                        child: Text(
                                          item["full_name"],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        )),

                                    SizedBox(
                                        width: 260,
                                        child: Text(
                                          item['html_url'],
                                          style: const TextStyle(fontSize: 14),
                                        )),

                                    // SizedBox(
                                    //     width: 260,
                                    //     child: item['description']?.Text(item['description'])
                                    // )
                                  ]),
                            )
                          ]))));
            });
    // );
    //'Category: ${widget.category} -- ${list.length}');
  }
}
