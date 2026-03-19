import 'package:flutter/material.dart';
import 'package:udoo_erp/screens/main_screen.dart';
import 'package:udoo_erp/widgets/logo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscured = true;
  bool _isValidEmail = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  // // @override
  // void iniState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: SingleChildScrollView(child: _body)),
    );
  }

  Widget get _body {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _top,
          SizedBox(height: 40),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _email,
                SizedBox(height: 20),
                _password,
                SizedBox(height: 20),
                _loginButton,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get _top {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LogoWidget(),
        // SizedBox(height: 16),
        Text(
          'Udoo ERP',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
          'Welcome back! Please log in to your account',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget get _email {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email Address',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            setState(() {
              _isValidEmail = value.contains('@');
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!value.contains('@')) {
              return 'Invalid email format';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'name12@gmail.com',
            suffixIcon: _isValidEmail
                ? Icon(Icons.check_circle, color: Colors.green)
                : null,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  Widget get _password {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: _isObscured,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: '',
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
              icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  Widget get _loginButton {
    return SizedBox(
      height: 50,
      width: double.infinity,
      // width: MediaQuery.of(context).size.width * 1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            try {
              await _auth.signInWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => MainScreen()),
              );
            } on FirebaseAuthException catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.message ?? 'Login Failed')),
              );
            }
          }
        },
        child: Text(
          'Login',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
