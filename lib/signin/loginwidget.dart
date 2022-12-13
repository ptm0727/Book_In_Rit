import 'package:dbsproject/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'Utils.dart';
class Signin extends StatefulWidget {
 final VoidCallback onClickedSignup;

  const Signin({
    Key? key,
    required this.onClickedSignup,
}):super(key:key);

  @override
  State<Signin> createState() => _Signin();
}

class _Signin extends State<Signin> {
  final emailController =TextEditingController();
  final passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Stack(
          children: [Center(child: Image.asset("assets/images/img.png")),
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: MediaQuery.of(context).size.height/4,),
              Text("Welcome Back!",
              style: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.italic
              ),),
              SizedBox(height: 10,),
              Text("Sign In to start booking",
                style: TextStyle(
                  color: Colors.lightBlue,
                    fontSize: 16,
                    fontStyle: FontStyle.italic
                ),),
              SizedBox(height: 20,),
              TextField(
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
              ),
              SizedBox(height: 20,),
              TextField(
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
              ),
              SizedBox(height: 20,),
              ElevatedButton.icon(
                  onPressed: signIn,
                  icon: Icon(Icons.lock_open,size: 32,),
                  label: Text(
                      "Log In",
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
                    text: 'No account?  ',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap=widget.onClickedSignup,
                        text: 'Sign up',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.secondary
                        )
                      )
                    ]
                  )
              )
            ],
          ),]
        ),
      ),
    );

  }
  Future signIn() async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)=> Center(child: CircularProgressIndicator(),)
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    }
    on FirebaseAuthException catch (e) {
      print (e);
    Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route)=>route.isFirst);
  }

}