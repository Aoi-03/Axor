/// Playlist Model
/// Represents a user-created playlist (The Shelf)
class Playlist {
  final String id;
  final String userId;
  final String name;
  final String description;
  final String? imageUrl;
  final List<String> songIds; // Only store song IDs, not full songs
  final DateTime createdAt;
  final DateTime updatedAt;
  
  Playlist({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.songIds,
    required this.createdAt,
    required this.updatedAt,
  });
  
  // Create Playlist from JSON
  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      name: json['name'] ?? 'Untitled Playlist',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'],
      songIds: List<String>.from(json['songs'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }
  
  // Convert Playlist to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'songs': songIds,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
  
  // Get song count
  int get songCount => songIds.length;
  
  // Check if playlist contains a song
  bool containsSong(String songId) => songIds.contains(songId);
  
  // Copy with method for updates
  Playlist copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    String? imageUrl,
    List<String>? songIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Playlist(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      songIds: songIds ?? this.songIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Vibe Model
/// Represents an AI-generated vibe playlist
class Vibe {
  final String id;
  final String title;
  final String subtitle;
  final String mood;
  final String? timeOfDay;
  final List<String> songIds;
  
  Vibe({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.mood,
    this.timeOfDay,
    required this.songIds,
  });
  
  // Create Vibe from JSON
  factory Vibe.fromJson(Map<String, dynamic> json) {
    // Extract song IDs from songs array
    final songs = json['songs'] as List<dynamic>?;
    final songIds = songs?.map((s) => s['id'] as String).toList() ?? [];
    
    return Vibe(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Untitled Vibe',
      subtitle: json['subtitle'] ?? '',
      mood: json['mood'] ?? 'neutral',
      timeOfDay: json['timeOfDay'],
      songIds: songIds,
    );
  }
  
  // Get song count
  int get songCount => songIds.length;
}
