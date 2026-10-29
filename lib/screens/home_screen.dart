import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../widgets/calc_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _display = '0';
  double? _firstNumber;
  String? _operator;
  bool _shouldResetDisplay = false;

  final List<List<String>> _buttonRows = [
    ['CE', 'C', '÷', '×'],
    ['7', '8', '9', '-'],
    ['4', '5', '6', '+'],
    ['1', '2', '3', '='],
    ['0', '.'],
  ];

  void _onButtonPressed(String value) {
    setState(() {
      if (['+', '-', '×', '÷'].contains(value)) {
        _setOperator(value);
      } else if (value == '=') {
        _calculate();
      } else if (value == '.') {
        _addDecimal();
      } else if (value == 'CE') {
        _clearAll();
      } else if (value == 'C') {
        _deleteLast();
      } else {
        _addDigit(value);
      }
    });
  }

  void _addDigit(String digit) {
    if (_shouldResetDisplay || _display == '0' || _display == 'Error') {
      _display = digit;
      _shouldResetDisplay = false;
    } else {
      _display += digit;
    }
  }

  void _addDecimal() {
    if (_shouldResetDisplay || _display == 'Error') {
      _display = '0.';
      _shouldResetDisplay = false;
    } else if (!_display.contains('.')) {
      _display += '.';
    }
  }

  void _setOperator(String operator) {
    if (_display == 'Error') return;
    if (_operator != null && !_shouldResetDisplay) {
      _calculate();
      if (_display == 'Error') return;
    }
    _firstNumber = double.tryParse(_display);
    _operator = operator;
    _shouldResetDisplay = true;
  }

  void _calculate() {
    if (_operator == null || _firstNumber == null) return;

    final double secondNumber = double.parse(_display);
    double result = 0;

    switch (_operator) {
      case '+':
        result = _firstNumber! + secondNumber;
        break;
      case '-':
        result = _firstNumber! - secondNumber;
        break;
      case '×':
        result = _firstNumber! * secondNumber;
        break;
      case '÷':
        if (secondNumber == 0) {
          _display = 'Error';
          _firstNumber = null;
          _operator = null;
          _shouldResetDisplay = true;
          return;
        }
        result = _firstNumber! / secondNumber;
        break;
    }

    _display = _formatResult(result);
    _firstNumber = null;
    _operator = null;
    _shouldResetDisplay = true;
  }

  // CE: clears everything
  void _clearAll() {
    _display = '0';
    _firstNumber = null;
    _operator = null;
    _shouldResetDisplay = false;
  }

  // C: deletes one character
  void _deleteLast() {
    if (_shouldResetDisplay) return;
    if (_display.length > 1) {
      _display = _display.substring(0, _display.length - 1);
    } else {
      _display = '0';
    }
  }

  String _formatResult(double number) {
    final double rounded = double.parse(number.toStringAsFixed(8));
    if (rounded == rounded.truncateToDouble()) {
      return rounded.toInt().toString();
    }
    return rounded.toString();
  }

  Color _getButtonColor(String label) {
    if (label == 'CE' || label == 'C') return AppColors.clearButton;
    if (label == '=') return AppColors.deepGold;
    if (['+', '-', '×', '÷'].contains(label)) return AppColors.darkGold;
    return AppColors.numberButton;
  }

  Color _getTextColor(String label) {
    final bool isNumber = RegExp(r'^[0-9.]$').hasMatch(label);
    return isNumber ? AppColors.textDark : AppColors.textLight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.darkGold,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.info),
          ),
        ],
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
                      color: AppColors.textDark,
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
                            textColor: _getTextColor(label),
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