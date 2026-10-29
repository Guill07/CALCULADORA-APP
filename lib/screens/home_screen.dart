import 'package:flutter/material.dart';
import '../widgets/calc_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _display = '0';

  final List<List<String>> _buttonRows = [
    ['CE', 'C', '÷', '×'],
    ['7', '8', '9', '-'],
    ['4', '5', '6', '+'],
    ['1', '2', '3', '='],
    ['0', '.'],
  ];

  void _onButtonPressed(String value) {
    // logic coming soon
  }

  Color _getButtonColor(String label) {
    if (label == 'CE' || label == 'C') return const Color(0xFFE53935);
    if (label == '=') return const Color(0xFF43A047);
    if (['+', '-', '×', '÷'].contains(label)) return const Color(0xFFFF9800);
    return const Color(0xFF3A3A3C);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: const Color(0xFF1C1C1E),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(24),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _display,
                    style: const TextStyle(
                      fontSize: 72,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),
            for (final row in _buttonRows)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    for (final label in row)
                      Expanded(
                        flex: row.length == 2 ? 2 : 1,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: CalcButton(
                            label: label,
                            backgroundColor: _getButtonColor(label),
                            onPressed: () => _onButtonPressed(label),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}