// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:androidfirebasepractice/notes/updatenote.dart';
import 'package:androidfirebasepractice/textfieldforcategories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class NotesView extends StatefulWidget {
final String CategoryID;
final String directoryname;
  const NotesView({
    Key? key,
    required this.CategoryID,
    required this.directoryname,
  }) : super(key: key);

  @override
  State<NotesView> createState() => _Home_pageState();
}

class _Home_pageState extends State<NotesView> {
  
  GlobalKey<FormState> formstate=GlobalKey<FormState>();
   TextEditingController title=TextEditingController();
   TextEditingController body=TextEditingController();
   bool isLoading=true;
  List<QueryDocumentSnapshot> data=[];
   getdata()async{
  QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("categories").doc(widget.CategoryID).collection("notes").get();
  data.addAll(querySnapshot.docs);
  
  setState(() {
         isLoading=false;

  });
}
 
  addCategory() async {
  CollectionReference collectionnotes = FirebaseFirestore.instance.collection('categories').doc(widget.CategoryID).collection("notes");

  if (formstate.currentState!.validate()) {
     isLoading = true; // Start loading indicator
    setState(() {
     
    });

    try {
      // Perform asynchronous operation
      DocumentReference response = await collectionnotes.add({"name": title.text,"body":body.text});
      // Close the bottom sheet
      Navigator.of(context).pop();
      isLoading = false; 
      setState(() {



        
        // Turn off loading indicator
      });
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) {
     return NotesView(CategoryID: widget.CategoryID,directoryname: widget.directoryname,);
     },));
    } catch (e) {
      // Handle errors
      print("error $e");
    }
  }
}

@override
  void initState() {
      getdata();
    super.initState();
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                    const Text("Add Note",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.pink),),
                    const SizedBox(
                      height: 15,
                    ),
                    Customtextfieldcat(hinttext: "Add Title", controller: title, validator:(p0) {
                      if(p0==""){
                        return "Can't be Empty";
                      }
                      return null;
                    },
                    
                    ),
                    const SizedBox(
                      height: 8,
                    ),
   
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            maxLines:null,
            controller: body,
        validator:(p0) {
                       if(p0==""){
                          return "Can't be Empty";
                        }
                        return null;
        },
        decoration: const InputDecoration(hintText: "Write note Body",),
          ),
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
    title:  Text(widget.directoryname),
    actions: [IconButton(onPressed: (){
      GoogleSignIn googleSignIn=GoogleSignIn();
      googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
  Navigator.pushNamedAndRemoveUntil(context,"signin", (route) => false);}, icon: const Icon(Icons.exit_to_app)),]
      ),
      body:    data.isEmpty?Container(
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
      ):
      WillPopScope(child: 
      isLoading? const Center(child: CircularProgressIndicator()):
    ListView.builder(itemCount: data.length, itemBuilder:(context, index) {
      return InkWell(
        onLongPress: () {
          showDialog(context: context, builder:(context) {
           return  AlertDialog(title: const Text("warning",style:TextStyle(fontSize: 30,color: Colors.red) ,),content: const Text("do you want to delete note?",style:TextStyle(fontSize: 16),),actions: [TextButton(onPressed:() {
             FirebaseFirestore.instance.collection('categories').doc(widget.CategoryID).collection('notes').doc(data[index].id).delete();
            
           Navigator.of(context).pop();

           
             
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) {
     return NotesView(CategoryID: widget.CategoryID,directoryname: widget.directoryname,);
     },));
           }, child:const Text("Yes",style:TextStyle(fontSize: 16,color: Colors.red))),TextButton(onPressed: (){

                         Navigator.of(context).pop();
                         

           }, child: const Text("No",style:TextStyle(fontSize: 16,color: Colors.black)))],);
          },);
        },
        child: Card(
          child: 
          InkWell(
             onTap: () {
              print(body.text);
            showDialog(context: context, builder:(context) {
              return  Dialog(shape:Border.all(style: BorderStyle.none),child: SizedBox(
                
                width:350,
                height: 350,
                child:Column(
                  mainAxisAlignment:MainAxisAlignment.start ,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(data[index]['body'],style: Theme.of(context).textTheme.bodySmall,),

                    )
                  ],
                ) ,
              ),) ;
            },);
          },
            child: Container(
              
              padding: const EdgeInsets.all(10),child: 
              Row(
               children: [
                 SizedBox(
                  width: 380,
                   child: ListTile(leading:  
                   const CircleAvatar (radius: 23,backgroundImage: AssetImage("assets/images/notepad.png",),
                     backgroundColor: Colors.transparent, ),
                        
                     title: Text("${data[index]['name']}",style: Theme.of(context).textTheme.bodySmall),
                     trailing: IconButton(onPressed: ()
                        
                        {
                        showModalBottomSheet(context: context, builder:(context) {
                          return Updatenote(oldBody:data[index]['body'] ,pagetitlename: widget.directoryname,oldname: data[index]['name'],docid: data[index].id,cateogoryid:widget.CategoryID);
                        },);
                         
                         }, icon: const Icon(Icons.edit)),),
                 ),
               ],
              )),
          ),
        ),
      );
    },), onWillPop: (){
      Navigator.of(context).pushNamedAndRemoveUntil("homePage", (route) => false);
      return Future.value(false);

    })
    );
  }
}