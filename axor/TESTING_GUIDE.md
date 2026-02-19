# AXOR Testing Guide

Complete guide for testing the AXOR backend and Flutter app.

## 🎯 Testing Overview

### What We're Testing
1. ✅ Backend API endpoints
2. ✅ AI Flow Mode (BPM-based matching)
3. ✅ AI Intent Mode (mood-based matching)
4. ✅ Smart Modes (Gym, Study, Drive)
5. ✅ User authentication
6. ✅ Song management
7. ✅ Playlist features

## 🚀 Step 1: Start Backend

### Windows
Double-click `START_BACKEND.bat`

### Manual
```bash
cd axor_app_backend
npm install
npm start
```

### Verify
Open browser: `http://localhost:3000/health`

Should see:
```json
{
  "status": "ok",
  "message": "AXOR Backend is running",
  "timestamp": "2026-02-06T..."
}
```

## 🧪 Step 2: Test API Endpoints

### 2.1 Authentication

**Login (Test Account):**
```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"test@example.com\",\"password\":\"test123\"}"
```

**Expected Response:**
```json
{
  "success": true,
  "user": {
    "id": "user_test1",
    "email": "test@example.com",
    "username": "TestUser",
    "plan": "free",
    "storageUsed": 0,
    "storageLimit": 1
  }
}
```

**Login (Admin Account):**
```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"a67154512@gmail.com\",\"password\":\"admin123\"}"
```

**Expected Response:**
```json
{
  "success": true,
  "user": {
    "id": "user_admin",
    "email": "a67154512@gmail.com",
    "username": "Admin",
    "plan": "premium",
    "storageUsed": 0,
    "storageLimit": 100
  }
}
```

### 2.2 Get All Songs

```bash
curl http://localhost:3000/api/songs
```

**Expected Response:**
```json
{
  "success": true,
  "songs": [
    {
      "id": "song_001",
      "title": "Thunder Strike",
      "artist": "Electric Pulse",
      "bpm": 140,
      "energy": 0.9,
      "mood": "energetic"
    },
    ...
  ]
}
```

### 2.3 Search Songs

```bash
curl -X POST http://localhost:3000/api/songs/search \
  -H "Content-Type: application/json" \
  -d "{\"query\":\"Thunder\"}"
```

**Expected Response:**
```json
{
  "success": true,
  "results": [
    {
      "id": "song_001",
      "title": "Thunder Strike",
      "artist": "Electric Pulse"
    }
  ]
}
```

## 🤖 Step 3: Test AI Features

### 3.1 Flow Mode (BPM-Based)

**Test with "Thunder Strike" (BPM: 140, Energy: 0.9):**
```bash
curl -X POST http://localhost:3000/api/ai/similar \
  -H "Content-Type: application/json" \
  -d "{\"songId\":\"song_001\",\"mode\":\"flow\"}"
```

**Expected Behavior:**
- Returns songs with similar BPM (130-150)
- Prioritizes rhythm matching
- Good for: Gym Beast (BPM 150), Power Surge (BPM 145)

**Expected Response:**
```json
{
  "success": true,
  "songs": [
    {
      "id": "song_004",
      "title": "Gym Beast",
      "bpm": 150,
      "energy": 0.95,
      "similarity": 95.5
    },
    {
      "id": "song_010",
      "title": "Power Surge",
      "bpm": 145,
      "energy": 0.92,
      "similarity": 94.0
    }
  ]
}
```

### 3.2 Intent Mode (Mood-Based)

**Test with "Thunder Strike" (BPM: 140, Energy: 0.9):**
```bash
curl -X POST http://localhost:3000/api/ai/similar \
  -H "Content-Type: application/json" \
  -d "{\"songId\":\"song_001\",\"mode\":\"intent\"}"
```

**Expected Behavior:**
- Returns songs with similar energy (0.8-1.0)
- Prioritizes mood matching
- Good for: Gym Beast (Energy 0.95), Adrenaline Rush (Energy 1.0)

**Expected Response:**
```json
{
  "success": true,
  "songs": [
    {
      "id": "song_008",
      "title": "Adrenaline Rush",
      "bpm": 160,
      "energy": 1.0,
      "similarity": 96.0
    },
    {
      "id": "song_004",
      "title": "Gym Beast",
      "bpm": 150,
      "energy": 0.95,
      "similarity": 95.0
    }
  ]
}
```

