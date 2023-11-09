import 'package:flutter/material.dart';
import 'package:francs/database.dart';
import 'package:francs/screens/dashboard.dart';
class UpdateFarmer extends StatefulWidget {

  final int id;
  const UpdateFarmer({super.key,required this.id});

  @override
  State<UpdateFarmer> createState() => _UpdateFarmerState();
}

class _UpdateFarmerState extends State<UpdateFarmer> {


      final nameController=TextEditingController();
      final numberController=TextEditingController();
      final ecosystemController=TextEditingController();
      final sub_ecosystemController=TextEditingController();
      final farmSizeController=TextEditingController();
      String nameLabel='NAME';
      String phoneLabel='PHONE';
      String ecosystemLabel='ECOSYS..';
      String sub_ecosystemlabel='SUBECOSYS..';
      String farm_Size='FARM_SIZE';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
                  padding:const EdgeInsets.all(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        Text('EDIT CLIENT',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w200),)
                      ],
                    ),

                    const SizedBox(height: 50,),

                      // UPDATE NAME
                      Container(
                        height: 35,
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            label: Text(nameLabel),
                            
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
            
                    // UPDATE PHONE
            
                      Container(
                        height: 35,
                        child: TextField(
                          
                          controller: numberController,
                          decoration: InputDecoration(
                            label: Text(phoneLabel,style:const TextStyle(color: Colors.red)),
                            
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        height: 35,
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
                      const SizedBox(height: 20,),
                       Container(
                        height: 35,
                         child: TextField(
                          
                          controller: sub_ecosystemController,
                          decoration: InputDecoration(
                            label: Text(sub_ecosystemlabel,style:const TextStyle(color: Colors.red)),
                            
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                                             ),
                       ),
                      const SizedBox(height: 20,),

                       Container(
                        height: 35,
                         child: TextField(
                          
                          controller: farmSizeController,
                          decoration: InputDecoration(
                            label: Text(farm_Size,style:const TextStyle(color: Colors.red)),
                            
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                                             ),
                       ),
                      const SizedBox(height: 40,),

                      
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(onPressed:(){
            
                            // UPDATE VALIDATION
                            if(numberController.text.length!=10 || ecosystemController.text.isEmpty ||sub_ecosystemController.text.isEmpty || farmSizeController.text.isEmpty|| nameController.text.isEmpty){
                              setState(() {
                                nameLabel=nameController.text.isEmpty ? 'Enter a name' : nameLabel;
                                  phoneLabel=numberController.text.length!=10 ? 'Enter 10 digits': phoneLabel;
                                  ecosystemLabel= ecosystemController.text.isEmpty ? 'enter ecosystem' : ecosystemLabel;
                                  sub_ecosystemlabel= sub_ecosystemController.text.isEmpty ? 'enter sub_ecosystem' : sub_ecosystemlabel;
                                  nameLabel= nameController.text.isEmpty ? 'Enter a name' : '';
                                   try {
                                        int.parse(farmSizeController.text);
                                      } catch (e) {
                                        // Handle the case where farm size is not a valid integer
                                        setState(() {
                                          farm_Size = 'Farm size must be a valid integer';
                                        });
                                   
                                }
                              });
                            }
                            else if(!numberController.text.startsWith('07')){
                              if(!numberController.text.startsWith('01')){
                                setState((){
                                  phoneLabel='Start with 07 or 01';
                                });
                              }
                            }
                            else{                  
                          SqlHelper.updateItem(widget.id,nameController.text,numberController.text,ecosystemController.text,sub_ecosystemController.text,int.parse(farmSizeController.text));
                           setState(() {
                          nameController.text='';
                          numberController.text='';
                          ecosystemController.text=''; 
                          sub_ecosystemController.text=''; 
                          farmSizeController.text='';                  
                          // _refreshclients();
                    });
                          Navigator.push(context,MaterialPageRoute(builder:(context)=>const Dashboard()));
                          }
                          }, 
                          style:const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.green)),
                          child:const Text('UPDATE'),),
                        ],
                      )
                        ],
                      ),
                    ),
    );
                 }
              }



      



     














  //DETAILS DIALOG
// Future<void> _showCustomPopup(BuildContext context, String customerName,String customerId,String customerPhone) async {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//       content: Container(
//         width: 400,
//         child: Card(
//           color: Colors.white70,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text('Client Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               const Divider(thickness: 1),
//               ListTile(
//                 title:const Text('Name:'),
//                 subtitle: Text(customerName),
//                 trailing: IconButton(onPressed: (){
//                   SqlHelper.delete(int.parse(customerId));
//                   setState(() {
//                     _refreshclients();
//                   });
//                   Navigator.of(context).pop();
//                 }, icon:const Icon(Icons.delete_forever,color: Colors.redAccent,),tooltip:'delete'),
//               ),
//               ListTile(
//                 title:const Text('ID:'),
//                 subtitle: Text(customerId),
//                 trailing: IconButton(onPressed: (){
//                   Navigator.of(context).pop();
//                   Navigator.push(context,
//                    MaterialPageRoute(builder:(context)=> UpdateFarmer(id: customerId)));
//                 }, icon:const Icon(Icons.edit,color: Colors.cyan,),tooltip:'edit',),
//               ),
//               const Divider(thickness: 1),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   ElevatedButton(
                    
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Close the dialog
//                     },
//                     child:const Text('Close'),
//                   ),
//                   const SizedBox(width: 10,)
//                 ],
//               ),
//               const SizedBox(height: 10,)
//             ],
//           ),
//         ),
//       ),
//     );

//       },
//     );
//   }