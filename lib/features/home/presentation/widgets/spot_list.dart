import 'package:flutter/material.dart';

class SpotList extends StatelessWidget {
  const SpotList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
