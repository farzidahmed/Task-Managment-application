import 'package:flutter/material.dart';
import 'package:task_managment/ui/global_widget/snakbar_message.dart';
import '../../data/api_controlls/models/network_responce.dart';
import '../../data/api_controlls/models/task_model.dart';
import '../../data/api_controlls/services/network_caller.dart';
import '../utills/apps_colors.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../utills/urls.dart';

class task_list_card extends StatefulWidget {
   task_list_card({
    super.key,
    required this.buttonname,
    required this.chipcolor,
    this.bordersidecolor,
       required this.taskModel, required this.onrefress
  });
  final String buttonname;
  final Color chipcolor;
  final Color? bordersidecolor;
  final TaskModel taskModel;
  final VoidCallback onrefress;
  @override
  State<task_list_card> createState() => _task_list_cardState();
}

class _task_list_cardState extends State<task_list_card> {
  String _selectedStatus ="";
  bool _changeStatusInprogress=false;
  bool _deleteStatusInprogress=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedStatus=widget.taskModel!.status!;
  }

  @override
  Widget build(BuildContext context) {
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
                  widget.taskModel.title??"",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                   Text(
                      widget.taskModel.description??""),
                  const SizedBox(
                    height: 8,
                  ),
                   Text(widget.taskModel.createdDate??""),
                  _buildRowChip()
                ],
              ),
            ),
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
          Visibility(
            visible: _changeStatusInprogress==false,
            replacement: const CircularProgressIndicator(),
            child: IconButton(
                onPressed: _buildEditIconButton,
                icon: const Icon(Icons.edit, color: Colors.green)),
          ),
          Visibility(
            visible: _deleteStatusInprogress==false,
            replacement: const CircularProgressIndicator(),
            child: IconButton(
                onPressed: _buildDeletetIconButton,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ),
        ],
      );
  }

  //edit Icon button
  void _buildEditIconButton() {
    print(_selectedStatus);
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
                onTap: (){
                  _changeStatus(e);
                  Navigator.pop(context);
                },
                title:Text (e),
                selected: _selectedStatus==e,
                trailing: _selectedStatus==e? const Icon(Icons.check):null,
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

        ],
      );
    });
  }

//delete Icon button
  Future<void> _buildDeletetIconButton() async {
    _deleteStatusInprogress=true;
    setState(() {
    });
    final NetworkResponse response = await NetworkCaller.getRequest(url:Urls.deleteTask(widget.taskModel.sId!));
    if(response.isSuccess){
      widget.onrefress();
    }else{
      _deleteStatusInprogress=false;
      setState(() {
      });
      snakbarmessage(context, response.errormessege);
    }
  }
  Future<void> _changeStatus (String newstatus )async{
      _changeStatusInprogress=true;
      setState(() {
      });
      final NetworkResponse response = await NetworkCaller.getRequest(url:Urls.changeStatus(widget.taskModel.sId!, newstatus));
      if(response.isSuccess){
          widget.onrefress();
      }else{
        _changeStatusInprogress=false;
        setState(() {
        });
        snakbarmessage(context, response.errormessege);
      }
  }
}
