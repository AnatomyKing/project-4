import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  final String hintText;
  final String titleText;
  final String subtitleText;
  final ValueChanged<String> onChanged;

  const SearchHeader({
    Key? key,
    required this.hintText,
    required this.titleText,
    required this.subtitleText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey[200],
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(titleText,
            style:
            const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Text(subtitleText,
            style: const TextStyle(color: Colors.grey)),
      ),
    ],
  );
}
