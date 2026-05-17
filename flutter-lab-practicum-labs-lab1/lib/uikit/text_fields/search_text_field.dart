import 'package:flutter/material.dart';

/// Виджет текстового поля поиска.
/// 
/// Выполнен по дизайну из Фигмы: 
/// Светлый фон (0xFFF2F2F2), скругленные углы (16px), 
/// иконка лупы слева и зеленая иконка настройки фильтров справа.
class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: TextFormField(
        controller: _controller,
        cursorColor: const Color(0xFF252849),
        style: const TextStyle(
          color: Color(0xFF252849),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        onChanged: (text) {
          // Согласно заданию: вывод введенного текста в консоль
          debugPrint('Введенный текст для поиска: $text');
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF2F2F2),
          hintText: 'Найти место',
          hintStyle: const TextStyle(
            color: Color(0xFF7C7E92), // Соответствует типичному цвету подсказки для данного фона
            fontSize: 16,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 12.0, right: 8.0),
            child: Icon(
              Icons.search,
              color: Color(0xFF7C7E92),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 44,
            minHeight: 44,
          ),
          suffixIcon: _controller.text.isNotEmpty 
              ? IconButton(
                  icon: const Icon(Icons.cancel),
                  color: const Color(0xFF252849),
                  splashRadius: 24,
                  onPressed: () {
                    _controller.clear();
                    debugPrint('Очищено поле поиска');
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.tune),
                  color: const Color(0xFF4CAF50),
                  onPressed: () {
                    debugPrint('Нажата кнопка Фильтры');
                  },
                  splashRadius: 24,
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
