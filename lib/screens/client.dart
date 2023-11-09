import 'package:flutter/material.dart';
import 'package:francs/database.dart';
import 'package:francs/screens/update.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class Client extends StatefulWidget {
  final id;
  final name;
  final phone;
  final ecosystem;
  final subecosystem;
  final farmsize;
  final approval;
  final attatchemnt;
  final VoidCallback refresh;

  const Client({Key? key, required this.id,required this.name,required this.phone,required this.ecosystem,required this.subecosystem,required this.farmsize,required this.approval,required this.refresh,required this.attatchemnt}):super(key: key);

  @override
  State<Client> createState() => _ClientState();
}

class _ClientState extends State<Client> {

  
  late bool light1;
  List<Map<String, dynamic>> client = [];
  String? pdfPath;
@override
void initState() {
  

  super.initState();
  if (widget.approval=='true'){
    light1=true;
  }else{
    light1=false;
  }
  client = [
    {'ID': widget.id},
    {'NAME': widget.name},
    {'PHONE': widget.phone},
    {'ECOSYSTEM': widget.ecosystem},
    {'SUB_ECOSYSTEM': widget.subecosystem},
    {'FARM_SIZE': widget.farmsize},
    {'ATTATCHMENT':widget.attatchemnt}
  ];

   pdfPath= widget.attatchemnt=='NULL' ? null : widget.attatchemnt;
}

_refreshClient() async {
  final db = await SqlHelper.db();
  final results = await db.rawQuery('SELECT * FROM clients WHERE id = ?', [widget.id]);

  if (results.isNotEmpty) {
    // The result is a list of maps; you can access the data using results[0]['columnName']
    final clientData = results[0];
    if (mounted) {
      setState(() {
        client = [
          {'ID': clientData['id']},
          {'NAME': clientData['name']},
          {'PHONE': clientData['phone']},
          {'ECOSYSTEM': clientData['ecosystem']},
          {'SUB_ECOSYSTEM': clientData['sub_ecosystem']},
          {'FARM_SIZE': clientData['farm_size']},
          {'ATTATCHMENT': clientData['attatchemnt']}
        ];
        pdfPath = clientData['attatchemnt'] == 'NULL' ? null : (clientData['attatchemnt'] as String?);
      });
    }
  }
  widget.refresh;
}


        // PDF PDEF PDF
          

          Future<void> pickAndStorePDF() async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();

