import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/core/app_route.dart';
import 'package:todo_list/data/model/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var fullName = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 205, 229, 249),
              ),
              child: Icon(
                Icons.person,
                size: 100,
                color: const Color.fromARGB(255, 33, 110, 173),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Create Your Profile",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: .w600,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Add Your Name And Your Profile Picture",
              style: TextStyle(
                color: const Color.fromARGB(255, 201, 174, 174),
                fontSize: 15,
                fontWeight: .w600,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 20),
            TextFormFieldWiget(
              labelText: "Full Name",
              hintText: "Ex: Yehia Ashraf",
              validator: (value) {
                if (value!.isEmpty || value == null) {
                  return "Please Enter Your Name";
                }
                return null;
              },
              controller: fullName,
            ),
            SizedBox(height: 22),

            TextFormFieldWiget(
              labelText: "password",
              hintText: "Ex: yehia1234",
              maxLines: 1,
              validator: (value) {
                if (value!.isEmpty || value == null) {
                  return "Please Enter Your password";
                }
                return null;
              },
              controller: password,
            ),

            SizedBox(height: 22),
         MaterialButton(
  onPressed: () async {
    if (fullName.text.trim().isEmpty || password.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text(
              "Please enter your full name and password", 
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return; 
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(
                color: Color(0xff235BDD),
                backgroundColor: Color.fromARGB(255, 152, 195, 232),
              ),
              SizedBox(width: 20),
              Text("Loading..."),
            ],
          ),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 2));

    var userBox = Hive.box<UserModel>('user');

    await userBox
        .put(
          "userKey",
          UserModel(
            fullName: fullName.text,
            password: password.text,
          ),
        )
        .then((value) {
          if (context.mounted) {
            Navigator.of(context).pop(); 
            Navigator.of(context).pushNamed(AppRoutes.home);
          }
        }).catchError((error) {
          if (context.mounted) {
            Navigator.of(context).pop(); 
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(
                    error.toString(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          }
        });
  },
  minWidth: double.infinity,
  height: 50,
  color: const Color.fromARGB(255, 35, 75, 221),
  padding: const EdgeInsets.all(10),
  elevation: 10,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  mouseCursor: MaterialStateMouseCursor.clickable,
  hoverColor: const Color.fromARGB(255, 33, 24, 155),
  focusColor: const Color.fromARGB(255, 86, 94, 135),
  child: const Text(
    "Continue",
    style: TextStyle(
      color: Colors.white,
      fontSize: 13,
      fontWeight: FontWeight.w600,
      fontFamily: "Poppins",
    ),
  ),
),
],),
      ),
    );
  }
}

class TextFormFieldWiget extends StatelessWidget {
  const new({
    super.key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.validator,
    this.maxLines = 1,
  });
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      cursorErrorColor: Colors.red,

      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,

        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: .w600,

          fontFamily: "Poppins",
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 80, 160, 227),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 11, 93, 160),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
