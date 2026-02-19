import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/song.dart';
import 'api_service.dart';
import 'api_config.dart';

/// Audio Player Service
/// Manages audio playback with just_audio
class AudioPlayerService with ChangeNotifier {
  static final AudioPlayerService _instance = AudioPlayerService._internal();
  factory AudioPlayerService() => _instance;
  
  AudioPlayerService._internal() {
    _init();
  }
  
  final AudioPlayer _player = AudioPlayer();
  final ApiService _apiService = ApiService();
  Song? _currentSong;
  List<Song> _playlist = [];
  int _currentIndex = 0;
  int _shuffleRepeatState = 0; // 0: repeat, 1: repeat one, 2: shuffle, 3: AI
  
  // Getters
  AudioPlayer get player => _player;
  Song? get currentSong => _currentSong;
  List<Song> get playlist => _playlist;
  int get currentIndex => _currentIndex;
  bool get isPlaying => _player.playing;
  Duration get position => _player.position;
  Duration get duration => _player.duration ?? Duration.zero;
  int get shuffleRepeatState => _shuffleRepeatState;
  
  // Setter for shuffle/repeat state
  void setShuffleRepeatState(int state) {
    _shuffleRepeatState = state;
    notifyListeners();
  }
  
  void _init() {
    // Listen to player state changes
    _player.playerStateStream.listen((state) {
      notifyListeners();
      
      // Auto-play next song when current finishes
      if (state.processingState == ProcessingState.completed) {
        _handleSongComplete();
      }
    });
    
    // Listen to position changes
    _player.positionStream.listen((_) {
      notifyListeners();
    });
  }
  
  /// Handle song completion based on shuffle/repeat/AI state
  Future<void> _handleSongComplete() async {
    if (_currentSong == null) return;
    
    switch (_shuffleRepeatState) {
      case 0: // Repeat playlist
        playNext();
        break;
      case 1: // Repeat one song
        await _player.seek(Duration.zero);
        await _player.play();
        break;
      case 2: // Shuffle
        _playRandomSong();
        break;
      case 3: // AI mode - play similar song
        await _playAISimilarSong();
        break;
      default:
        playNext();
    }
  }
  
  /// Play random song from playlist (shuffle mode)
  Future<void> _playRandomSong() async {
    if (_playlist.isEmpty) return;
    
    final random = DateTime.now().millisecondsSinceEpoch % _playlist.length;
    _currentIndex = random;
    await playSong(_playlist[_currentIndex], playlist: _playlist, index: _currentIndex);
  }
  
  /// Play AI-suggested similar song
  Future<void> _playAISimilarSong() async {
    if (_currentSong == null) return;
    
    try {
      if (kDebugMode) {
        print('🤖 AI Mode: Finding similar song to ${_currentSong!.title}');
      }
      
      // Fetch similar songs from backend
      final similarSongs = await _apiService.getSimilarSongs(_currentSong!.id);
      
      if (similarSongs.isNotEmpty) {
        // Play the most similar song
        final nextSong = similarSongs.first;
        
        if (kDebugMode) {
          print('🎯 AI suggests: ${nextSong.title} (similarity: ${nextSong.similarity ?? 0})');
        }
        
        // Update playlist with similar songs
        _playlist = similarSongs;
        _currentIndex = 0;
        
        await playSong(nextSong, playlist: _playlist, index: 0);
      } else {
        // Fallback to next song if no similar songs found
        if (kDebugMode) {
          print('⚠️  No similar songs found, playing next');
        }
        playNext();
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error fetching similar songs: $e');
      }
      // Fallback to next song on error
      playNext();
    }
  }
  
  /// Play a song
  Future<void> playSong(Song song, {List<Song>? playlist, int? index}) async {
    try {
      _currentSong = song;
      if (playlist != null) {
        _playlist = playlist;
        _currentIndex = index ?? 0;
      }
      
      final streamUrl = song.streamUrl;
      
      if (kDebugMode) {
        print('🎵 Playing: ${song.title} - ${song.artist}');
        print('📡 Stream URL: $streamUrl');
      }
      
      // Stop current playback first
      await _player.stop();
      
      // Set audio source - direct streaming from MEGA
      if (kDebugMode) {
        print('⏳ Loading stream...');
      }
      
      await _player.setUrl(streamUrl).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Connection timeout - cannot reach backend');
        },
      );
      
      if (kDebugMode) {
        print('✅ Stream loaded, starting playback...');
      }
      
      // Start playing
      await _player.play();
      
      if (kDebugMode) {
        print('✅ Playback started');
      }
      
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error playing song: $e');
      }
      
      // Reset state on error
      _currentSong = null;
      notifyListeners();
      
      // Rethrow so UI can show error
      rethrow;
    }
  }
  
  /// Toggle play/pause
  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
    notifyListeners();
  }
  
  /// Play next song
  Future<void> playNext() async {
    if (_playlist.isEmpty) return;
    
    _currentIndex = (_currentIndex + 1) % _playlist.length;
    await playSong(_playlist[_currentIndex], playlist: _playlist, index: _currentIndex);
  }
  
  /// Play previous song
  Future<void> playPrevious() async {
    if (_playlist.isEmpty) return;
    
    _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
    await playSong(_playlist[_currentIndex], playlist: _playlist, index: _currentIndex);
  }
  
  /// Seek to position
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }
  
  /// Stop playback
  Future<void> stop() async {
    await _player.stop();
    _currentSong = null;
    notifyListeners();
  }
  
  /// Dispose
  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