### 3.3 Compare Flow vs Intent

**Flow Mode:**
- Matches BPM first
- Keeps rhythm consistent
- Perfect for: Dancing, running, driving

**Intent Mode:**
- Matches energy/mood first
- Adapts to emotional state
- Perfect for: Studying, relaxing, focusing

## 🏋️ Step 4: Test Smart Modes

### 4.1 Gym Mode

```bash
curl -X POST http://localhost:3000/api/ai/smart-mode \
  -H "Content-Type: application/json" \
  -d "{\"mode\":\"gym\",\"userId\":\"user_test1\"}"
```

**Expected Response:**
```json
{
  "success": true,
  "songs": [
    {
      "id": "song_001",
      "title": "Thunder Strike",
      "bpm": 140,
      "energy": 0.9
    },
    {
      "id": "song_004",
      "title": "Gym Beast",
      "bpm": 150,
      "energy": 0.95
    },
    {
      "id": "song_008",
      "title": "Adrenaline Rush",
      "bpm": 160,
      "energy": 1.0
    },
    {
      "id": "song_010",
      "title": "Power Surge",
      "bpm": 145,
      "energy": 0.92
    }
  ]
}
```

**Criteria:**
- Energy >= 0.7
- BPM >= 120
- High-intensity tracks

### 4.2 Study Mode

```bash
curl -X POST http://localhost:3000/api/ai/smart-mode \
  -H "Content-Type: application/json" \
  -d "{\"mode\":\"study\",\"userId\":\"user_test1\"}"
```

**Expected Response:**
```json
{
  "success": true,
  "songs": [
    {
      "id": "song_003",
      "title": "Focus Flow",
      "bpm": 80,
      "energy": 0.3
    },
    {
      "id": "song_005",
      "title": "Lost in Thought",
      "bpm": 70,
      "energy": 0.2
    },
    {
      "id": "song_007",
      "title": "Deep Concentration",
      "bpm": 60,
      "energy": 0.25
    },
    {
      "id": "song_009",
      "title": "Sunset Vibes",
      "bpm": 90,
      "energy": 0.4
    }
  ]
}
```

**Criteria:**
- Energy <= 0.5
- BPM <= 100
- Calm, focus-friendly tracks

### 4.3 Drive Mode

```bash
curl -X POST http://localhost:3000/api/ai/smart-mode \
  -H "Content-Type: application/json" \
  -d "{\"mode\":\"drive\",\"userId\":\"user_test1\"}"
```

**Expected Response:**
```json
{
  "success": true,
  "songs": [
    {
      "id": "song_002",
      "title": "Midnight Drive",
      "bpm": 110,
      "energy": 0.6
    },
    {
      "id": "song_006",
      "title": "Road Trip Anthem",
      "bpm": 115,
      "energy": 0.7
    }
  ]
}
```

**Criteria:**
- Energy >= 0.5 AND <= 0.8
- Medium-paced tracks
- Road trip vibes

## 📱 Step 5: Flutter App Integration

### 5.1 Configure Base URL

**For AVD (Android Emulator):**
```dart
class Config {
  static const String baseUrl = 'http://10.0.2.2:3000';
}
```

**For Real Device:**
1. Find your PC's IP:
   - Windows: `ipconfig` → Look for IPv4 Address
   - Mac: `ifconfig` → Look for inet
   - Example: `192.168.1.100`

2. Update config:
```dart
class Config {
  static const String baseUrl = 'http://192.168.1.100:3000';
}
```

