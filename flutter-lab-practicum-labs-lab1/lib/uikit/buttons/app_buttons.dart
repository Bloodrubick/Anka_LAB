import 'package:flutter/material.dart';

/// Набор кнопок, соответствующих экрану компонентов в Figma.
class AppButtons {
  /// Кнопка "+ НОВОЕ МЕСТО" (градиентная)
  static Widget newPlace({required VoidCallback onPressed}) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFFFCDD3D), Color(0xFF4CAF50)], // Желто-зеленый градиент
        ),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 0,
        ),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'НОВОЕ МЕСТО',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
      ),
    );
  }

  /// Стандартная зеленая кнопка "ПОДРОБНЕЕ"
  static Widget normal({required String text, required VoidCallback onPressed}) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4CAF50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
      ),
    );
  }

  /// Прозрачная кнопка с зеленым текстом "ПОДРОБНЕЕ"
  static Widget tertiary({required String text, required VoidCallback onPressed}) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF4CAF50),
        ),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
      ),
    );
  }

  /// Неактивная (серая) кнопка "ПОДРОБНЕЕ"
  static Widget disabled({required String text}) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        // null в onPressed делает кнопку disabled в Material Design
        onPressed: null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: const Color(0xFFF2F2F2),
          disabledForegroundColor: const Color(0xFF7C7E92),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
      ),
    );
  }
}
