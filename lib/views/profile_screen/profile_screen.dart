import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_managment/controller/auth_controller.dart';
import 'package:task_managment/global_widget/background_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final TextEditingController _textEmaillController = TextEditingController();
  final TextEditingController _textFirstNameController = TextEditingController();
  final TextEditingController _textLastNameController = TextEditingController();
  final TextEditingController _textMobileController = TextEditingController();
  final TextEditingController _textpasswordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  XFile ?_selectedimage;

  bool _updateProfileInprogress=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setuserdata();
  }

  void _setuserdata() {
    _textEmaillController.text = AuthController.userdata?.email ?? '';
    _textFirstNameController.text = AuthController.userdata?.firstName ?? '';
    _textLastNameController.text = AuthController.userdata?.lastName ?? '';
    _textMobileController.text = AuthController.userdata?.mobile ?? '';
  }

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
                    bottom: 10.0 + MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom),
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Update Profile ",
                        style: Theme
                            .of(context)
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
                      _buildUpdateProfileForm(),
                      //return widgrt method signin form
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            )));
  }

// textformfiled er text
  Widget _buildUpdateProfileForm() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            enabled: false,
            controller: _textEmaillController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _textFirstNameController,
            decoration: const InputDecoration(hintText: "First Name"),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _textLastNameController,
            decoration: const InputDecoration(hintText: "Last Name"),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _textMobileController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(hintText: "Mobile"),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(controller: _textpasswordController,
            decoration: const InputDecoration(hintText: "password"),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
              onPressed: _onTapNextPage,
              child: const Icon(Icons.arrow_circle_right_outlined)),
        ],
      ),
    );
  }

  void _onTapNextPage() {
    // TODO:implementation on tap next page
    if (_formkey.currentState!.validate()) {}
  }
  //image piker er jonno widget
  Widget _buildPhotoTaker() {
    return GestureDetector(
      onTap: _imagepicker,
      child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: const Center(
                    child: Text(
                      "Photo ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
              ),
              SizedBox(width: 8,),
              Text(_getselectedimage())
            ],
          )),
    );
  }

  String _getselectedimage(){
    if(_selectedimage != null){
      return _selectedimage!.name;
    }
    return 'selectedimage';
  }

  //api caller
  Future<void> _getupdateProfile()async{
      _updateProfileInprogress=true;
      setState(() {
      });
      Map<String,dynamic> requestbody={
        "email":_textEmaillController.text.trim(),
        "firstName":_textFirstNameController.text.trim(),
        "lastName":_textLastNameController.text.trim(),
        "mobile":_textMobileController.text.trim(),
      };

      if(_textpasswordController.text.isNotEmpty){

      }
  }

  Future<void> _imagepicker()async{
    ImagePicker imagepicker= ImagePicker();
    XFile? pickedimage=await imagepicker.pickImage(source: ImageSource.gallery);
  if(pickedimage!= null){
    _selectedimage=pickedimage;
  }
  }
}
