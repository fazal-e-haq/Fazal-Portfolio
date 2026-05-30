import 'package:flutter/material.dart';

class LinkButtonWidget extends StatelessWidget {
  LinkButtonWidget({
    super.key,
    required this.url,
    required this.name,
    required this.icon,
    this.onPressed,
  });

  // Global variables
  final String url;
  final String name;
  void Function()? onPressed;
  final Icon icon;

  bool isHovered = false;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shadowColor: WidgetStatePropertyAll(Colors.black),
        elevation: WidgetStatePropertyAll(8),
        alignment: Alignment.center,
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: .circular(100)),
        ),

      ),
      autofocus: true,

      onHover: isHovered ? (value) {

      } : (value) {},

      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(name, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
