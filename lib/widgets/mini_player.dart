import 'package:flutter/material.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock current song data - replace with actual state management
    const currentSong = {
      'title': 'Neon Dreams',
      'artist': 'Cyber Pulse',
      'cover': '🎵',
      'isPlaying': false,
    };

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF00FFC2).withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Album Art
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF00FFC2).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                '🎵',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Song Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  currentSong['title'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  currentSong['artist'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Controls
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Download to Cloud Button (if not in cloud)
              IconButton(
                onPressed: () {
                  // TODO: Download to cloud
                },
                icon: Icon(
                  Icons.cloud_upload_outlined,
                  color: Colors.white.withOpacity(0.7),
                  size: 20,
                ),
              ),
              
              // Previous
              IconButton(
                onPressed: () {
                  // TODO: Previous song
                },
                icon: const Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              
              // Play/Pause
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF00FFC2),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    // TODO: Toggle play/pause
                  },
                  icon: Icon(
                    currentSong['isPlaying'] as bool
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
              
              // Next
              IconButton(
                onPressed: () {
                  // TODO: Next song
                },
                icon: const Icon(
                  Icons.skip_next,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              
              // Shuffle/Loop/Continuous Toggle
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.repeat,
                  color: Colors.white.withOpacity(0.7),
                  size: 20,
                ),
                color: const Color(0xFF1A1A1A),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'shuffle',
                    child: Row(
                      children: [
                        Icon(Icons.shuffle, color: Colors.white, size: 16),
                        SizedBox(width: 8),
                        Text('Shuffle', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'repeat',
                    child: Row(
                      children: [
                        Icon(Icons.repeat, color: Colors.white, size: 16),
                        SizedBox(width: 8),
                        Text('Repeat', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'continuous',
                    child: Row(
                      children: [
                        Icon(Icons.playlist_play, color: Colors.white, size: 16),
                        SizedBox(width: 8),
                        Text('Continuous', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  // TODO: Handle playback mode change
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}