import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
//import 'package:lottie/lottie.dart';
<<<<<<< HEAD
// import 'package:responsive_login_ui/views/signup_volunteer.dart';
import '../views/login_view.dart';
import '../constants.dart';
import '../controller/simple_ui_controller.dart';
import 'package:responsive_login_ui/views/Driver.dart';
=======

import '../views/login_view.dart';
import '../constants.dart';
import '../controller/simple_ui_controller.dart';
>>>>>>> fbbe6b76034188446022129f432fee451f9e73eb

class SignUpViewDriver extends StatefulWidget {
  const SignUpViewDriver({Key? key}) : super(key: key);

  @override
  State<SignUpViewDriver> createState() => _SignUpViewStateDriver();
}

class _SignUpViewStateDriver extends State<SignUpViewDriver> {
  TextEditingController nameController = TextEditingController();
  TextEditingController licenceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    licenceController.dispose();
    super.dispose();
  }

  SimpleUIController simpleUIController = Get.put(SimpleUIController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("EmergenSee"),
          ),
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildLargeScreen(size, simpleUIController, theme);
              } else {
                return _buildSmallScreen(size, simpleUIController, theme);
              }
            },
          )),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Row(
      children: [
        SizedBox(width: size.width * 0.06),
        Expanded(
          flex: 5,
          child: _buildMainBody(size, simpleUIController, theme),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Center(
      child: _buildMainBody(size, simpleUIController, theme),
    );
  }

  /// Main Body
  Widget _buildMainBody(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          size.width > 600 ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        size.width > 600
            ? Container()
            : SizedBox(
                height: size.height * 0.03,
              ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Enter your details as on your License',
            style: kLoginTitleStyle(size),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                /// username
                TextFormField(
                  style: kTextFormFieldStyle(),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'State',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),

                  controller: nameController,
                  // The validator receives the text that the user has entered.
                ),
                SizedBox(
                  height: 60,
                ),

                /// Contact
                TextFormField(
                  style: kTextFormFieldStyle(),
                  controller: licenceController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.perm_identity),
                    hintText: 'License ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  /*validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter gmail';
                    } else if (!value.endsWith('@gmail.com')) {
                      return 'please enter valid gmail';
                    }
                    return null;
                  },*/
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),

                /// SignUp Button
                signUpButton(theme),
                SizedBox(
                  height: size.height * 0.03,
                ),

                /// Navigate To Login Screen
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (ctx) => const LoginView()));
                    nameController.clear();
                    licenceController.clear();
                    _formKey.currentState?.reset();

                    simpleUIController.isObscure.value = true;
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account?',
                      style: kHaveAnAccountStyle(size),
                      children: [
                        TextSpan(
                            text: " Login",
                            style: kLoginOrSignUpTextStyle(size)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // SignUp Button
  Widget signUpButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
<<<<<<< HEAD
      height: 55,
=======
      height: 35,
>>>>>>> fbbe6b76034188446022129f432fee451f9e73eb
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
<<<<<<< HEAD
          // if (_formKey.currentState!.validate()) {
          //   // ... Navigate To your Home Page
          // }
          Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => driver()));
=======
          if (_formKey.currentState!.validate()) {
            // ... Navigate To your Home Page
          }
>>>>>>> fbbe6b76034188446022129f432fee451f9e73eb
        },
        child: const Text('Sign up'),
      ),
    );
  }
}
