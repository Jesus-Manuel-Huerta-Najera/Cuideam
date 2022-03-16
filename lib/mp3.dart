import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'player/PlayingControls.dart';
import 'player/PositionSeekWidget.dart';
import 'player/SongsSelector.dart';

class Musica extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Mymusica(),
    );
  }
}

class Mymusica extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Mymusica> {

  late AssetsAudioPlayer _assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];
  final audios = <Audio>[
    Audio(
      'assets/Marconi Union - Weightless.mp3',
      //playSpeed: 2.0,
      metas: Metas(
        id: 'Weightless',
        title: 'Weightless',
        artist: 'Marconi Union',
        album: 'Single',
        image: const MetasImage.asset('assets/Weightless.jpg'),
      ),
    ),
    Audio(
      'assets/Enya - Watermark.mp3',
      metas: Metas(
        id: 'Watermark',
        title: 'Watermark',
        artist: 'Enya',
        album: 'Single',
        image: const MetasImage.asset('assets/enya.jpg'),
      ),
    ),
    Audio(
      'assets/Coldplay - Strawberry Swing.mp3',
      metas: Metas(
        id: 'Strawberry Swing',
        title: 'Strawberry Swing',
        artist: 'Coldplay',
        album: 'Single',
        image: const MetasImage.asset('assets/estra.jpg'),
      ),
    ),
    Audio(
      'assets/DJ Shah - Mellomaniac.mp3',
      metas: Metas(
        id: 'Mellomaniac',
        title: 'Mellomaniac',
        artist: 'DJ Shah',
        album: 'Single',
        image: const MetasImage.asset('assets/mello.jpg'),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    //_subscriptions.add(_assetsAudioPlayer.playlistFinished.listen((data) {
    //  print('finished : $data');
    //}));
    //openPlayer();
    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));

    openPlayer();
  }

  void openPlayer() async {
    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: false,
    );
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    print('dispose');
    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(0, 151, 167, 150),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    fit: StackFit.passthrough,
                    children: <Widget>[
                      StreamBuilder<Playing?>(
                          stream: _assetsAudioPlayer.current,
                          builder: (context, playing) {
                            if (playing.data != null) {
                              final myAudio = find(
                                  audios, playing.data!.audio.assetAudioPath);
                              print(playing.data!.audio.assetAudioPath);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    depth: 8,
                                    surfaceIntensity: 1,
                                    shape: NeumorphicShape.concave,
                                    boxShape: NeumorphicBoxShape.circle(),
                                  ),
                                  child: myAudio.metas.image?.path == null
                                      ? const SizedBox()
                                      : myAudio.metas.image?.type ==
                                      ImageType.network
                                      ? Image.network(
                                    myAudio.metas.image!.path,
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.contain,
                                  )
                                      : Image.asset(
                                    myAudio.metas.image!.path,
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            }
                            return SizedBox.shrink();
                          }),

                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _assetsAudioPlayer.builderCurrent(
                      builder: (context, Playing? playing) {
                        return Column(
                          children: <Widget>[
                            _assetsAudioPlayer.builderLoopMode(
                              builder: (context, loopMode) {
                                return PlayerBuilder.isPlaying(
                                    player: _assetsAudioPlayer,
                                    builder: (context, isPlaying) {
                                      return PlayingControls(
                                        loopMode: loopMode,
                                        isPlaying: isPlaying,
                                        isPlaylist: true,
                                        toggleLoop: () {
                                          _assetsAudioPlayer.toggleLoop();
                                        },
                                        onPlay: () {
                                          _assetsAudioPlayer.playOrPause();
                                        },
                                        onNext: () {
                                          //_assetsAudioPlayer.forward(Duration(seconds: 10));
                                          _assetsAudioPlayer.next(
                                              keepLoopMode:
                                              true /*keepLoopMode: false*/);
                                        },
                                        onPrevious: () {
                                          _assetsAudioPlayer.previous(
                                            /*keepLoopMode: false*/);
                                        },
                                      );
                                    });
                              },
                            ),
                            _assetsAudioPlayer.builderRealtimePlayingInfos(
                                builder: (context, RealtimePlayingInfos? infos) {
                                  if (infos == null) {
                                    return SizedBox();
                                  }
                                  //print('infos: $infos');
                                  return Column(
                                    children: [
                                      PositionSeekWidget(
                                        currentPosition: infos.currentPosition,
                                        duration: infos.duration,
                                        seekTo: (to) {
                                          _assetsAudioPlayer.seek(to);
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          NeumorphicButton(
                                            onPressed: () {
                                              _assetsAudioPlayer
                                                  .seekBy(Duration(seconds: -10));
                                            },
                                            child: Text('-10'),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          NeumorphicButton(
                                            onPressed: () {
                                              _assetsAudioPlayer
                                                  .seekBy(Duration(seconds: 10));
                                            },
                                            child: Text('+10'),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                }),
                          ],
                        );
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  _assetsAudioPlayer.builderCurrent(
                      builder: (BuildContext context, Playing? playing) {
                        return SongsSelector(
                          audios: audios,
                          onPlaylistSelected: (myAudios) {
                            _assetsAudioPlayer.open(
                              Playlist(audios: myAudios),
                              showNotification: true,
                              headPhoneStrategy:
                              HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                              audioFocusStrategy: AudioFocusStrategy.request(
                                  resumeAfterInterruption: true),
                            );
                          },
                          onSelected: (myAudio) async {
                            try {
                              await _assetsAudioPlayer.open(
                                myAudio,
                                autoStart: true,
                                showNotification: true,
                                playInBackground: PlayInBackground.enabled,
                                audioFocusStrategy: AudioFocusStrategy.request(
                                    resumeAfterInterruption: true,
                                    resumeOthersPlayersAfterDone: true),
                                headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,

                              );
                            } catch (e) {
                              print(e);
                            }
                          },
                          playing: playing,
                        );
                      }),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
