import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../utils/mode_manager.dart';
import '../services/audio_player_service.dart';
import '../screens/player/full_player_screen.dart';

class MusicPlayerBottom extends StatefulWidget {
  final bool isOnModesTab;
  
  const MusicPlayerBottom({
    super.key,
    this.isOnModesTab = false,
  });

  @override
  State<MusicPlayerBottom> createState() => _MusicPlayerBottomState();
}

class _MusicPlayerBottomState extends State<MusicPlayerBottom> with SingleTickerProviderStateMixin {
  late AnimationController _scrollController;

  @override
  void initState() {
    super.initState();
    modeManager.addListener(_onModeChanged);
    
    _scrollController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    modeManager.removeListener(_onModeChanged);
    _scrollController.dispose();
    super.dispose();
  }

  void _onModeChanged() {
    if (mounted) setState(() {});
  }

  IconData _getShuffleRepeatIcon(int state) {
    switch (state) {
      case 0: return Icons.repeat;
      case 1: return Icons.repeat_one;
      case 2: return Icons.shuffle;
      case 3: return Icons.auto_awesome;
      default: return Icons.repeat;
    }
  }

  Color _getShuffleRepeatColor(int state) {
    if (state == 0) return AppColors.lightGray;
    return widget.isOnModesTab ? modeManager.getModeColor() : AppColors.cyan;
  }

  @override
  Widget build(BuildContext context) {
    final modeColor = widget.isOnModesTab ? modeManager.getModeColor() : AppColors.cyan;
    
    return Consumer<AudioPlayerService>(
      builder: (context, audioPlayer, child) {
        final currentSong = audioPlayer.currentSong;
        final isPlaying = audioPlayer.isPlaying;
        
        return GestureDetector(
          onTap: () {
            if (currentSong != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FullPlayerScreen()),
              );
            }
          },
          child: Container(
            height: 70,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.darkTeal,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: modeColor.withValues(alpha: 0.3), width: 1),
            ),
            child: Row(
              children: [
                // Album Art
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: currentSong != null && currentSong.hasEmbeddedCover
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            currentSong.coverUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.music_note,
                              color: AppColors.darkGray,
                              size: 24,
                            ),
                          ),
                        )
                      : const Icon(Icons.music_note, color: AppColors.darkGray, size: 24),
                ),
                const SizedBox(width: 8),
                
                // Song Title - Simple with ellipsis (no scrolling to avoid overflow)
                Flexible(
                  child: Text(
                    currentSong?.title ?? 'No song playing',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                
                const SizedBox(width: 4),
                
                // Controls - Flexible layout
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Previous
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: IconButton(
                          onPressed: currentSong != null ? () => audioPlayer.playPrevious() : null,
                          icon: Icon(
                            Icons.skip_previous,
                            color: currentSong != null ? Colors.white : AppColors.darkGray,
                            size: 22,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      
                      // Play/Pause
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: currentSong != null ? Colors.white : AppColors.darkGray,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: currentSong != null ? () => audioPlayer.togglePlayPause() : null,
                          icon: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.black,
                            size: 22,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      
                      // Next
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: IconButton(
                          onPressed: currentSong != null ? () => audioPlayer.playNext() : null,
                          icon: Icon(
                            Icons.skip_next,
                            color: currentSong != null ? Colors.white : AppColors.darkGray,
                            size: 22,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      
                      // Shuffle/Repeat/AI
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: IconButton(
                          onPressed: () {
                            final newState = (audioPlayer.shuffleRepeatState + 1) % 4;
                            audioPlayer.setShuffleRepeatState(newState);
                          },
                          icon: Icon(
                            _getShuffleRepeatIcon(audioPlayer.shuffleRepeatState),
                            color: _getShuffleRepeatColor(audioPlayer.shuffleRepeatState),
                            size: 20,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      
                      // Like/Heart - Always filled (cyan) since all songs are in cloud
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: IconButton(
                          onPressed: currentSong != null ? () {
                            // TODO: Backend - Remove from cloud
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Song removed from cloud'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } : null,
                          icon: const Icon(
                            Icons.favorite, // Always filled
                            color: AppColors.cyan,
                            size: 20,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
