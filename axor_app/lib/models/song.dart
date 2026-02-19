import '../services/api_config.dart';

/// Song Model
/// Represents a song from the backend
class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final int duration;
  final int bpm;
  final double energy;
  final String mood;
  final String genre;
  final String filePath;
  final String? coverPath;
  final int fileSize;
  final String format;
  final int sampleRate;
  final int bitrate;
  final int? year;
  final String? fileName;
  final double? similarity; // For AI similar songs
  final bool? cached; // Is song cached on backend
  final bool? caching; // Is song currently being cached
  final int? cachingProgress; // Caching progress (0-100)
  
  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.duration,
    required this.bpm,
    required this.energy,
    required this.mood,
    required this.genre,
    required this.filePath,
    this.coverPath,
    required this.fileSize,
    required this.format,
    required this.sampleRate,
    required this.bitrate,
    this.year,
    this.fileName,
    this.similarity,
    this.cached,
    this.caching,
    this.cachingProgress,
  });
  
  // Create Song from JSON
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Unknown',
      artist: json['artist'] ?? 'Unknown Artist',
      album: json['album'] ?? 'Unknown Album',
      duration: json['duration'] ?? 0,
      bpm: json['bpm'] ?? 120,
      energy: (json['energy'] ?? 0.5).toDouble(),
      mood: json['mood'] ?? 'neutral',
      genre: json['genre'] ?? 'Unknown',
      filePath: json['filePath'] ?? '',
      coverPath: json['coverPath'],
      fileSize: json['fileSize'] ?? 0,
      format: json['format'] ?? 'FLAC',
      sampleRate: json['sampleRate'] ?? 44100,
      bitrate: json['bitrate'] ?? 1411,
      year: json['year'],
      fileName: json['fileName'],
      similarity: json['similarity']?.toDouble(),
      cached: json['cached'] ?? false,
      caching: json['caching'] ?? false,
      cachingProgress: json['cachingProgress'] ?? 0,
    );
  }
  
  // Convert Song to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'duration': duration,
      'bpm': bpm,
      'energy': energy,
      'mood': mood,
      'genre': genre,
      'filePath': filePath,
      'coverPath': coverPath,
      'fileSize': fileSize,
      'format': format,
      'sampleRate': sampleRate,
      'bitrate': bitrate,
      'year': year,
      'fileName': fileName,
      'similarity': similarity,
      'cached': cached,
      'caching': caching,
      'cachingProgress': cachingProgress,
    };
  }
  
  // Get full streaming URL
  String get streamUrl => ApiConfig.getSongUrl(filePath);
  
  // Get cover art URL
  String get coverUrl => '${ApiConfig.baseUrl}/api/songs/cover/$id';
  
  // Check if has embedded cover
  bool get hasEmbeddedCover => coverPath == 'embedded';
  
  // Format duration as MM:SS
  String get formattedDuration {
    final minutes = duration ~/ 60;
    final seconds = duration % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  
  // Format file size as MB
  String get formattedFileSize {
    final mb = fileSize / (1024 * 1024);
    return '${mb.toStringAsFixed(1)} MB';
  }
  
  // Get energy level description
  String get energyLevel {
    if (energy >= 0.8) return 'Very High';
    if (energy >= 0.6) return 'High';
    if (energy >= 0.4) return 'Medium';
    if (energy >= 0.2) return 'Low';
    return 'Very Low';
  }
}