### 5.2 Test API Service

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000';
  
  // Test connection
  Future<bool> testConnection() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/health'));
      return response.statusCode == 200;
    } catch (e) {
      print('Connection error: $e');
      return false;
    }
  }
  
  // Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    return json.decode(response.body);
  }
  
  // Get songs
  Future<List<dynamic>> getSongs() async {
    final response = await http.get(Uri.parse('$baseUrl/api/songs'));
    final data = json.decode(response.body);
    return data['songs'];
  }
  
  // AI Similar (Flow Mode)
  Future<List<dynamic>> getFlowModeSongs(String songId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/ai/similar'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'songId': songId, 'mode': 'flow'}),
    );
    final data = json.decode(response.body);
    return data['songs'];
  }
  
  // AI Similar (Intent Mode)
  Future<List<dynamic>> getIntentModeSongs(String songId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/ai/similar'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'songId': songId, 'mode': 'intent'}),
    );
    final data = json.decode(response.body);
    return data['songs'];
  }
  
  // Smart Mode
  Future<List<dynamic>> getSmartModeSongs(String mode) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/ai/smart-mode'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'mode': mode, 'userId': 'user_test1'}),
    );
    final data = json.decode(response.body);
    return data['songs'];
  }
}
```

### 5.3 Test in Flutter

```dart
void testBackend() async {
  final api = ApiService();
  
  // Test connection
  print('Testing connection...');
  bool connected = await api.testConnection();
  print('Connected: $connected');
  
  // Test login
  print('\nTesting login...');
  var result = await api.login('test@example.com', 'test123');
  print('Login result: $result');
  
  // Test get songs
  print('\nTesting get songs...');
  var songs = await api.getSongs();
  print('Songs count: ${songs.length}');
  
  // Test Flow Mode
  print('\nTesting Flow Mode...');
  var flowSongs = await api.getFlowModeSongs('song_001');
  print('Flow Mode songs: ${flowSongs.length}');
  
  // Test Intent Mode
  print('\nTesting Intent Mode...');
  var intentSongs = await api.getIntentModeSongs('song_001');
  print('Intent Mode songs: ${intentSongs.length}');
  
  // Test Gym Mode
  print('\nTesting Gym Mode...');
  var gymSongs = await api.getSmartModeSongs('gym');
  print('Gym Mode songs: ${gymSongs.length}');
}
```

## ✅ Testing Checklist

### Backend
- [ ] Server starts without errors
- [ ] Health check returns OK
- [ ] Login with test account works
- [ ] Login with admin account works
- [ ] Get all songs returns 10 songs
- [ ] Search songs works
- [ ] Flow Mode returns similar BPM songs
- [ ] Intent Mode returns similar energy songs
- [ ] Gym Mode returns high-energy songs
- [ ] Study Mode returns low-energy songs
- [ ] Drive Mode returns medium-energy songs

### Flutter App
- [ ] App connects to backend
- [ ] Login screen works
- [ ] Home screen shows songs
- [ ] Search screen works
- [ ] AI button toggles Flow/Intent mode
- [ ] Gym Mode shows correct songs
- [ ] Study Mode shows correct songs
- [ ] Drive Mode shows correct songs
- [ ] Like button works
- [ ] Playlist creation works

## 🐛 Troubleshooting

### Backend Won't Start
```bash
# Check if port 3000 is in use
netstat -ano | findstr :3000

# Kill process if needed
taskkill /PID <PID> /F

# Restart backend
npm start
```

### Flutter Can't Connect
1. Check backend is running: `http://localhost:3000/health`
2. Check firewall allows port 3000
3. For real device, use PC's IP address
4. Ensure device and PC are on same network

### AI Not Working
1. Check songs.json has BPM and energy values
2. Verify song IDs match
3. Check API response in browser/Postman
4. Look at server logs for errors

## 📊 Expected Results

### Flow Mode Test
**Input:** Thunder Strike (BPM 140, Energy 0.9)
**Output:** Songs with BPM 130-150 (Gym Beast, Power Surge, Adrenaline Rush)

### Intent Mode Test
**Input:** Thunder Strike (BPM 140, Energy 0.9)
**Output:** Songs with Energy 0.8-1.0 (Adrenaline Rush, Gym Beast, Power Surge)

### Smart Modes Test
- **Gym:** 4 songs (Thunder Strike, Gym Beast, Adrenaline Rush, Power Surge)
- **Study:** 4 songs (Focus Flow, Lost in Thought, Deep Concentration, Sunset Vibes)
- **Drive:** 2 songs (Midnight Drive, Road Trip Anthem)

## 🎯 Success Criteria

✅ **Backend is working** if:
- Server starts without errors
- All API endpoints return expected data
- AI modes return correct songs
- Smart Modes filter correctly

✅ **Flutter integration is working** if:
- App connects to backend
- Login works
- Songs display correctly
- AI button switches modes
- Smart Modes show filtered songs

## 🚀 Next Steps

After successful testing:
1. Add real audio files
2. Test audio playback
3. Implement premium features
4. Add Spotify link download
5. Deploy to production

**Happy Testing!** 🎵