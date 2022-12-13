import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbsproject/model/user.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'Utils.dart';
class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
  }):super(key:key);
  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final items=["Computer Science Engineering","Information Science Engineering","Electrical Engineering","Mechanical Engineering","Chemical Engineering","Civil Engineering"];
  final formKey =GlobalKey<FormState>();
  final emailController =TextEditingController();
  final passwordController =TextEditingController();
  final confirmpasswordController =TextEditingController();
  final nameController=TextEditingController();
  final deptController=TextEditingController();
  final phoneController=TextEditingController();
  bool _toggled=false;
  late String name=nameController.text.trim();
  late String dept=deptController.text.trim();
  String? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
            children: [Center(child: Image.asset("assets/images/img.png")),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Welcome to Book-In-Rit",
                      style: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic
                      ),),
                    SizedBox(height: 10,),
                    Text("Create an account to start booking",
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 16,
                          fontStyle: FontStyle.italic
                      ),),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: emailController,
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: "Email",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(30.0))
                          ),
                        prefixIcon: Icon(Icons.email)
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email)=>
                      email != null && !EmailValidator.validate(email)?
                      'Enter a valid email':
                      null,
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(labelText: "Password",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(30.0))
                          ),
                          prefixIcon: Icon(Icons.password)
                      ),
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value)=>
                      value != null && value.length<6?
                      'Enter min. 6 characters':
                      null,
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: confirmpasswordController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(labelText: "Confirm Password",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(30.0))
                          ),
                          prefixIcon: Icon(Icons.password)
                      ),
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value)=>
                      value != null && value.length<6?
                      'Enter min. 6 characters':
                      confirmpasswordController.text.trim()!=passwordController.text.trim()?
                      'Passwords must match':
                      null,
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: nameController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(labelText: "Name",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(30.0))
                          ),
                          prefixIcon: Icon(Icons.verified_user)
                      ),
                      maxLength: 15,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value)=>
                      value != null && value.length<2?
                      'Enter min. 2 characters':
                      null,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey,width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(30.0),)
                      ),
                      child: SwitchListTile(
                        activeColor: Colors.lightBlue,
                        title: Text("Faculty",style: TextStyle(
                            fontSize: 16,
                          color: Colors.black87
                        ),),
                          value: _toggled, onChanged: (bool value){
                        setState(() =>_toggled=value);
                      }),
                    ),
                    SizedBox(height: 10,),
                    /*TextFormField(
                      controller: deptController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(labelText: "Department",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(30.0))
                          ),
                          prefixIcon: Icon(Icons.home)
                      ),
                    ),*/
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey,width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(30.0),)
                      ),
                      child: DropdownButton<String>(
                          value: value,
                          iconSize: 25,
                          icon: Icon(Icons.expand_circle_down,color: Colors.lightBlue,),
                          hint: Text("  Department"),
                          isExpanded: true,
                          items: items.map(buildMenuItem).toList(),
                          onChanged: (value)=>setState(() =>this.value=value
                          )),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: phoneController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(labelText: "Phone Number",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(30.0))
                          ),
                          prefixIcon: Icon(Icons.phone),
                          prefixText: '+91'
                      ),
                      maxLength: 10,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value)=>
                      value != null && value.length!=10?
                      'Enter 10 Digits':
                      null,
                    ),
                    SizedBox(height: 40,),
                    ElevatedButton.icon(
                      onPressed: signUp,
                      icon: Icon(Icons.arrow_forward,size: 32,),
                      label: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 24),),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                      ),
                    ),
                    SizedBox(height: 15,),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.black,fontSize: 16,
                                fontStyle: FontStyle.italic),
                            text: 'Already have an account?  ',
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap=widget.onClickedSignIn,
                                  text: 'Log in',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Theme.of(context).colorScheme.secondary
                                  )
                              )
                            ]
                        )
                    ),
                    SizedBox(height: 50,),
                  ],
                ),
              ),]
        ),
      ),
    );
  }
  DropdownMenuItem<String> buildMenuItem(String item)=>DropdownMenuItem(value:item,child: Text(item));
  Future signUp() async{
    final isValid =formKey.currentState!.validate();
    if(!isValid) return ;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)=> Center(child: CircularProgressIndicator(),)
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      createUser();
    }
    on FirebaseAuthException catch (e) {
      print (e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route)=>route.isFirst);
  }
  Future createUser() async{
    final docUser=FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid);
    final usernow=UserD(
        id: docUser.id,
        name: name,
        email: usern!.email.toString(),
        accountType: _toggled,
        dept: value!,
      phone:phoneController.text.trim()
    );
    final json=usernow.toJson();
    await docUser.set(json);
  }

}