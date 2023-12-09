import 'package:flutter/material.dart';

class WeightRepWheel extends StatefulWidget {
  const WeightRepWheel({super.key});

  @override
  State<WeightRepWheel> createState() => _WeightRepWheelState();
}

class _WeightRepWheelState extends State<WeightRepWheel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 36, 36),
      body: ListWheelScrollView.useDelegate(
        physics: const BouncingScrollPhysics(),
        itemExtent: 50,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: 10,
          builder: (context, index) {
            return Text('weight');
          },
        ),
      ),
    );
  }
}
