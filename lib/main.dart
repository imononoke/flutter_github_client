import 'package:github/common/common.dart';
import 'package:github/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'pages/category.dart';

void main() {
  Global.init().then((e) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GitHub Client',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.lightBlue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => AnimatedSplashScreen(
              duration: 3000,
              splash: const Image(
                  image: AssetImage('assets/images/ic_github_girl.png')),
              nextScreen: const GitHubHome(),
              splashTransition: SplashTransition.fadeTransition,
              backgroundColor: Colors.lightBlueAccent),
          // '/InAppBrowser': (context) => InAppBrowserExampleScreen(),
        },
        // home: Container(
        //     alignment: Alignment.center,
        //     child: AnimatedSplashScreen(
        //         duration: 3000,
        //         splash: Icons.games,
        //         nextScreen: const GitHubHome(),
        //         splashTransition: SplashTransition.fadeTransition,
        //         // pageTransitionType: PageTransitionType.scale,
        //         backgroundColor: Colors.lightBlueAccent)),

        builder: EasyLoading.init());
  }
}

class GitHubHome extends StatefulWidget {
  const GitHubHome({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GitHubState();
  }
}

class _GitHubState extends State<GitHubHome> {
  @override
  void initState() {
    super.initState();
    // initialization();
  }

  void onSearch() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const SearchPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("GitHub Repos"),
            centerTitle: true,
            actions: <Widget>[
              IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
            ],
          ),
          drawer: Drawer(
            child: ListView(
                padding: const EdgeInsets.all(2),
                children: const <Widget>[
                  UserAccountsDrawerHeader(
                      accountName: Text("Isa",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)
                      ),
                      accountEmail: Text("isabella@gmail.com",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16)
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://avatars.githubusercontent.com/u/16958028?s=400&u=e0bbd9d4bf9401ab33b658c15b3979075210d5cd&v=4'),
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/bg_green.jpg'),
                      ))),
                  ListTile(
                    title: Text("Feedback"),
                    trailing: Icon(Icons.feedback),
                  ),
                  ListTile(
                    title: Text("Settings"),
                    trailing: Icon(Icons.settings),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Sign Out"),
                    trailing: Icon(Icons.logout),
                  ),
                ]),
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(color: Colors.blue),
            height: 50,
            child: const TabBar(
              labelStyle:
                  TextStyle(height: 0, fontSize: 12, color: Colors.amber),
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Java',
                ),
                Tab(
                  icon: Icon(Icons.favorite),
                  text: 'Kotlin',
                ),
                Tab(
                  icon: Icon(Icons.flutter_dash),
                  text: 'Flutter',
                ),
              ],
            ),
          ),
          body: const TabBarView(children: <Widget>[
            RepoList(category: "java"),
            RepoList(category: "kotlin"),
            RepoList(category: "flutter"),
          ]),
          floatingActionButton: FloatingActionButton(
            onPressed: onSearch,
            child: const Icon(Icons.search),
          ),
        ));
  }
}
