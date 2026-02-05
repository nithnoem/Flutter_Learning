import 'package:flutter/material.dart';
import 'package:udoo_erp/widgets/logo_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObsure = true;
  bool _isValidEmail = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // @override
  void iniState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: _body);
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
    // return TextFormField(
    //   controller: _emailController,
    //   onChanged: (value) {
    //     print("Value $value");
    //     if (value.contains("@")) {
    //       setState(() {
    //         _isValidEmail = true;
    //       });
    //     }
    //   },
    //   validator: (value) {
    //     if (value == null || value.isEmpty) {
    //       return 'Please enter your email';
    //     }
    //     return null;
    //   },
    //   decoration: InputDecoration(
    //     // prefix: Icon(Icons.attach_email),
    //     suffix: _isValidEmail
    //         ? Icon(Icons.check_circle, color: Colors.green)
    //         : Icon(Icons.check_circle),
    //     labelText: 'Email',
    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    //   ),
    // );
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
          obscureText: _isObsure,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'example12@',
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isObsure = !_isObsure;
                });
              },
              icon: Icon(_isObsure ? Icons.visibility_off : Icons.visibility),
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
    // return TextFormField(
    //   controller: _passwordController,
    //   obscureText: _isObsure,
    //   validator: (value) {
    //     if (value == null || value.isEmpty) {
    //       return 'Please enter your password';
    //     }
    //     return null;
    //   },
    //   decoration: InputDecoration(
    //     // prefix: Icon(Icons.visibility),
    //     labelText: 'Password',
    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    //     suffixIcon: IconButton(
    //       onPressed: () {
    //         setState(() {
    //           _isObsure = !_isObsure;
    //         });
    //       },
    //       icon: Icon(Icons.visibility_off),
    //     ),
    //   ),
    // );
  }

  Widget get _loginButton {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * 1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
        ),
        onPressed: () {},
        child: Text(
          'Login',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
