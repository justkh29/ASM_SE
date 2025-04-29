import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final Color? backgroundColor; // Màu nền có thể thay đổi
  final Color? foregroundColor; // Màu chữ có thể thay đổi
  final VoidCallback onPressed;
  final String title;
  final double ? height;
  const BasicAppButton({
    this.backgroundColor, // Mặc định sẽ dùng màu từ Theme nếu không truyền vào
    this.foregroundColor,
    required this.onPressed,
    required this.title,
    this.height,
    super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).elevatedButtonTheme.style?.backgroundColor?.resolve({}),
        foregroundColor: foregroundColor ?? Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}),
        minimumSize: Size.fromHeight(height ?? 80),
      ),
      child: Text(
        title
      )
    );
  }
}
