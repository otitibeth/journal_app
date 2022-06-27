import 'package:flutter/material.dart';
import 'package:my_journal/models/http_exception.dart';
import 'package:my_journal/resources/auth_methods.dart';
import 'package:my_journal/screens/notelist_screen.dart';
import 'package:my_journal/utils/utils.dart';
import 'package:my_journal/widgets/text_field_input.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final TextEditingController _passwordController = TextEditingController();
  var _isLoading = false;
  var _obscureText = true;
  var _obscureText1 = true;

  void visibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void visibility1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).signin(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      }
      if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid Email address.';
      }
      if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'Password is too weak.';
      }
      if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'couldn\'t find a user with that email.';
      }
      if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Password is incorrect.';
      }
      showSnackbar(context, errorMessage);
    } catch (error) {
      const errorMessage = 'Couldn\'t authenticate user. Try again later.';
      showSnackbar(context, errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  void navigateHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const NoteListScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: const BorderRadius.all(Radius.circular(20)));
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'My Journal',
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      border: inputBorder,
                      enabledBorder: inputBorder,
                      focusedBorder: inputBorder,
                      filled: true,
                      contentPadding: const EdgeInsets.all(8),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                    },
                    onSaved: (value) {
                      _authData['email'] = value!;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Password',
                        border: inputBorder,
                        enabledBorder: inputBorder,
                        focusedBorder: inputBorder,
                        filled: true,
                        contentPadding: const EdgeInsets.all(8),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility_off_sharp
                              : Icons.visibility_sharp),
                          onPressed: visibility,
                        )),
                    obscureText: _obscureText ? true : false,
                    controller: _passwordController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                    },
                    onSaved: (value) {
                      _authData['password'] = value!;
                    },
                  ),
                  const SizedBox(height: 12),
                  if (_authMode == AuthMode.Signup)
                    TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          border: inputBorder,
                          enabledBorder: inputBorder,
                          focusedBorder: inputBorder,
                          filled: true,
                          contentPadding: const EdgeInsets.all(8),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText1
                                ? Icons.visibility_off_sharp
                                : Icons.visibility_sharp),
                            onPressed: visibility1,
                          )),
                      textInputAction: TextInputAction.done,
                      obscureText: _obscureText1 ? true : false,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match!';
                              }
                            }
                          : null,
                    ),
                  SizedBox(
                    height: _authMode == AuthMode.Login ? 22 : 27,
                  ),
                  InkWell(
                    onTap: _submit,
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: const LinearGradient(colors: [
                            Colors.purpleAccent,
                            Colors.purple,
                            Color.fromARGB(255, 38, 7, 39),
                          ])),
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              _authMode == AuthMode.Signup ? 'SignUp' : 'Login',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_authMode == AuthMode.Signup
                          ? 'Already have an account?'
                          : 'New Here?'),
                      TextButton(
                        onPressed: _switchAuthMode,
                        child: Text(
                          _authMode == AuthMode.Signup ? 'Login!' : 'SignUp',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
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
