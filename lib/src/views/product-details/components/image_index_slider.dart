import 'package:flutter/material.dart';

class SingleSliderIndicator extends StatelessWidget {
  const SingleSliderIndicator({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: isSelected ? 7 : 5,
      width: isSelected ? 20 : 15,
      decoration: BoxDecoration(
        color: isSelected ? Colors.indigo[900] : Colors.indigo[200],
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
