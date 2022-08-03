import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnf_orders/constants.dart';
import 'package:fnf_orders/login_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';

import 'Utils/shared_class.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var myToken = Constants.preferences?.getString('Token');


  // TODO CHANGE PASSWORD
  bool isLoading = false;
  changeFunction(String oldPassword, newPassword, confirmPassword)async{
    try{
      var response = await put(
          Uri.parse('http://192.168.100.240:5000/api/change-password/'),
          body: {
            "old_password": oldPassword,
            "password": newPassword,
            "password2": confirmPassword,
          },
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
          'Authorization': 'Token $myToken',
        }
          );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        setState(() => isLoading = true);
        setState(() {
          isLoading = true;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      }else{
        print("Failed");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Old Password is Wrong")));
      }
      setState(() {
        isLoading = false;
      });
    }catch(e){
      print(e.toString());
      Get.snackbar(
        'Network Error',
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true ?  CircularProgressIndicator() : Scaffold(
      backgroundColor: const Color(0xfffffafa),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 130,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Reset Password",
                    style: TextStyle(
                      color: mainColor, fontWeight: FontWeight.bold, fontSize: 25,
                      letterSpacing: 1.0,
                      shadows: [
                        Shadow(
                            offset: const Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            color: Colors.lightBlueAccent.withOpacity(0.3)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: oldPasswordController,
                  validator: (val) {
                    if(val.toString().isEmpty){
                      return "please enter your old password";
                    } else if(val.toString().length < 6){
                      return "provide more than 6 characters";
                    } else{
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.password_outlined, color: Colors.blue,),
                    hintText: "Enter your old password",
                    hintStyle: TextStyle(color: Colors.black26),
                    labelText: "Old Password",
                    labelStyle: TextStyle(color: mainColor, fontWeight: FontWeight.w500),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 13.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: newPasswordController,
                  validator: (val) {
                    if(val.toString().isEmpty){
                      return "please enter your new password";
                    } else if(val.toString().length < 6){
                      return "provide more than 6 characters";
                    } else{
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.password_outlined, color: Colors.blue,),
                    hintText: "Enter new password",
                    hintStyle: TextStyle(color: Colors.black26),
                    labelText: "New Password",
                    labelStyle: TextStyle(color: mainColor, fontWeight: FontWeight.w500),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 13.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: confirmPasswordController,
                  validator: (val) {
                    return val == newPasswordController.text
                        ? null
                        : "Password did not matched";
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.password_outlined, color: Colors.blue,),
                    hintText: "Enter confirm password",
                    hintStyle: TextStyle(color: Colors.black26),
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(color: mainColor, fontWeight: FontWeight.w500),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: MaterialButton(
                  height: 45,
                  color: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      // ignore: void_checks
                      return changeFunction(
                        oldPasswordController.text.toString(),
                        newPasswordController.text.toString(),
                        confirmPasswordController.text.toString(),
                      );
                    } else{
                      return null;
                    }
                  },
                  child: const Text("Change Password", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


