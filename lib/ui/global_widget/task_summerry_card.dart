import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tasksummerycard extends StatelessWidget {
  const Tasksummerycard({
    super.key, required this.titile, required this.count,
  });
  final String titile;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: SizedBox(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$count",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600
              ),),
              // fitted box used korar karon hoilo jototku jaiya ache oi text ta
              // oi jaigar viore thakbe
              FittedBox(
                child: Text("$titile",style: const TextStyle(
                    color: CupertinoColors.inactiveGray
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
