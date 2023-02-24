import 'package:flutter/material.dart';
import 'package:todo_app/shared/components/components.dart';

// Reusable Components
// 1. Save time
// 2. Easy to update
// 3. Good Quality

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              // Key is the form name to let the validator start
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Login title field
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // To add space between the widget use SizedBox
                  SizedBox(
                    height: 40.0,
                  ),
                  // Email Address Field
                  defaultFormField(
                    controller: emailController,
                    lable: 'Email Address',
                    prefix: Icons.email,
                    type: TextInputType.emailAddress,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Email Address Must Not Be Empty';
                      }
                      return null;
                    },
                    onSubmit: (value) => print(value),
                    onChange: (data) => print(data),
                  ),
                  // TextFormField(
                  //   // To save the value in the variable
                  //   controller: emailController,
                  //   // To print final value
                  //   onFieldSubmitted: (value) => print(value),
                  //   // To print word by word as you changed the value
                  //   onChanged: (value) => print(value),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Email Address Must Not Be Empty';
                  //     }
                  //     return null;
                  //   },
                  //   keyboardType: TextInputType.emailAddress,
                  //   decoration: InputDecoration(
                  //     labelText: 'Email Address',
                  //     //hintText: 'Email Address',

                  //     // To hide bottom border from the feild
                  //     //border: InputBorder.none,
                  //     border: OutlineInputBorder(),
                  //     prefixIcon: Icon(Icons.email),
                  //   ),
                  // ),
                  SizedBox(
                    height: 15.0,
                  ),
                  // Password Field
                  defaultFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Password Must Not Be Empty';
                      }
                      return null;
                    },
                    lable: 'Password',
                    isPassword: isPassword,
                    prefix: Icons.lock,
                    suffix:
                        isPassword ? Icons.visibility : Icons.visibility_off,
                    suffixPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                  ),
                  // TextFormField(
                  //   controller: passwordController,
                  //   onFieldSubmitted: (value) => print(value),
                  //   onChanged: (value) => print(value),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Password Must Not Be Empty';
                  //     }
                  //     return null;
                  //   },
                  //   keyboardType: TextInputType.visiblePassword,
                  //   // To hide the Password
                  //   obscureText: true,
                  //   decoration: InputDecoration(
                  //     labelText: 'Password',
                  //     border: OutlineInputBorder(),
                  //     prefixIcon: Icon(Icons.lock),
                  //     suffixIcon: Icon(Icons.remove_red_eye),
                  //   ),
                  // ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // Login Button
                  defaultButton(
                    width: double.infinity,
                    background: Colors.red,
                    isUpperCase: true,
                    text: 'login',
                    radius: 10.0,
                    function: () {
                      if (formKey.currentState!.validate()) {
                        print(emailController.text);
                        print(passwordController.text);
                      }
                    },
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   height: 40.0,
                  //   color: Colors.blue,
                  //   child: MaterialButton(
                  //     onPressed: () {
                  //       print(emailController.text);
                  //       print(passwordController.text);
                  //     },
                  //     child: Text(
                  //       'Login',
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                  // Used Reusable Button

                  SizedBox(
                    height: 10.0,
                  ),
                  // Text & Regester Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Regester Now',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
