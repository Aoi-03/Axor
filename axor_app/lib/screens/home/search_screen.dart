import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/colors.dart';
import '../../providers/music_provider.dart';
import '../../services/audio_player_service.dart';
import '../../models/song.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final int _maxHistoryItems = 5;
  List<String> _searchHistory = [];
  List<Song> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchHistory = prefs.getStringList('search_history') ?? [];
    });
  }

  Future<void> _saveSearchHistory(String query) async {
    if (query.trim().isEmpty) return;
    
    final prefs = await SharedPreferences.getInstance();
    _searchHistory.remove(query); // Remove if exists
    _searchHistory.insert(0, query); // Add to front
    if (_searchHistory.length > _maxHistoryItems) {
      _searchHistory = _searchHistory.sublist(0, _maxHistoryItems);
    }
    await prefs.setStringList('search_history', _searchHistory);
    setState(() {});
  }

  Future<void> _clearSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('search_history');
    setState(() {
      _searchHistory = [];
    });
  }

  void _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    await _saveSearchHistory(query);

    final musicProvider = Provider.of<MusicProvider>(context, listen: false);
    await musicProvider.searchSongs(query);

    setState(() {
      _searchResults = musicProvider.searchResults;
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'SEARCH',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.cyan,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),
              
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: AppColors.cyan.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search songs in your library',
                    hintStyle: TextStyle(
                      color: AppColors.lightGray.withValues(alpha: 0.7),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.lightGray,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: AppColors.lightGray),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchResults = [];
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                    _performSearch(value);
                  },
                  onSubmitted: _performSearch,
                ),
              ),
              const SizedBox(height: 8),
              
              // Hint Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Search by song name, artist, or album',
                  style: TextStyle(
                    color: AppColors.lightGray.withValues(alpha: 0.6),
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // History or Results Section
              if (_searchResults.isEmpty && !_isSearching) ...[
                // History Header
                Row(
                  children: [
                    const Icon(
                      Icons.history,
                      color: AppColors.cyan,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Recent Searches',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.cyan,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    if (_searchHistory.isNotEmpty)
                      TextButton(
                        onPressed: _clearSearchHistory,
                        child: const Text(
                          'Clear',
                          style: TextStyle(
                            color: AppColors.lightGray,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // History List
                Expanded(
                  child: _searchHistory.isEmpty
                      ? Center(
                          child: Text(
                            'No recent searches',
                            style: TextStyle(
                              color: AppColors.lightGray.withValues(alpha: 0.6),
                              fontSize: 14,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _searchHistory.length,
                          itemBuilder: (context, index) {
                            final query = _searchHistory[index];
                            return ListTile(
                              leading: const Icon(
                                Icons.history,
                                color: AppColors.cyan,
                                size: 20,
                              ),
                              title: Text(
                                query,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: AppColors.lightGray,
                                  size: 18,
                                ),
                                onPressed: () async {
                                  _searchHistory.removeAt(index);
                                  final prefs = await SharedPreferences.getInstance();
                                  await prefs.setStringList('search_history', _searchHistory);
                                  setState(() {});
                                },
                              ),
                              onTap: () {
                                _searchController.text = query;
                                _performSearch(query);
                              },
                            );
                          },
                        ),
                ),
              ] else if (_isSearching) ...[
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.cyan),
                  ),
                ),
              ] else ...[
                // Search Results
                Row(
                  children: [
                    const Icon(
                      Icons.music_note,
                      color: AppColors.cyan,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Found ${_searchResults.length} songs',
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.cyan,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                Expanded(
                  child: Consumer<AudioPlayerService>(
                    builder: (context, audioPlayer, child) {
                      return ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final song = _searchResults[index];
                          final isCurrentSong = audioPlayer.currentSong?.id == song.id;
                          
                          return GestureDetector(
                            onTap: () {
                              audioPlayer.playSong(song, playlist: _searchResults, index: index);
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
                                              errorBuilder: (_, __, ___) {
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
                                    child: Text(
                                      song.title,
                                      style: TextStyle(
                                        color: isCurrentSong ? AppColors.cyan : Colors.white,
                                        fontSize: 16,
                                        fontWeight: isCurrentSong ? FontWeight.bold : FontWeight.normal,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  
                                  // Like button - Always filled (all songs in cloud)
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: AppColors.cyan,
                                      size: 20,
                                    ),
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
