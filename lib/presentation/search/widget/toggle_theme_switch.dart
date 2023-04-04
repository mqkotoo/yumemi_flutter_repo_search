import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ToggleThemeSwitch extends StatelessWidget {
  const ToggleThemeSwitch(
      {required this.value, required this.onToggle, Key? key})
      : super(key: key);

  final bool value;
  final void Function(bool) onToggle;

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      height: 30,
      width: 60,
      value: value,
      onToggle: onToggle,
      padding: 0,
      toggleSize: 30,
      activeToggleColor: const Color(0xFF0D3B74),
      inactiveToggleColor: const Color(0xFFFFAB40),
      activeSwitchBorder: Border.all(
        color: const Color(0x42000000),
        width: 1,
      ),
      inactiveSwitchBorder: Border.all(
        color: const Color(0x42000000),
        width: 1,
      ),
      activeColor: const Color(0xFF365377),
      inactiveColor: const Color(0xFFFFE892),
      activeIcon: const Icon(
        Icons.nightlight_round,
        color: Colors.orangeAccent,
      ),
      inactiveIcon: const Icon(
        Icons.wb_sunny,
        color: Colors.white,
      ),
    );
  }
}
