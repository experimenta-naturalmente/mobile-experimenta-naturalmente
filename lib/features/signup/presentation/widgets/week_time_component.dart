import 'package:flutter/material.dart';

class WeekTimeComponent extends StatelessWidget {
  final String text;
  const WeekTimeComponent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.5, horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.check_box,
              color: Theme.of(context).disabledColor,
            ),
          ),
        ],
      ),
    );
  }
}
