// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print
import 'package:app_apk/controllers/ListControllers.dart';
import 'package:app_apk/navigationBar/google_navBar.dart';
import 'package:app_apk/objects/player.dart';
import 'package:app_apk/objects/team.dart';
import 'package:app_apk/pages/SignInPages/signIn.dart';
import 'package:app_apk/utils/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/playerData.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class ResponsivePadding extends StatelessWidget {
  final Widget child;
  const ResponsivePadding({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).size.width > 650
          ? EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3.8)
          : const EdgeInsets.all(0),
      child: child,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeClass.darkTheme,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              dataList().clearMap();
              //dataList().isLoaded = false;
              getData(snapshot.data!.uid);
              return ResponsivePadding(
                child: google_navBar(),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ResponsivePadding(
              child: LoginPage(),
            );
          }),
    );
  }

  Future<void> getData(String user) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(user).get();
    final allData = querySnapshot.docs.toList();

    for (QueryDocumentSnapshot dataMap in allData) {
      teamWidget x =
          teamWidget.fromteamWidget(dataMap["team_Name"], dataMap.id);
      dataList().addDynamic(x);
      QuerySnapshot qShot = await FirebaseFirestore.instance
          .collection(user)
          .doc(dataMap.id)
          .collection("players")
          .get();

      for (QueryDocumentSnapshot data in qShot.docs.toList()) {
        playerData p = playerData(data["player_Name"], 12, true);
        print(data["playerData"]["Forehand"]["Hit"]);
        p.getStatsList()[0][0] = data["playerData"]["Forehand"]["Hit"] + 0.0;
        p.getStatsList()[1][0] = data["playerData"]["Forehand"]["Miss"] + 0.0;
        p.getStatsList()[0][1] = data["playerData"]["Backhand"]["Hit"] + 0.0;
        p.getStatsList()[1][1] = data["playerData"]["Backhand"]["Miss"] + 0.0;
        p.getStatsList()[0][2] = data["playerData"]["Volley"]["Hit"] + 0.0;
        p.getStatsList()[1][2] = data["playerData"]["Volley"]["Miss"] + 0.0;
        p.getStatsList()[0][3] = data["playerData"]["Overhead"]["Hit"] + 0.0;
        p.getStatsList()[1][3] = data["playerData"]["Overhead"]["Miss"] + 0.0;
        p.getStatsList()[0][4] = data["playerData"]["Serve"]["Hit"] + 0.0;
        p.getStatsList()[1][4] = data["playerData"]["Serve"]["Miss"] + 0.0;
        p.getStatsList()[0][5] = data["playerData"]["WinLoss"]["Hit"] + 0.0;
        p.getStatsList()[1][5] = data["playerData"]["WinLoss"]["Miss"] + 0.0;
        dataList().addPlayer(
            x,
            playerWidget.fromplayerWidget(data["player_Name"], data.id,
                p /*playerData will be done in later updates*/, x));
      }
    }
    //dataList().isLoaded = true;
  }
}

/*import 'package:app_apk/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DemoApp(),
    );
  }
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  YoutubeAPI youtube = YoutubeAPI(API_KEY);
  List<YouTubeVideo> videoResult = [];

  Future<void> callAPI() async {
    String query = "Tennis Forehand";
    videoResult = await youtube.search(
      query,
      order: 'relevance',
      videoDuration: 'any',
    );
    videoResult = await youtube.nextPage();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('Youtube API'),
      ),
      body: ListView(
        children: videoResult.map<Widget>(listItem).toList(),
      ),
    );
  }

  Widget listItem(YouTubeVideo video) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7.0),
        padding: EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Image.network(
                video.thumbnail.small.url ?? '',
                width: 120.0,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    video.title,
                    softWrap: true,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0),
                    child: Text(
                      video.channelTitle,
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    video.url,
                    softWrap: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}*/
