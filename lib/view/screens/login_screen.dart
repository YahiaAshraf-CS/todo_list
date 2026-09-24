import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var fullName= TextEditingController();

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
            MaterialButton(
              onPressed: () {},
              child: Text(
                "Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: .w600,
                  fontFamily: "Poppins",
                ),
              ),
              minWidth: double.infinity,
              height: 50,
              color: const Color.fromARGB(255, 35, 75, 221),
              padding: EdgeInsets.all( 10),
               elevation: 10,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(20),
               ),
               mouseCursor: MaterialStateMouseCursor.clickable,
               hoverColor: Color.fromARGB(255, 33, 24, 155), focusColor: Color.fromARGB(255, 86, 94, 135),
              
            ),
          ],
        ),
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
  });
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      controller: controller,
      validator: validator,

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
            color: const Color.fromARGB(255, 33, 110, 173),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 33, 110, 173),
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
