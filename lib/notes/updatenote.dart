// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:androidfirebasepractice/notes/view.dart';
import 'package:androidfirebasepractice/textfieldforcategories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Updatenote extends StatefulWidget {
  String cateogoryid;
  String oldname;
  String oldBody;
  String docid;
  String pagetitlename;
  Updatenote({
    Key? key,
    required this.cateogoryid,
    required this.oldname,
    required this.oldBody,
    required this.docid,
    required this.pagetitlename,
  }) : super(key: key);

  @override
  State<Updatenote> createState() => _UpdateCategoryState();
}



TextEditingController title=TextEditingController();
TextEditingController body=TextEditingController();
 GlobalKey<FormState> formstate=GlobalKey<FormState>();



  
class _UpdateCategoryState extends State<Updatenote> {
bool isLoading=true;  


     UpdateCategory() async{
CollectionReference categories = FirebaseFirestore.instance.collection('categories').doc(widget.cateogoryid).collection("notes");//to add category insize a dictionary
     if(formstate.currentState!.validate()){
      // isLoading=false;
      // setState(() {
      // });
      try{
        await categories.doc(widget.docid).update({"name":title.text,"body":body.text});
        setState(() {
          isLoading=false;
        });
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) {
     return NotesView(CategoryID: widget.cateogoryid,directoryname:widget.pagetitlename ,);
     },));
      }catch(e){
        print("errorssssss $e");  
      }
     }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title.text=widget.oldname;
    body.text=widget.oldBody;
  }
  @override
  Widget build(BuildContext context) {
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
                    const Text("Change Name",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.pink),),
                    const SizedBox(
                      height: 15,
                    ),
                    Customtextfieldcat(hinttext: "Enter New Title", controller: title, validator:(p0) {
                      if(p0==""){
                        return "Can't be Empty";
                      }
                      return null;
                    },
                    
                    ),
                    const SizedBox(
                      height: 15,
                    ),
            Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            controller: body,
                        maxLines:null,
        validator:(p0) {
                       if(p0==""){
                          return "Can't be Empty";
                        }
                        return null;
        },
        decoration: const InputDecoration(hintText: "Write note Body",label: Text("body")),
          ),
        ),
                    MaterialButton(onPressed: (){
                         UpdateCategory();
                         Navigator.of(context).pop;
                         print(widget.cateogoryid);

                    },child: Container(width: 150,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.pink.shade400,),child: const Text("Change",textAlign: TextAlign.center,
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
  }
}