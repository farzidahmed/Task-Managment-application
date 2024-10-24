import 'dart:io';

import 'package:flutter/material.dart';

import '../utills/apps_colors.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class task_list_card extends StatefulWidget {
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
  State<task_list_card> createState() => _task_list_cardState();
}

class _task_list_cardState extends State<task_list_card> {
  final List<void> newtask=[];
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
          return const SizedBox(height: 2);
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
            "${widget.buttonname}",
            style: const TextStyle(color: Colors.black),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: widget.chipcolor,
          side: BorderSide(color: widget.bordersidecolor ?? Appscolor.themecolor),
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
    showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor:Colors.white,
        shadowColor:Colors.transparent ,
        title: const Column(
          children: [
            Text("Edit Status"),
            Divider(
              color: Colors.grey,
            )
          ],
        ),
        content:
        //list of widget ...
        Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            'New','Completed','Canceled','Progress'].map((e){
              return ListTile(
                onTap: (){},
                title:Text (e),
              );
          }).toList()
        ),
        actions: [
          TextButton(onPressed: (){
            const materialBanner = MaterialBanner(
              /// need to set following properties for best effect of awesome_snackbar_content
              elevation: 0,
              backgroundColor: Colors.transparent,
              forceActionsBelow: true,
              content: AwesomeSnackbarContent(
                title: 'Thank you!!',
                message:
                'You click cancel button ',

                /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                contentType: ContentType.success,
                // to configure for material banner
                inMaterialBanner: true,
              ),
              actions: [SizedBox.shrink()],
            );

            ScaffoldMessenger.of(context)
              ..hideCurrentMaterialBanner()
              ..showMaterialBanner(materialBanner);

            Navigator.pop(context);
          },
              child: const Text("Cancel",style: TextStyle(
                fontSize: 16
              ),)),
          TextButton(onPressed:(){
          },
              child: const Text("okay",style: TextStyle(
                  fontSize: 20
              ),)),

        ],
      );
    });
  }

//delete Icon button
  void _buildDeletetIconButton() {
    //TODO: implements build edit icon button
  }
}
