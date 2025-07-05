// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:androidfirebasepractice/textfieldforcategories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateCategory extends StatefulWidget {
  String oldname;
  String docid;
  UpdateCategory({
    Key? key,
    required this.oldname,
    required this.docid,
  }) : super(key: key);

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}



TextEditingController name=TextEditingController();
   GlobalKey<FormState> formstate=GlobalKey<FormState>();



  
class _UpdateCategoryState extends State<UpdateCategory> {

     CollectionReference categories = FirebaseFirestore.instance.collection('categories');
bool isLoading=false;
     UpdateCategory() async{
     if(formstate.currentState!.validate()){
      isLoading=true;
      setState(() {
        
      });
      try{
        await categories.doc(widget.docid).update({"name":name.text});
        Navigator.of(context).pushNamedAndRemoveUntil("homePage", (route) => false);
      }catch(e){
        print("error $e");  
      }
     }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text=widget.oldname;
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
                    const Text("change name",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.pink),),
                    const SizedBox(
                      height: 15,
                    ),
                    Customtextfieldcat(hinttext: "Enter The New Name", controller: name, validator:(p0) {
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
                         UpdateCategory();
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