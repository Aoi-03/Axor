import 'package:flutter/material.dart';
import 'dart:async';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  int _currentExerciseIndex = 0;
  int _currentSet = 1;
  int _timeRemaining = 0;
  Timer? _timer;
  bool _isResting = false;
  bool _isWorkoutActive = false;

  final List<WorkoutExercise> _exercises = [
    WorkoutExercise(
      name: 'Push-ups',
      type: 'Freehand',
      duration: 30,
      sets: 3,
      restTime: 15,
      instructions: [
        'Start in plank position',
        'Lower body until chest nearly touches floor',
        'Push back up to starting position',
        'Keep core tight throughout movement'
      ],
    ),
    WorkoutExercise(
      name: 'Squats',
      type: 'Freehand',
      duration: 45,
      sets: 3,
      restTime: 20,
      instructions: [
        'Stand with feet shoulder-width apart',
        'Lower body as if sitting back into chair',
        'Keep knees behind toes',
        'Return to standing position'
      ],
    ),
    WorkoutExercise(
      name: 'Plank',
      type: 'Freehand',
      duration: 60,
      sets: 2,
      restTime: 30,
      instructions: [
        'Start in push-up position',
        'Hold body in straight line',
        'Keep core engaged',
        'Breathe steadily'
      ],
    ),
    WorkoutExercise(
      name: 'Jumping Jacks',
      type: 'Freehand',
      duration: 30,
      sets: 3,
      restTime: 15,
      instructions: [
        'Start with feet together, arms at sides',
        'Jump while spreading legs and raising arms',
        'Jump back to starting position',
        'Maintain steady rhythm'
      ],
    ),
  ];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _onTimerComplete();
      }
    });
  }

  void _onTimerComplete() {
    _timer?.cancel();
    
    if (_isResting) {
      // Rest complete, start next set or exercise
      setState(() {
        _isResting = false;
        if (_currentSet < _exercises[_currentExerciseIndex].sets) {
          _currentSet++;
          _timeRemaining = _exercises[_currentExerciseIndex].duration;
        } else {
          // Move to next exercise
          if (_currentExerciseIndex < _exercises.length - 1) {
            _currentExerciseIndex++;
            _currentSet = 1;
            _timeRemaining = _exercises[_currentExerciseIndex].duration;
          } else {
            // Workout complete
            _isWorkoutActive = false;
            _showWorkoutComplete();
            return;
          }
        }
      });
      _startTimer();
      _speakInstruction('Next set: ${_exercises[_currentExerciseIndex].name}');
    } else {
      // Exercise complete, start rest
      if (_currentSet < _exercises[_currentExerciseIndex].sets) {
        setState(() {
          _isResting = true;
          _timeRemaining = _exercises[_currentExerciseIndex].restTime;
        });
        _startTimer();
        _speakInstruction('Rest time. Next set in ${_exercises[_currentExerciseIndex].restTime} seconds');
      } else {
        // All sets complete for this exercise
        if (_currentExerciseIndex < _exercises.length - 1) {
          setState(() {
            _isResting = true;
            _timeRemaining = 30; // Longer rest between exercises
          });
          _startTimer();
          _speakInstruction('Exercise complete. Next: ${_exercises[_currentExerciseIndex + 1].name}');
        } else {
          // Workout complete
          setState(() {
            _isWorkoutActive = false;
          });
          _showWorkoutComplete();
        }
      }
    }
  }

  void _speakInstruction(String text) {
    // TODO: Implement Text-to-Speech
    debugPrint('TTS: $text');
  }

  void _showWorkoutComplete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          'Workout Complete! 🎉',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Great job! You\'ve completed your workout session.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Done',
              style: TextStyle(color: Color(0xFF00FFC2)),
            ),
          ),
        ],
      ),
    );
  }

  void _startWorkout() {
    setState(() {
      _isWorkoutActive = true;
      _currentExerciseIndex = 0;
      _currentSet = 1;
      _timeRemaining = _exercises[0].duration;
      _isResting = false;
    });
    _startTimer();
    _speakInstruction('Starting workout. First exercise: ${_exercises[0].name}');
  }

  void _pauseWorkout() {
    _timer?.cancel();
    setState(() {
      _isWorkoutActive = false;
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                const Text(
                  'Workout Mode',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF00FFC2).withOpacity(0.2),
                    ),
                  ),
                  child: const Text(
                    '💪',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            if (!_isWorkoutActive) ...[
              // Workout Preview
              Expanded(
                child: Column(
                  children: [
                    // Workout Summary
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF00FFC2).withOpacity(0.2),
                            const Color(0xFF00FFC2).withOpacity(0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF00FFC2).withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Full Body Workout',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${_exercises.length} exercises • ~15 minutes',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Exercise List
                    Expanded(
                      child: ListView.builder(
                        itemCount: _exercises.length,
                        itemBuilder: (context, index) {
                          final exercise = _exercises[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1A),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF00FFC2).withOpacity(0.1),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00FFC2).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        color: Color(0xFF00FFC2),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                
                                const SizedBox(width: 16),
                                
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        exercise.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '${exercise.sets} sets • ${exercise.duration}s each',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              
              // Start Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: _startWorkout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00FFC2),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Start Workout',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ] else ...[
              // Active Workout
              Expanded(
                child: Column(
                  children: [
                    // Progress
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF00FFC2).withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Exercise ${_currentExerciseIndex + 1} of ${_exercises.length}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _exercises[_currentExerciseIndex].name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _isResting ? 'Rest Time' : 'Set $_currentSet of ${_exercises[_currentExerciseIndex].sets}',
                            style: TextStyle(
                              fontSize: 16,
                              color: _isResting ? Colors.orange : const Color(0xFF00FFC2),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Timer
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _isResting ? Colors.orange : const Color(0xFF00FFC2),
                          width: 8,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _formatTime(_timeRemaining),
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: _isResting ? Colors.orange : const Color(0xFF00FFC2),
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Instructions
                    if (!_isResting) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF00FFC2).withOpacity(0.1),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Instructions:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...(_exercises[_currentExerciseIndex].instructions.map((instruction) => 
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  '• $instruction',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                    
                    const Spacer(),
                    
                    // Control Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _pauseWorkout,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Pause'),
                        ),
                        
                        ElevatedButton(
                          onPressed: () {
                            _timer?.cancel();
                            _onTimerComplete();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00FFC2),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Skip'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class WorkoutExercise {
  final String name;
  final String type;
  final int duration; // in seconds
  final int sets;
  final int restTime; // in seconds
  final List<String> instructions;

  WorkoutExercise({
    required this.name,
    required this.type,
    required this.duration,
    required this.sets,
    required this.restTime,
    required this.instructions,
  });
}