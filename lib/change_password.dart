import 'package:flutter/material.dart';
import 'package:fnf_orders/constants.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffafa),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 130,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
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
            const SizedBox(height: 20,),
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.password_outlined, color: Colors.blue,),
                hintText: "Enter your old password",
                hintStyle: TextStyle(color: Colors.lightBlueAccent),
                labelText: "Old Password",
                labelStyle: TextStyle(color: mainColor, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}


