import 'package:flutter/material.dart';

import '../utills/apps_colors.dart';

class task_list_card extends StatelessWidget {
  const task_list_card({
    super.key,
    required this.buttonname,
    required this.chipcolor,
    this.bordersidecolor,
  });
  final String buttonname;
  final Color chipcolor;
  final Color? bordersidecolor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lorem Ipsum is simply dummy",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. "),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text("Date:02/10/2024"),
                    _buildRowChip()
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 2);
        },
      ),
    );
  }

// this method use to chip
  Widget _buildRowChip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Chip(
          label: Text(
            "$buttonname",
            style: TextStyle(color: Colors.black),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: chipcolor,
          side: BorderSide(color: bordersidecolor ?? Appscolor.themecolor),
        ),
        wrap_Icon_Button()
      ],
    );
  }
  // this method used to wrap with icon button
  Widget wrap_Icon_Button() {
    return Wrap(
        children: [
          IconButton(
              onPressed: _buildEditIconButton,
              icon: const Icon(Icons.edit, color: Colors.green)),
          IconButton(
              onPressed: _buildDeletetIconButton,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ],
      );
  }

  //edit Icon button
  void _buildEditIconButton() {
    //TODO: implements build edit icon button
  }
//delete Icon button
  void _buildDeletetIconButton() {
    //TODO: implements build edit icon button
  }
}
