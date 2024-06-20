// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/auth_provider.dart';
// import './login_screen.dart';

// class RegisterScreen extends StatefulWidget {
//   static const routeName = '/register';

//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;

//   void _register(BuildContext context) async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     final email = _emailController.text;
//     final password = _passwordController.text;

//     try {
//       await Provider.of<AuthProvider>(context, listen: false)
//           .register(email, password);
//       Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
//     } catch (error) {
//       showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//           title: Text('An Error Occurred!'),
//           content: Text('Failed to register. Please try again later.'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Okay'),
//               onPressed: () {
//                 Navigator.of(ctx).pop();
//               },
//             ),
//           ],
//         ),
//       );
//     }

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.pink, Colors.pinkAccent],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               elevation: 8.0,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       TextFormField(
//                         controller: _emailController,
//                         decoration: InputDecoration(labelText: 'Email'),
//                         keyboardType: TextInputType.emailAddress,
//                         validator: (value) {
//                           if (value!.isEmpty || !value.contains('@')) {
//                             return 'Invalid email!';
//                           }
//                           return null;
//                         },
//                       ),
//                       TextFormField(
//                         controller: _passwordController,
//                         decoration: InputDecoration(labelText: 'Password'),
//                         obscureText: true,
//                         validator: (value) {
//                           if (value!.isEmpty || value.length < 6) {
//                             return 'Password too short!';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       if (_isLoading)
//                         CircularProgressIndicator()
//                       else
//                         ElevatedButton(
//                           child: Text('Register'),
//                           onPressed: () => _register(context),
//                           style: ElevatedButton.styleFrom(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 30.0, vertical: 8.0),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                         ),
//                       TextButton(
//                         child: Text('Login'),
//                         onPressed: () {
//                           Navigator.of(context)
//                               .pushReplacementNamed(LoginScreen.routeName);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