            if (result != null) {
              String? path1 = result.files.single.path; // Make sure path is nullable

              String? SelectedDirectory= await FilePicker.platform.getDirectoryPath();
              if(SelectedDirectory!=null){
                File selectedFile = File(path1!);
                Directory? customDirectory = Directory(SelectedDirectory);
                String fileName = path.basename(selectedFile.path);
                String newPath = path.join(customDirectory.path,fileName);

                await selectedFile.copy(newPath);

                setState(() {
                
                SqlHelper.UpdateAttatchment(widget.id, newPath);
                widget.refresh();
                
              });
              _refreshClient();
              }
              
            } else {
              // User canceled the file selection
            }
          }

                  Future<void> openPDF() async {
                    if (pdfPath != null) {
                      if (await canLaunchUrl(Uri.file(pdfPath!))) {
                        await launchUrl(Uri.file(pdfPath!));
                      } else {
                        // Handle errors
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:Text('PDF not available'),
                        duration: Duration(seconds: 1), ));
                      // PDF path is not available, handle this case
                    }
                  }

                Future<void> deleteFile(String filePath) async {
                    File file = File(filePath);

                    if (await file.exists()) {
                      await file.delete();
                      SqlHelper.UpdateAttatchment(widget.id,'NULL');
                      widget.refresh();
                    }
                    _refreshClient();
                  }


  void _dropdialog(BuildContext context){
      showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            title:Text('ATTATCHMENT',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w200,color: Colors.blue),) ,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [
                  ElevatedButton(onPressed: (){
                    setState(() {
                      deleteFile(widget.attatchemnt);
                       
                    });
                    _refreshClient();
                   Navigator.pop(context);
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('flie deleted'),duration: Duration(seconds: 1),));
                  } , child: Text('DELETE'),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.redAccent))),
                  SizedBox(width: 30,),
                  ElevatedButton(onPressed: (){                    
                    setState(() {
                      deleteFile(widget.attatchemnt);
                      pickAndStorePDF();
                      
                    });
                    _refreshClient();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('flie updated'),duration: Duration(seconds: 1),));
                  } , child: Text('UPDATE'),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.lightGreen)),)
                ],)
              ],
            ),
          );
        });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children:[ Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed:(){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back)),
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                    IconButton(onPressed: (){
                      SqlHelper.delete(widget.id);
                      Navigator.pop(context);
                      setState(() {
                        widget.refresh();
                      });
                    }, icon: Icon(Icons.delete)),
                    IconButton(onPressed: (){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder:(context)=>UpdateFarmer(id: widget.id))
                        
                      );
                       widget.refresh();
                    }, icon: Icon(Icons.edit))
                    ],
                  ),
                SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 150,),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.25),
                          borderRadius: BorderRadius.circular(22)
                        ),
                        child: Icon(Icons.person,size: 300,color: Colors.green.shade100,),
                      ),
                      SizedBox(width: 200,),
                      Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         const Padding(
                            padding:  EdgeInsets.all(16.0),
                            child: Text(
                              'DEMOGRAPHICS',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataTable(
                            columns:const [
                              DataColumn(
                                label: Text('Property'),
                              ),
                              DataColumn(
                                label: Text('Value'),
                              ),
                            ],
                            rows: 
                            List.generate(client.length, (index){ 
                              final property = client[index].keys.first; // Get the property name
                              final value = client[index][property];
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Text(property),
                                  ),
                                  DataCell(
                                    property=='ATTATCHMENT' ? Text('${value.substring(0,4)}..'):Text('$value'),
                                    showEditIcon:property=='ATTATCHMENT' && value!='NULL' ? true :false,
                                    
                                    onTap:() {
                                      if (property == 'ATTATCHMENT' && value != 'NULL') {
                                        _dropdialog(context);
                                      };                                      
                                    }
                                    
                                  ),
                                ],
                              );
                            }
                            ),
                          ),
                          SizedBox(height: 24),
                          Center(
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      pdfPath==null ? pickAndStorePDF():openPDF();
                                      _refreshClient();
                                      widget.refresh;
                                    });
                                    
                                    // Implement file download or viewing logic here
                                    // You can open the file in a new browser window or download it.
                                    // Make sure to use the actual file URL.
                                    // For web apps, you can use the html package for opening URLs.
                                  },
                                  child:pdfPath==null ?Text('Attatch file') : Text('View Attached File'),
                                ),
                                SizedBox(width: 10,),
                                //  ElevatedButton(
                                //   onPressed: () {
                                //     openPDF();
                                //   },
                                //    child: Text('OPEN'),
                                //   style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                          Text('Approval status',style: TextStyle(color: Colors.redAccent,fontSize: 15,decoration: TextDecoration.underline),),
                          SizedBox(width: 20,),
                          Switch(
                            
                            thumbIcon:light1 ? MaterialStatePropertyAll(Icon(Icons.check,color: Colors.green,)) : MaterialStatePropertyAll(Icon(Icons.close,color: Colors.red,)),
                            value: light1, 
                            onChanged: (bool value){
                                setState(() {
                                  light1=value;
                                  SqlHelper.updateApproval(widget.id,light1.toString());
                                  widget.refresh();
                                });
                            },
                            activeTrackColor: Colors.green, // Custom active track color
                            activeColor: Colors.white, // Custom color for the thumb when switch is on
                            inactiveTrackColor: Colors.red, // Custom inactive track color
                            inactiveThumbColor: Colors.white,
                            )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),]
        ),
      ),
    );
  }
}

