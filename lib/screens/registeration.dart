import 'package:francs/database.dart';
import 'package:flutter/material.dart';

class FarmerRegisteration extends StatefulWidget {
  final Function onRecordAdded;
  const FarmerRegisteration({super.key,required this.onRecordAdded});

  @override
  State<FarmerRegisteration> createState() => _FarmerRegisterationState();
}

class _FarmerRegisterationState extends State<FarmerRegisteration> {
  
  final nameController=TextEditingController();
  final numberController=TextEditingController();
  final ecosystemController=TextEditingController();
  final sub_ecosystemController=TextEditingController();
  final farm_sizeController=TextEditingController();
  String nameLabel='NAME';
  String phoneLabel='PHONE';
  String ecosystemLabel='ECOSYS..';
  String sub_ecosystemlabel='SUB_ECOSYS..';
  String farm_sizelabel='FARM_SIZE';




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding:const EdgeInsets.all(20),
            width:MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:  SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon:const Icon(Icons.arrow_back))
                    ],),

                    const Row(
                      children: [
                        Text('REGISTER CLIENT',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w200),)
                      ],
                    ),

                    const SizedBox(height: 30,),
                    Container(
                      height: 30,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          label: Text(nameLabel,style:const TextStyle(color: Colors.red),),
                          
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
          
          
                    Container(
                      height: 30,
                      child: TextField(
                        controller: numberController,
                        decoration: InputDecoration(
                          label: Text(phoneLabel,style:const TextStyle(color: Colors.red),),
                          
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
          
                    Container(
                      height: 30,
                      child: TextField(
                        controller: ecosystemController,
                        decoration: InputDecoration(
                          label: Text(ecosystemLabel,style:const TextStyle(color: Colors.red),),
                          
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
          
                     Container(
                      height: 30,
                       child: TextField(
                        controller: sub_ecosystemController,
                        decoration: InputDecoration(
                          label: Text(sub_ecosystemlabel,style: const TextStyle(color: Colors.red),),
                          
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                                         ),
                     ),
                    const SizedBox(height: 10,),
          
          
                     Container(
                      
                      height: 30,
                       child: TextField(
                        controller: farm_sizeController,
                        decoration: InputDecoration(
                          
                          label: Text(farm_sizelabel,style:const TextStyle(color: Colors.red),),
                          
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                                         ),
                     ),
                    const SizedBox(height: 30,),
          
          
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(onPressed:(){
                          if(numberController.text.length!=10 || ecosystemController.text.isEmpty ||sub_ecosystemController.text.isEmpty || farm_sizeController.text.isEmpty|| nameController.text.isEmpty){
                                setState(() {
                                  nameLabel=nameController.text.isEmpty ? 'Enter a name' : nameLabel;
                                  phoneLabel=numberController.text.length!=10 ? 'Enter 10 digits': phoneLabel;
                                  ecosystemLabel= ecosystemController.text.isEmpty ? 'enter ecosystem' : ecosystemLabel;
                                  sub_ecosystemlabel= sub_ecosystemController.text.isEmpty ? 'enter sub_ecosystem' : sub_ecosystemlabel;
                                  nameLabel= nameController.text.isEmpty ? 'Enter a name' : '';
                                   try {
                                        int.parse(farm_sizeController.text);
                                      } catch (e) {
                                        // Handle the case where farm size is not a valid integer
                                        setState(() {
                                          farm_sizelabel = 'Farm size must be a valid integer';
                                        });
                                   
                                }});
                              }
                              else if(!numberController.text.startsWith('07')){
                                if(!numberController.text.startsWith('01')){
                                  setState((){
                                    phoneLabel='Start with 07 or 01';
                                  });
                                }else{
                          SqlHelper.createItem(nameController.text,numberController.text,ecosystemController.text,sub_ecosystemController.text,int.parse(farm_sizeController.text));
                          setState(() {
                            nameController.text='';
                            numberController.text='';
                            ecosystemController.text='';
                            sub_ecosystemController.text='';
                            farm_sizeController.text='';
          
                            widget.onRecordAdded();
                          });}
                              }
                        }, 
                        style: ButtonStyle(backgroundColor:const MaterialStatePropertyAll(Colors.green),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),)),
                        minimumSize:const MaterialStatePropertyAll(Size(100, 35))
                        ),
                        child:const Text('SAVE'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            
          ),
      ),
    );
  }
}






  
 