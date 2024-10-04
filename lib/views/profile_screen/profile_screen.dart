import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managment/global_widget/background_image.dart';
import 'package:task_managment/utills/apps_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BackgroundImage(
            child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: 10.0,
                bottom: 10.0 + MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Update Profile ",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildPhotoTaker(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildUpdateProfileForm(), //return widgrt method signin form
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        )));
  }

  //image piker er jonno widget
Container _buildPhotoTaker(){
 return Container(
   height: 50,
    decoration: BoxDecoration(
        color: Colors.white,
      borderRadius: BorderRadius.circular(8)
    ),
    child: Row(
      children: [
        Container(
          width: 100,
          height: 50,
          decoration: const BoxDecoration(
              color: Colors.grey,
            borderRadius: BorderRadius.only(
                topLeft:Radius.circular(8),
                bottomLeft:Radius.circular(8),
            ),
          ),
          child: const Center(child: Text("Photo ",style: TextStyle(color: Colors.white,fontSize: 16),)),
        )
      ],
    )
  );
}
// textformfiled er text
  Widget _buildUpdateProfileForm() {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: "Email"),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          decoration: const InputDecoration(hintText: "First Name"),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          decoration: const InputDecoration(hintText: "Last Name"),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(hintText: "Mobile"),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          decoration: const InputDecoration(hintText: "password"),
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
            onPressed: _onTapNextPage,
            child: const Icon(Icons.arrow_circle_right_outlined)),
      ],
    );
  }

  void _onTapNextPage() {
    // TODO:implementation on tap next page
  }

}
