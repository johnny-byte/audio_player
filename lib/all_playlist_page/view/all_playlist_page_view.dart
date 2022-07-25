import 'package:audio_player/audio_repository.dart';
import 'package:audio_player/playlist_page/view/playlist_page_view.dart';
import 'package:audio_player/widget/player_panel/view/player_panel_widget.dart';
import 'package:audio_player/youtube_page/youtube_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllPlaylistPage extends StatelessWidget {
  const AllPlaylistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const AllPlaylistPageView(),
      bottomSheet: const PlayerPanel(),
    );
  }
}

class AllPlaylistPageView extends StatelessWidget {
  const AllPlaylistPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
        children: [
          Material(
            color: Colors.red,
            child: InkWell(
              child: const Center(child: Text("YOUTUBE")),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const YoutubePage()),
                );
              },
            ),
          ),
          Material(
            color: Colors.blue,
            child: InkWell(
              child: const Center(child: Text("LOCAL")),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaylistPage(context
                          .read<AudioRepository>()
                          .loadLocalStorageAudio()),
                    ));
              },
            ),
          ),
          Material(
            color: Colors.amber,
            child: InkWell(
              child: const Center(child: Text("TODO")),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaylistPage(context
                          .read<AudioRepository>()
                          .loadLocalStorageAudio()),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
