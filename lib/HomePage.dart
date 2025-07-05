import 'dart:io';

import 'package:androidfirebasepractice/notes/view.dart';
import 'package:androidfirebasepractice/textfieldforcategories.dart';
import 'package:androidfirebasepractice/updateCatgory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Home_page extends StatefulWidget {

   const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
  
}
class _Home_pageState extends State<Home_page> {
  getToken()async{
String?myToken=await FirebaseMessaging.instance.getToken();
print("=========================");
print(myToken);
print("=========================");

  }
  File?file;


  List<QueryDocumentSnapshot> data=[];
  bool isLoading=true;
  
   getdata()async{
  QuerySnapshot querySnapshot=await FirebaseFirestore.instance.collection("categories").where("id",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
  data.addAll(querySnapshot.docs);
  isLoading=false;
  setState(() {
    
  });
}
   GlobalKey<FormState> formstate=GlobalKey<FormState>();
   TextEditingController add=TextEditingController();
   CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  addCategory() async{
     if(formstate.currentState!.validate()){
      isLoading=true;
      setState(() {
        
      });
      try{
        DocumentReference response=await categories.add({"name":add.text, "id":FirebaseAuth.instance.currentUser!.uid});
        Navigator.of(context).pushNamedAndRemoveUntil("homePage", (route) => false);
      }catch(e){
        print("error $e");  
      }
     }
  }
@override
  void initState() {
      getdata();
      getToken();
    super.initState();
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      floatingActionButton: Padding(padding: const EdgeInsets.only(top: 0,right: 0,left: 0,bottom: 15),
      child: FloatingActionButton(child: const Icon(Icons.add,color: Colors.black,),onPressed: (){
        showModalBottomSheet(context: context, builder:(context) {
        return SingleChildScrollView(
          child: Container(
             padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
            child: Form(
              key:formstate ,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text("Add Category",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.pink),),
                    const SizedBox(
                      height: 15,
                    ),
                    Customtextfieldcat(hinttext: "Add Category", controller: add, validator:(p0) {
                      if(p0==""){
                        return "Can't be Empty";
                      }
                      return null;
                    },
                    
                    ),
                    const SizedBox(
                      height: 15,
                    ),
        
                    MaterialButton(onPressed: (){
                        addCategory();
    
                    },child: Container(width: 150,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.pink.shade400,),child: const Text("Add",textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),)),)
                   ],
                ),
              ),
            ),
          ),
        );
      },);}),) ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        centerTitle: true,
    title: const Text("home page"),
    actions: [IconButton(onPressed: (){
      GoogleSignIn googleSignIn=GoogleSignIn();
      googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
  Navigator.pushNamedAndRemoveUntil(context, "signin", (route) => false);}, icon: const Icon(Icons.exit_to_app)),]
      ),
      body:data.isEmpty?Container(
        alignment: Alignment.center,
        child: const Column(
        
      
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Image(image:AssetImage("assets/images/emptyfolder.png")) ,
            SizedBox(height: 10,),
             Text("page is empty",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
          ],
        ),
      ): isLoading? const Center(child: CircularProgressIndicator()):
    GridView.builder(itemCount: data.length,gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 210), itemBuilder:(context, index) {
      return InkWell(
        onLongPress: () {
          showDialog(context: context, builder:(context) {
           return  AlertDialog(title: const Text("warning",style:TextStyle(fontSize: 30,color: Colors.red) ,),content: const Text("do you want to delete folder?",style:TextStyle(fontSize: 16),),actions: [TextButton(onPressed:() {
             FirebaseFirestore.instance.collection('categories').doc(data[index].id).delete();
             Navigator.of(context).pushNamedAndRemoveUntil("homePage", (route) => false);
           }, child:const Text("Yes",style:TextStyle(fontSize: 16,color: Colors.red))),TextButton(onPressed: (){
                         Navigator.of(context).pop();

           }, child: const Text("No",style:TextStyle(fontSize: 16,color: Colors.black)))],);
          },);
        },
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder:(context) {
              return NotesView(CategoryID: data[index].id,directoryname:data[index]['name'] );
            },));
          },
          child: Card(
            child: 
            Container(
              height: 500,
              padding: const EdgeInsets.all(10),child: Column(
              children: [
                Image.asset("assets/images/folder.png",height: 100,),
                 Text("${data[index]['name']}",style: Theme.of(context).textTheme.bodySmall),
                 IconButton(onPressed: ()
                 
                 {
                 showModalBottomSheet(context: context, builder:(context) {
                   return UpdateCategory(oldname: data[index]['name'],docid: data[index].id,);
                 },);
                  
                  }, icon: const Icon(Icons.edit))
              ],
            )),
          ),
        ),
      );
    },)
    );
  }
}