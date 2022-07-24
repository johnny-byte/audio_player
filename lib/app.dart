import 'package:audio_player/playlist_page/view/playlist_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audio_player/audio_repository.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AudioRepository(),
      child: MaterialApp(home: PlaylistPage()),
    );
  }
}
