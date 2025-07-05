import 'package:androidfirebasepractice/components/button.dart';
import 'package:androidfirebasepractice/components/obscurefield.dart';
import 'package:androidfirebasepractice/components/textfield.dart';
import 'package:androidfirebasepractice/errormessage.dart';
import 'package:androidfirebasepractice/firebaseauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Sign_up extends StatefulWidget {

   const Sign_up({super.key});

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {

GlobalKey<FormState> keystate=GlobalKey<FormState>();
final firebaseauthservise _auth=firebaseauthservise();

   TextEditingController email=TextEditingController();

      TextEditingController password=TextEditingController();

      TextEditingController username=TextEditingController();

@override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    username.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: keystate,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    CircleAvatar(
                      radius: 40,
                      child: Image.asset("assets/images/login.png"),
                      
                    ),
                    const SizedBox(height: 10,),
                    const Center(child: Text("SignUp",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),)),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(alignment: Alignment.topLeft,child: Text('Username',style: TextStyle(fontSize: 20),),),
                     Customtextfield(validator: (p0) {
                       if(p0==""){
                        return "can not be empty";
                       }
                       return null;
                     },obscuretext:false,hinttext: 'Enter your Username',controller: username,),
                    const SizedBox(height: 20,),
                    const Align(alignment: Alignment.topLeft,child: Text('email',style: TextStyle(fontSize: 20),),),
                    Customtextfield(validator: (p0) {
                       if(p0==""){
                        return "can not be empty";
                       }
                       return null;
                     },obscuretext:false,hinttext: 'Enter your email',controller: email,),
                    const SizedBox(height: 20,),
                    const Align(alignment: Alignment.topLeft,child: Text(' password ',style: TextStyle(fontSize: 20),),),
                                      ObscureTextField(validator: (p0) {
                                        
                       if(p0==""){
                        return "can not be empty";
                       }
                       return null;
                     },obscuretext:true,hinttext: 'Enter your password',controller: password,),
              
                    const SizedBox(
                      height: 20,
                    ),
                    
              MaterialButtoncustom(title: 'SignUp', 
              onPressed:_signUp
              )   ,               
                    const SizedBox(
                      height: 20,
                    ),
                    
                    Row(
                      children: [
                        const Text(" have account?",style: TextStyle(fontSize: 16)),
                        TextButton(onPressed: (){
                                   Navigator.of(context).pushReplacementNamed("signin");
              
                        }, child: const Text("Login",style: TextStyle(fontSize: 16)))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
    );
  }

void _signUp() async{
  String usernamec=username.text;
  String emailc=email.text;
  String passwordc=password.text;

  User? user = await _auth.signupwithEmailAndPassword(emailc, passwordc);
  
  if(user!=null){

    Navigator.pushNamedAndRemoveUntil(context, "signin", (route) => false);
  }else{
     showToast(message:"some error happend");
  }
}
}