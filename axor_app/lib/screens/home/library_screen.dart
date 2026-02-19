import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../providers/music_provider.dart';
import '../../services/audio_player_service.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  bool _isCloudView = true;
  final bool _isPremiumUser = true; // TODO: Get from backend/auth state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<MusicProvider>(
            builder: (context, musicProvider, child) {
              final songs = musicProvider.allSongs;
              
              return Column(
                children: [
                  // Library Header Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: AppColors.tealCardGradient,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.cyan.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Album Art Placeholder
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: AppColors.cyan.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.library_music,
                            color: AppColors.cyan,
                            size: 35,
                          ),
                        ),
                        const SizedBox(width: 12),
                        
                        // Library Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Master Library (${_isCloudView ? 'Cloud' : 'Local'})',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Flexible(
                                    child: Text(
                                      'Playlist',
                                      style: TextStyle(
                                        color: AppColors.lightGray,
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (_isCloudView && _isPremiumUser) ...[
                                    const SizedBox(width: 4),
                                    const Flexible(
                                      child: Text(
                                        '*premium',
                                        style: TextStyle(
                                          color: AppColors.lightGray,
                                          fontSize: 11,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${songs.length} songs',
                                style: const TextStyle(
                                  color: AppColors.lightGray,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(width: 8),
                        
                        // Toggle Button (only show for premium users)
                        if (_isPremiumUser)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.cyan.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.cyan.withValues(alpha: 0.5),
                                width: 1,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isCloudView = !_isCloudView;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _isCloudView ? Icons.phone_android : Icons.cloud,
                                    color: AppColors.cyan,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _isCloudView ? 'Local' : 'Cloud',
                                    style: const TextStyle(
                                      color: AppColors.cyan,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Loading State
                  if (musicProvider.isLoading)
                    const Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: AppColors.cyan),
                            SizedBox(height: 16),
                            Text(
                              'Loading your music...',
                              style: TextStyle(color: AppColors.lightGray),
                            ),
                          ],
                        ),
                      ),
                    )
                  // Song List
                  else if (songs.isEmpty)
                    const Expanded(
                      child: Center(
                        child: Text(
                          'No songs in library',
                          style: TextStyle(color: AppColors.lightGray),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: Consumer<AudioPlayerService>(
                        builder: (context, audioPlayer, child) {
                          return ListView.builder(
                            itemCount: songs.length,
                            itemBuilder: (context, index) {
                              final song = songs[index];
                              final isCurrentSong = audioPlayer.currentSong?.id == song.id;
                              
                              return GestureDetector(
                                onTap: () async {
                                  // Play song when tapped
                                  try {
                                    await audioPlayer.playSong(song, playlist: songs, index: index);
                                  } catch (e) {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Failed to play: ${e.toString()}'),
                                          backgroundColor: Colors.red,
                                          duration: const Duration(seconds: 3),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isCurrentSong 
                                        ? AppColors.cyan.withValues(alpha: 0.1)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      // Album Art
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: AppColors.cyan.withValues(alpha: 0.2),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: song.hasEmbeddedCover
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.circular(6),
                                                child: Image.network(
                                                  song.coverUrl,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return const Icon(
                                                      Icons.music_note,
                                                      color: AppColors.cyan,
                                                      size: 20,
                                                    );
                                                  },
                                                ),
                                              )
                                            : const Icon(
                                                Icons.music_note,
                                                color: AppColors.cyan,
                                                size: 20,
                                              ),
                                      ),
                                      const SizedBox(width: 12),
                                      
                                      // Song Info
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              song.title,
                                              style: TextStyle(
                                                color: isCurrentSong ? AppColors.cyan : Colors.white,
                                                fontSize: 16,
                                                fontWeight: isCurrentSong ? FontWeight.bold : FontWeight.normal,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      
                                      // Action Icons
                                      Row(
                                        children: [
                                          // Download button (only for premium users in cloud view)
                                          if (_isPremiumUser && _isCloudView)
                                            IconButton(
                                              onPressed: () {
                                                // TODO: Backend - Download to local cache
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('Downloading ${song.title}...'),
                                                    duration: const Duration(seconds: 1),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.download,
                                                color: AppColors.lightGray,
                                                size: 20,
                                              ),
                                            ),
                                          // Like button (heart - always cyan/filled in library)
                                          IconButton(
                                            onPressed: () {
                                              // TODO: Backend - Unlike/remove from library
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Removed ${song.title} from library'),
                                                  duration: const Duration(seconds: 1),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.favorite,
                                              color: AppColors.cyan,
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
