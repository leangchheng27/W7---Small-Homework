import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository _songRepository;
  final PlayerState _playerState;

  List<Song> _songs = [];

  LibraryViewModel({
    required SongRepository songRepository,
    required PlayerState playerState,
  })  : _songRepository = songRepository,
        _playerState = playerState {
    init();
  }

  void init() {
    _songs = _songRepository.fetchSongs();
    _playerState.addListener(_onPlayerStateChanged);
  }

  void _onPlayerStateChanged() {
    notifyListeners();
  }

  List<Song> get songs => _songs;
  Song? get currentSong => _playerState.currentSong;

  void play(Song song) => _playerState.start(song);
  void stop() => _playerState.stop();

}
