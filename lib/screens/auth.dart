import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hangout_app/widgets/user_image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';
  var _enteredPhoneNumber = '';
  var _enteredFirstName = '';
  var _enteredLastName = '';
  File? _selectedImage;
  var _isAuthenticating = false;

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid || !_isLogin && _selectedImage == null) {
      return;
    }

    _form.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        final userCredential = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        final userCredential = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
        final url = Uri.https(
            'outdoor-traveler-default-rtdb.firebaseio.com', 'users.json');
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile')
            .child('${userCredential.user!.uid}.jpg');
        await storageRef.putFile(_selectedImage!);
        // final imageUrl = await storageRef.getDownloadURL();
        await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(
            {
              "email": _enteredEmail,
              "username": _enteredUsername,
              "phoneNumber": _enteredPhoneNumber,
              "firstName": _enteredFirstName,
              "lastName": _enteredLastName,
              "image": '${userCredential.user!.uid}.jpg',
              "tokenId": userCredential.user!.uid,
              "role": "user",
              "bio": "",
              "Interest": "",
              "verify": false
            },
          ),
        );
        // final Map<String, dynamic> resData = json.decode(response.body);
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        // ...
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed.'),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFC9652),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_isLogin)
                              Image.asset('assets/images/hangout.png'),
                            Text(
                              _isLogin ? 'Sign In' : 'Register',
                              style: const TextStyle(
                                  color: Color(0xFF3b3b3b),
                                  fontSize: 30 // Set the text color here
                                  ),
                            ),
                            const SizedBox(height: 16),
                            if (!_isLogin)
                              UserImagePicker(
                                onPickImage: (pickedImage) {
                                  _selectedImage = pickedImage;
                                },
                              ),
                            if (!_isLogin)
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'First name',
                                  labelStyle: const TextStyle(
                                    color: Color(
                                        0xFF3B3B3B), // Set the label color here
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF3B3B3B),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                ),
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the following';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _enteredFirstName = value!;
                                },
                              ),
                            if (!_isLogin) const SizedBox(height: 16),
                            if (!_isLogin)
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Last name',
                                  labelStyle: const TextStyle(
                                    color: Color(
                                        0xFF3B3B3B), // Set the label color here
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF3B3B3B),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                ),
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a following.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _enteredLastName = value!;
                                },
                              ),
                            if (!_isLogin) const SizedBox(height: 16),
                            if (!_isLogin)
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  labelStyle: const TextStyle(
                                    color: Color(
                                        0xFF3B3B3B), // Set the label color here
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF3B3B3B),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                ),
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().length < 4) {
                                    return 'Please enter at least 4 characters.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _enteredUsername = value!;
                                },
                              ),
                            if (!_isLogin) const SizedBox(height: 16),
                            if (!_isLogin)
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText:
                                      "Phone Number", // Change the label to "Phone Number"
                                  labelStyle: const TextStyle(
                                    color: Color(0xFF3B3B3B),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF3B3B3B),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                ),
                                keyboardType: TextInputType
                                    .phone, // Set the keyboard type to phone
                                inputFormatters: [
                                  FilteringTextInputFormatter
                                      .digitsOnly, // Allow only digits
                                ],
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter a valid phone number.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  // Handle the saved phone number as needed
                                  _enteredPhoneNumber = value!;
                                },
                              ),
                            const SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Email Address",
                                labelStyle: const TextStyle(
                                  color: Color(
                                      0xFF3B3B3B), // Set the label color here
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF3B3B3B),
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please enter a valid email address.';
                                }

                                return null;
                              },
                              onSaved: (value) {
                                _enteredEmail = value!;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: const TextStyle(
                                  color: Color(
                                      0xFF3B3B3B), // Set the label color here
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF3B3B3B),
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'Password must be at least 6 characters long.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredPassword = value!;
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            if (_isAuthenticating)
                              const CircularProgressIndicator(
                                  color: Color(0xFF3B3B3B)),
                            if (!_isAuthenticating)
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _submit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3B3B3B),
                                    foregroundColor: const Color(0xFFFFFFFF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12.0,
                                      horizontal: 16.0,
                                    ),
                                  ),
                                  child: Text(_isLogin ? 'Login' : 'SignUp'),
                                ),
                              ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(
                                _isLogin
                                    ? 'Create an Account'
                                    : 'I already have an Account.',
                                style: const TextStyle(
                                  color: Color(
                                      0xFF3b3b3b), // Set the text color here
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
