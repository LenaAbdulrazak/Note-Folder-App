import 'package:androidfirebasepractice/components/button.dart';
import 'package:androidfirebasepractice/components/obscurefield.dart';
import 'package:androidfirebasepractice/components/textfield.dart';
import 'package:androidfirebasepractice/errormessage.dart';
import 'package:androidfirebasepractice/firebaseauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Sign_in extends StatefulWidget {
   const Sign_in({super.key});

  @override
  State<Sign_in> createState() => _Sign_inState();
}




class _Sign_inState extends State<Sign_in> {

  bool isLoading=false;
  final firebaseauthservise _auth=firebaseauthservise();

TextEditingController email=TextEditingController();

TextEditingController password=TextEditingController();

GlobalKey<FormState> formstate=GlobalKey<FormState> ();
 @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
resizeToAvoidBottomInset: false,
        body: isLoading?const Center(child: CircularProgressIndicator()):  SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: formstate,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              const SizedBox(
                      height: 75,
                    ),CircleAvatar(
                    radius: 40,
                    child: Image.asset("assets/images/login.png"),
                    
                  ),
                  const SizedBox(height: 10,),
                  const Center(child: Text("LOGIN",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),)),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(alignment: Alignment.topLeft,child: Text('Email',style: TextStyle(fontSize: 20),),),
                       Customtextfield(validator: (p0) {
                     if(p0==""){
                      return "can not be empty";
                     }
                     return null;
                   },obscuretext:false,hinttext: 'Enter your Email', controller: email),
                  const SizedBox(height: 20,),
                  const Align(alignment: Alignment.topLeft,child: Text('Password',style: TextStyle(fontSize: 20),),),
                  ObscureTextField(validator: (p0) {

                     if(p0==""){
                      return "can not be empty";
                     }
                     return null;
                   },obscuretext:true,hinttext: 'Enter your password', controller: password),
                  const  Row(
                    children: [
                      Checkbox(value: true, onChanged: null),
                      Text("Remember Me?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                    ],  
                  ),
                       MaterialButtoncustom(title: 'LOGIN', onPressed: 
      
                       _signIn
                     
                       ),
                  Align(alignment: Alignment.bottomRight,child: TextButton(onPressed: (){}, child: InkWell(
                    onTap: ()async {
                      if(email.text==""){
                         showToast(message: "please write your email first then click 'forget password'");
                        return;
                      }
                    try{
               await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
                   showToast(message: "email sent to ur email to reset password");
                    }catch (e){
                    print(e);

                    }
                  
                    },
                    child: const
                     Text('Forget Password?',style: TextStyle(color: Colors.black),),
                  ))),
                  const SizedBox(height: 10,),
                  const Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Divider(thickness: 2,),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(),
                          child: CircleAvatar(
                            radius: 25,
                            child: Text("OR"),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                        },
                        child:MaterialButton(color: Colors.pink.shade200,shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)),onPressed: (){},child: 
     
      SizedBox(
      
        height: 35,
        width: 260,
        child: 
       Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Image.asset('assets/images/google.png',width: 30 ,height: 30,),
         const SizedBox(width: 8,),
         InkWell(onTap: () {
           _signInWithGoogle();
         },child: const Text("sign in with google",style: TextStyle(color: Colors.white,fontSize: 20)))
      ],),)
      // ListTile(leading: Image.asset('assets/images/google.png'),
      // title:const Text("Google") ,)
      )
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text("Don't have account?",style: TextStyle(fontSize: 16),),
                      TextButton(onPressed: (){
                        Navigator.of(context).pushReplacementNamed("signup");
                      }, child: const Text("Register",style: TextStyle(fontSize: 16)))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      
    );
  }
  

 void _signIn() async{


    isLoading=true;
  setState(() {
    
  });
  String emailc=email.text;
  String passwordc=password.text;

  User? user = await _auth.signinwithEmailAndPassword(emailc, passwordc);

 isLoading=false;
  setState(() {
    
  });
  if(user!=null){
    Navigator.pushNamedAndRemoveUntil(context, "homePage", (route) => false);
 
  }else{
     showToast(message:"something went wrong");

  }
   
}

_signInWithGoogle() async{

  final GoogleSignIn googleSignIn=GoogleSignIn();

  try{
    final GoogleSignInAccount? googleSignInAccount=await googleSignIn.signIn();

    if(googleSignInAccount!=null){
      final GoogleSignInAuthentication googleSignInAuthentication=await
      googleSignInAccount.authentication;

      final AuthCredential credential=GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
       await FirebaseAuth.instance.signInWithCredential(credential);
       Navigator.pushNamed(context, "homePage");
    }
  }catch(e){
showToast(message: "some error ocurred $e");
  }
}
}