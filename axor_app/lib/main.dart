import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'providers/music_provider.dart';
import 'services/audio_player_service.dart';

void main() {
  runApp(const AxorApp());
}

class AxorApp extends StatelessWidget {
  const AxorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MusicProvider()..loadSongs()),
        ChangeNotifierProvider(create: (_) => AudioPlayerService()),
      ],
      child: MaterialApp(
        title: 'AXOR',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          scaffoldBackgroundColor: Colors.black,
          fontFamily: 'Roboto',
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
            titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
