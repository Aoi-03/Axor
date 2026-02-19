import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// Automatically generates playlist cover from 2-4 song album arts
/// Like Spotify's auto-generated playlist covers
class AutoPlaylistCover extends StatelessWidget {
  final List<String> songAlbumArts; // List of album art URLs/paths
  final double size;
  final double borderRadius;

  const AutoPlaylistCover({
    super.key,
    required this.songAlbumArts,
    this.size = 160,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    // If no songs, show default icon
    if (songAlbumArts.isEmpty) {
      return _buildDefaultCover();
    }

    // If 1 song, show single album art
    if (songAlbumArts.length == 1) {
      return _buildSingleCover(songAlbumArts[0]);
    }

    // If 2-3 songs, show 2x2 grid (repeat last if needed)
    // If 4+ songs, show 2x2 grid with first 4
    return _buildGridCover();
  }

  Widget _buildDefaultCover() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.darkTeal,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(
        Icons.music_note,
        size: size * 0.4,
        color: AppColors.cyan,
      ),
    );
  }

  Widget _buildSingleCover(String imagePath) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildDefaultCover();
          },
        ),
      ),
    );
  }

  Widget _buildGridCover() {
    // Take first 4 songs, or repeat if less than 4
    List<String> gridImages = [];
    if (songAlbumArts.length >= 4) {
      gridImages = songAlbumArts.sublist(0, 4);
    } else {
      // Repeat images to fill 4 slots
      for (int i = 0; i < 4; i++) {
        gridImages.add(songAlbumArts[i % songAlbumArts.length]);
      }
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Image.asset(
              gridImages[index],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.darkTeal,
                  child: Icon(
                    Icons.music_note,
                    size: size * 0.15,
                    color: AppColors.cyan,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
