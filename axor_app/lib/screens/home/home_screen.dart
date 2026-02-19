import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../widgets/vibe_card.dart';
import '../../widgets/shelf_card.dart';
import '../../utils/mode_manager.dart';
import '../../utils/page_transitions.dart';
import '../../services/api_service.dart';
import '../../services/playlist_storage_service.dart';
import '../../models/playlist.dart';
import '../playlist/playlist_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This should come from user data/state management
  final String userName = "Alex"; // This will be dynamic from user signup
  
  List<Map<String, dynamic>> vibes = [];
  List<Playlist> userPlaylists = [];
  bool isLoadingVibes = true;
  bool isLoadingPlaylists = true;

  @override
  void initState() {
    super.initState();
    _loadVibes();
    _loadPlaylists();
  }

  Future<void> _loadVibes() async {
    setState(() => isLoadingVibes = true);
    final fetchedVibes = await ApiService.getVibes();
    setState(() {
      vibes = fetchedVibes;
      isLoadingVibes = false;
    });
  }

  Future<void> _loadPlaylists() async {
    setState(() => isLoadingPlaylists = true);
    final playlists = await PlaylistStorageService.loadPlaylists();
    setState(() {
      userPlaylists = playlists;
      isLoadingPlaylists = false;
    });
  }

  Future<void> _createPlaylist() async {
    final nameController = TextEditingController();
    final descController = TextEditingController();
    
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkTeal,
        title: const Text('Create Playlist', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Playlist Name',
                labelStyle: TextStyle(color: AppColors.lightGray),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.cyan),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.cyan),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                labelStyle: TextStyle(color: AppColors.lightGray),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.cyan),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.cyan),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(color: AppColors.lightGray)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Create', style: TextStyle(color: AppColors.cyan)),
          ),
        ],
      ),
    );

    if (result == true && nameController.text.isNotEmpty) {
      final newPlaylist = Playlist(
        id: 'playlist_${DateTime.now().millisecondsSinceEpoch}',
        userId: 'user_test1',
        name: nameController.text,
        description: descController.text,
        songIds: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await PlaylistStorageService.addPlaylist(newPlaylist);
      _loadPlaylists();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hey There,',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              userName,
                              style: const TextStyle(
                                fontSize: 24,
                                color: AppColors.cyan,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.green.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: AppColors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Playing on Discord',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.darkTeal,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.phone_android,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    
                    // Your Vibe Section
                    Row(
                      children: [
                        const Text(
                          '> Your Vibe',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.cyan,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '- AI suggestion',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.lightGray,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Horizontal scrolling vibes
                    SizedBox(
                      height: 120,
                      child: isLoadingVibes
                          ? const Center(child: CircularProgressIndicator(color: AppColors.cyan))
                          : vibes.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No vibes available',
                                    style: TextStyle(color: AppColors.lightGray),
                                  ),
                                )
                              : ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: vibes.length,
                                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                                  itemBuilder: (context, index) {
                                    final vibe = vibes[index];
                                    return SizedBox(
                                      width: 160,
                                      child: VibeCard(
                                        title: vibe['title'] ?? 'Untitled',
                                        imageUrl: 'assets/images/placeholder.txt',
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            slideUpRoute(
                                              PlaylistDetailScreen(
                                                title: vibe['title'] ?? 'Untitled',
                                                subtitle: vibe['subtitle'] ?? '',
                                                imageUrl: 'assets/images/placeholder.txt',
                                                isVibe: true,
                                                vibeData: vibe,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Smart Modes Section
                    const Text(
                      '> Smart Modes',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.cyan,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Horizontal scrolling smart modes
                    SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: 160,
                            child: VibeCard(
                              title: 'GYM MODE',
                              imageUrl: 'assets/images/gym_mode.jpg',
                              color: AppColors.red,
                              onTap: () {
                                // Set gym mode and navigate to first tab with animation
                                modeManager.setMode(0);
                                Navigator.of(context).popUntil((route) => route.isFirst);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 160,
                            child: VibeCard(
                              title: 'STUDY MODE',
                              imageUrl: 'assets/images/study_mode.jpg',
                              color: AppColors.cyan,
                              onTap: () {
                                // Set study mode and navigate to first tab
                                modeManager.setMode(1);
                                // Pop back to main screen if needed
                                Navigator.of(context).popUntil((route) => route.isFirst);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 160,
                            child: VibeCard(
                              title: 'DRIVE MODE',
                              imageUrl: 'assets/images/drive_mode.jpg',
                              color: AppColors.green,
                              onTap: () {
                                // Set drive mode and navigate to first tab
                                modeManager.setMode(2);
                                // Pop back to main screen if needed
                                Navigator.of(context).popUntil((route) => route.isFirst);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // The Shelf Section
                    Row(
                      children: [
                        const Text(
                          '> The Shelf',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.cyan,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: _createPlaylist,
                          icon: const Icon(
                            Icons.add,
                            color: AppColors.cyan,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // User playlists
                    if (isLoadingPlaylists)
                      const Center(child: CircularProgressIndicator(color: AppColors.cyan))
                    else if (userPlaylists.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text(
                            'No playlists yet. Tap + to create one!',
                            style: TextStyle(color: AppColors.lightGray),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    else
                      ...userPlaylists.map((playlist) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ShelfCard(
                          title: playlist.name,
                          subtitle: playlist.description.isEmpty 
                              ? '${playlist.songCount} songs' 
                              : playlist.description,
                          imageUrl: playlist.imageUrl ?? 'assets/images/placeholder.txt',
                          onTap: () {
                            Navigator.push(
                              context,
                              slideUpRoute(
                                PlaylistDetailScreen(
                                  title: playlist.name,
                                  subtitle: playlist.description,
                                  imageUrl: playlist.imageUrl ?? 'assets/images/placeholder.txt',
                                  isVibe: false,
                                  playlistId: playlist.id,
                                ),
                              ),
                            );
                          },
                        ),
                      )),
                    const SizedBox(height: 100), // Space for bottom player and nav bar
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
