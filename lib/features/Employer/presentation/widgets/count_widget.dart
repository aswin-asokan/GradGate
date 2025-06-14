import 'package:flutter/material.dart';

class CountWidget extends StatelessWidget {
  const CountWidget(
      {super.key,
      required this.color,
      required this.count,
      required this.icon,
      required this.iconColor,
      required this.title});
  final Color color;
  final int count;
  final String title;
  final IconData icon;
  final Color iconColor;
  String formatCount(int count) {
    if (count >= 1000) {
      double inThousands = count / 1000;
      // If exact multiple of 1000, don't show decimal (e.g., 2K instead of 2.0K)
      return inThousands % 1 == 0
          ? '${inThousands.toInt()}K'
          : '${inThousands.toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      width: 350,
      height: 160,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: color),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 40,
                  )),
            ],
          ),
          const SizedBox(
            width: 25,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatCount(count),
                style:
                    const TextStyle(fontWeight: FontWeight.w900, fontSize: 45),
              ),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 17)),
            ],
          )
        ],
      ),
    );
  }
}
