import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RepoDetail extends StatefulWidget {
  final String name;
  final String fullName;
  final String htmlUrl;

  const RepoDetail(
      {key, required this.name, required this.fullName, required this.htmlUrl})
      : super(key: key);

  @override
  DetailState createState() {
    return DetailState();
  }
}

class DetailState extends State<RepoDetail> {
  late WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                child: Stack(children: <Widget>[
              WebView(
                initialUrl: widget.htmlUrl,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller = webViewController;
                },
                onPageFinished: (_) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              isLoading
                  ? Container(
                      color: Colors.white,
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  : Container(),
            ])),
          ],
        ));
  }
}
