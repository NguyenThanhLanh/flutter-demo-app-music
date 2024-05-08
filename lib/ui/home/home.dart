import 'package:demo_music_app/ui/discovery/discovery.dart';
import 'package:demo_music_app/ui/home/viewmodel.dart';
import 'package:demo_music_app/ui/settings/settings.dart';
import 'package:demo_music_app/ui/user/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/Song.dart';

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: MusicHomePage(),
    );
  }
}

class MusicHomePage extends StatefulWidget {
  const MusicHomePage({super.key});

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  final List<Widget> _tabs = [
    const HomeTab(),
    const DiscoveryTab(),
    const SettingsTab(),
    const AccountTab()
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Music App Demo'),
        ),
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.album), label: 'Discovery'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Account'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
            backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          ),
          tabBuilder: (BuildContext context, int index) {
            return _tabs[index];
          },
        ));
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeTabPage();
  }
}

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  List<Song> songs = [];
  late MusicAppViewModel _viewModel;

  @override
  void initState() {
    _viewModel = MusicAppViewModel();
    _viewModel.loadSongs();
    ObserverData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody(){
    bool showLoading = songs.isEmpty;
    if(showLoading){
      return GetProgressBar();
    } else {
      return GetListView();
    }
  }

  Widget GetProgressBar(){
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  ListView GetListView(){
    return ListView.separated(
        itemBuilder: (context, pos){
        return GetItemSong(pos);
    }, separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 24,
            endIndent: 24,
          );
    }, itemCount: songs.length
    );
  }

  Widget GetItemSong(int index){
    return Center(
      child: Text("${songs[index].title}"),
    );
  }

  void ObserverData(){
    _viewModel.songStream.stream.listen((songslist) {
      setState(() {
        songs.addAll(songslist);
      });
    });
  }
}

