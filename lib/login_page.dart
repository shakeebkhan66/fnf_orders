import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnf_orders/orders_list.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'Utils/shared_class.dart';
import 'constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  // TODO Getting FCM TOKEN
  Future<void> setupToken() async {
    // Get the token each time the application loads
    String? token = await FirebaseMessaging.instance.getToken();
    Constants.preferences?.setString('FCM', token!);
    print("FCM Token is $token");
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      token = event;
    });
  }


  // TODO LOGIN THROUGH SERVER API
  bool isLoading = false;
  login(String username, password)async{
    try{
      var response = await post(
          Uri.parse('http://192.168.100.240:5000/api/login/'),
          body: {
            "username": username,
            "password": password,
          });
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        print("Login Successfully");
        setState(() => isLoading = true);
        Constants.preferences!.setBool("loggedIn", true);
        Constants.preferences?.setString('Token', data['token']);
        // // Constants.preferences?.setInt('USERID', data['userId']);
        // Constants.preferences?.setInt('SubsidyPercentage', data['subsidy_percentage']);
        // Constants.preferences?.setString('Username', data['name']);
        setState(() {
          isLoading = true;
        });
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => const OrdersList()));
      }else{
        print("Failed");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Failed")));
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


  // TODO Heading
  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Text(
            'Friends n Family',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  // TODO Email TextField
  Widget _buildEmailRow() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.name,
        controller: nameController,
        validator: (val) {
          if(val.toString().isEmpty){
            return "Please Enter Your Name";
          } else if(val.toString().length < 3){
            return "Name is too small";
          } else{
            return null;
          }
        },
        decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: mainColor,
            ),
            labelText: 'Name', labelStyle: TextStyle(fontWeight: FontWeight.bold, color: mainColor)),
      ),
    );
  }

  // TODO Password TextField
  Widget _buildPasswordRow() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: passwordController,
        obscureText: true,
        validator: (val) {
          if(val.toString().isEmpty){
            return "Please Enter Your Password";
          } else if(val.toString().length < 4){
            return "Password is too small";
          } else{
            return null;
          }
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.password,
            color: mainColor,
          ),
          labelText: 'Password', labelStyle: TextStyle(fontWeight: FontWeight.bold, color: mainColor)
        ),
      ),
    );
  }

  // TODO Forgot Password Button
  Widget _buildForgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MaterialButton(
          onPressed: () {},
          child: const Text("Forgot Password"),
        ),
      ],
    );
  }

  // TODO Login Button
  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: const EdgeInsets.only(bottom: 20),
          child: MaterialButton(
            elevation: 5.0,
            color: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () {
              if(formKey.currentState!.validate()){
                // ignore: void_checks
                return login(
                  nameController.text.toString(),
                  passwordController.text.toString(),
                );
              } else{
                return null;
              }
              Navigator.push(context, MaterialPageRoute(builder: (ctx) => const OrdersList()));
            },
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
    );
  }

  // Widget _buildOrRow() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       Container(
  //         margin: const EdgeInsets.only(bottom: 20),
  //         child: const Text(
  //           '- OR -',
  //           style: TextStyle(
  //             fontWeight: FontWeight.w400,
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget _buildSocialBtnRow() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       GestureDetector(
  //         onTap: () {},
  //         child: Container(
  //           height: 60,
  //           width: 60,
  //           decoration: const BoxDecoration(
  //             shape: BoxShape.circle,
  //             color: mainColor,
  //             boxShadow: [
  //               BoxShadow(
  //                   color: Colors.black26,
  //                   offset: Offset(0, 2),
  //                   blurRadius: 6.0)
  //             ],
  //           ),
  //           child: const Icon(
  //             FontAwesomeIcons.google,
  //             color: Colors.white,
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }


  // TODO Container or Card Design On Stack


  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                      ),
                    ),
                  ],
                ),
                _buildEmailRow(),
                _buildPasswordRow(),
                _buildForgetPasswordButton(),
                _buildLoginButton(),
                // _buildOrRow(),
                // _buildSocialBtnRow(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildSignUpBtn() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       Padding(
  //         padding: const EdgeInsets.only(top: 40),
  //         child: MaterialButton(
  //           onPressed: () {},
  //           child: RichText(
  //             text: TextSpan(children: [
  //               TextSpan(
  //                 text: 'Dont have an account? ',
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: MediaQuery.of(context).size.height / 40,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //               TextSpan(
  //                 text: 'Sign Up',
  //                 style: TextStyle(
  //                   color: mainColor,
  //                   fontSize: MediaQuery.of(context).size.height / 40,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               )
  //             ]),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }


  @override
  void initState() {
    setupToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xfff2f3f7),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: const BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70),
                  ),
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildLogo(),
                  _buildContainer(),
                  // _buildSignUpBtn(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}