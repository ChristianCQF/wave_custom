import 'package:flutter/material.dart';
import 'package:wave_custom/wave_custom.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LottieScreen(),
    );
  }
}

class LottieScreen extends StatefulWidget {
  const LottieScreen({super.key});

  @override
  State<LottieScreen> createState() => _LottieScreenState();
}

class _LottieScreenState extends State<LottieScreen> {
  String _currentState = 'loading';

  bool get _isLoading => _currentState == 'loading';
  bool get _isError => _currentState == 'error';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) setState(() => _currentState = 'success');
    });
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            WaveCustom(
              size: widthScreen * 0.35,
              isLoading: _isLoading,
              isError: _isError,
              shapeMode: ShapeMode.circle(),
              circleColor: const Color(0xFF2A9D8F),
              lineColor: Colors.white,
              shadowColor: const Color(0xFF4FD1C5),
              outerCircleColor: const Color(0xFF4FD1C5).withValues(alpha: 0.3),
              strokeWidth: 12.0,
              checkStrokeWidth: 20.0,
              errorStrokeWidth: 20.0,
              errorColor: Colors.white,
              waveCount: 2,
              waveExpansion: 0.25,
              onAnimationStart: () => debugPrint('Animación de carga iniciada'),
              onAnimationEnd: () =>
                  debugPrint('Animación de finalización completada'),
            ),
            SizedBox(height: widthScreen * 0.15),
            WaveCustom(
              size: widthScreen * 0.35,
              isLoading: _isLoading,
              isError: _isError,
              shapeMode: ShapeMode.heart(zigzagOffset: Offset(0, 40)),
              circleColor: Colors.red,
              lineColor: Colors.white,
              shadowColor: Colors.red.shade900,
              outerCircleColor: Colors.red.withValues(alpha: 0.3),
              strokeWidth: 16.0,
              checkStrokeWidth: 20.0,
              errorStrokeWidth: 20.0,
              errorColor: Colors.white,
              waveCount: 2,
              waveExpansion: 0.25,
              onAnimationStart: () => debugPrint('Animación de carga iniciada'),
              onAnimationEnd: () =>
                  debugPrint('Animación de finalización completada'),
            ),
            SizedBox(height: widthScreen * 0.15),
            WaveCustom(
              size: widthScreen * 0.35,
              isLoading: _isLoading,
              isError: _isError,
              shapeMode: ShapeMode.shield(zigzagOffset: Offset(0, 50)),
              circleColor: const Color(0xFFE31B3D),
              lineColor: Colors.white,
              shadowColor: const Color(0xFFB01230),
              outerCircleColor: const Color(0xFFE31B3D).withValues(alpha: 0.3),
              strokeWidth: 16.0,
              checkStrokeWidth: 20.0,
              errorStrokeWidth: 20.0,
              waveCount: 2,
              waveExpansion: 0.25,
              errorColor: Colors.white,
              onAnimationStart: () => debugPrint('Animación de carga iniciada'),
              onAnimationEnd: () =>
                  debugPrint('Animación de finalización completada'),
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _StateButton(
                  label: 'Cargar',
                  value: 'loading',
                  currentState: _currentState,
                  onStateChanged: (val) => setState(() => _currentState = val),
                ),
                const SizedBox(width: 16),
                _StateButton(
                  label: 'Éxito',
                  value: 'success',
                  currentState: _currentState,
                  onStateChanged: (val) => setState(() => _currentState = val),
                ),
                const SizedBox(width: 16),
                _StateButton(
                  label: 'Error',
                  value: 'error',
                  currentState: _currentState,
                  onStateChanged: (val) => setState(() => _currentState = val),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StateButton extends StatelessWidget {
  final String label;
  final String value;
  final String currentState;
  final void Function(String) onStateChanged;

  const _StateButton({
    required this.label,
    required this.value,
    required this.currentState,
    required this.onStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = currentState == value;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.blue : Colors.grey.shade300,
        foregroundColor: isActive ? Colors.white : Colors.black87,
      ),
      onPressed: () => onStateChanged(value),
      child: Text(label),
    );
  }
}
