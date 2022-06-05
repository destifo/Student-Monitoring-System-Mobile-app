import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              height: MediaQuery.of(context).size.height,
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage("assets/login.jpg"),
              //         fit: BoxFit.fitHeight)),
              padding: EdgeInsets.only(top: 115),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 45),
                      child: const Center(
                        child: Text(
                          "THE Stupid Academy",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: kinputdecoration.copyWith(
                              prefixIcon: Icon(Icons.phone),
                              hintText: "Enter phone number"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          decoration: kinputdecoration.copyWith(
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Enter Your Password"),
                        ),
                      ),
                    ),
                    // Container(
                    //   child: OutlinedButton(
                    //       onPressed: (() {}),
                    //       child: Text(
                    //         "Log In",
                    //         style: TextStyle(fontSize: 45, color: Colors.white),
                    //       )),
                    // )
                  ])),
        ),
      ),
    );
  }
}
