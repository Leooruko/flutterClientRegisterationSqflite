import 'package:flutter/material.dart';
import 'package:francs/screens/client.dart';
import 'package:francs/screens/registeration.dart';

import '../database.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

// DASHBOARD


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {



// Widget List to display on click

 late List<SideMenuItem> items = [

  // SIDEMENU ITEMS
  
  // ITEM 1

  SideMenuItem(
    builder: (context, displayMode) {
    
    return GestureDetector(
      child: Container(
        width: 20,
        height: 50,
        margin:const EdgeInsets.all(10),
        child:const Icon(Icons.dashboard_customize,color: Colors.white,),
      ),
      onTap: () {
      sideMenu.changePage(0);
  },
    );
  },
  
  // ITEM 2

  ),
  // SideMenuItem(
  //   builder: (context, displayMode) {
  //   return GestureDetector(
  //     child: Container(
  //       width: 20,
  //       height: 50,
  //       margin:const EdgeInsets.all(10),
  //       child:const Icon(Icons.work_history_sharp,color: Colors.white,),
  //     ),
  //     onTap: () {
  //     sideMenu.changePage(1);
  //     },
  //    );
  //   },
  // ),

  // ITEM 3

  // SideMenuItem(
  //  builder: (context, displayMode) {
  //   return GestureDetector(
  //     child: Container(
  //       width: 20,
  //       height: 50,
  //       margin:const EdgeInsets.all(10),
  //       child:const Icon(Icons.science,color: Colors.white,),
  //     ),
  //     onTap: () {
  //       // ONTAP TO LOAD  2ND PAGE VIEW

  //     sideMenu.changePage(2);
  //    },
  //   );
  // },
  
   
  // ),

  // SideMenuItem(
  //  builder: (context, displayMode) {
  //   return GestureDetector(
  //     child: Container(
  //       width: 20,
  //       height: 50,
  //       margin:const EdgeInsets.all(10),
  //       child:const Icon(Icons.calendar_month,color: Colors.white,),
  //     ),
  //     onTap: (){
  //       sideMenu.changePage(3);
  //     },
  //   );
  // },
  // onTap: (index,_){
     
  // },
   
  // ),  
];


PageController pageController = PageController();
SideMenuController sideMenu = SideMenuController();

@override
void initState() {
  // Connect SideMenuController and PageController together
  sideMenu.addListener((index) {
    pageController.jumpToPage(index);
  });
  super.initState();
}



@override
Widget build(BuildContext context) {
  return  Scaffold(
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 53,
              child: SideMenu(
                // Page controller to manage a PageView
                controller: sideMenu,
                // Will shows on top of all items, it can be a logo or a Title text
                
                // Will show on bottom of SideMenu when displayMode was SideMenuDisplayMode.open
                style: SideMenuStyle(
                  backgroundColor: Colors.lightBlue,
                  selectedColor: Colors.blue,
                  itemBorderRadius: BorderRadius.zero,
                  compactSideMenuWidth: 50,
                  itemOuterPadding:const EdgeInsets.all(0),
                  iconSize: 24,
                  unselectedIconColor: Colors.white,
                  selectedIconColor: Colors.white70
                ),
                // Notify when display mode changed
                onDisplayModeChanged: (mode) {
                  print(mode);
                },
                // List of SideMenuItem to show them on SideMenu
                items: items,
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                    Container(
                    child:Column(
                      children: [
                        Expanded(child: ClientList()),
                      ],
                    ),                    
                  ),
                  Container(
                    child:const Center(
                      child: Text('SCHEDULES'),
                    ),
                  ),
                  Container(
                    child:const Center(
                      child: Text('LAB'),
                    ),
                  ),
                  Container(
                    child:const Center(
                      child: Text('CALENDAR'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
  );
}
}




class ClientList extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ClientList({Key? key});

  @override
  State<ClientList> createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {


 @override
  void initState() {
    super.initState();
    _refreshclients(); // Call the refresh method when the widget is initialized
  }


bool customer=true;
bool approved=false;
bool pending=false;
List<Map<String, dynamic>> _journals = [];
List<Map<String, dynamic>> _approved = [];
List<Map<String, dynamic>> _pending = [];
List<Map<String, dynamic>> _customer = [];


  void _refreshclients() async {
    final data = await SqlHelper.getItems();
    final approved=await SqlHelper.getApproved();
    final pending=await SqlHelper.getNotApproved();
    setState(() {
      _journals =data ;
      _customer=data;
      _approved=approved;
      _pending=pending;  
        
    });
  }
  




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: TextField(
        //     decoration: InputDecoration(
        //       hintText: 'Search',
        //       icon:const Icon(Icons.search),
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(15),
        //       ),
        //     ),
        //   ),
        // ),
        Row(
          children: [
            Text(' BigEnt',style: TextStyle(fontSize: 50,fontWeight: FontWeight.w500),)
          ],
        ),
        Row(  
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 10,),
            ElevatedButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: ((context) => FarmerRegisteration(
                onRecordAdded:(){
                  setState(() {
                  _refreshclients();  
                  });
                } ,
              ))));
            },
            style:const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
             child:const Row(
              children: [
                Icon(Icons.person_add_alt_1_outlined),
                 Text('New Customer'),
              ],
            ),
            ),
            const SizedBox(width: 30,)
          ],
        ),


         Row(
          mainAxisAlignment: MainAxisAlignment.start,
           children: [
             GestureDetector(
              onTap: (){
                setState(() {
                  customer=true;
                  approved=false;
                  pending=false;
                  _journals=_customer;
                });
                },
               child: Container(
                height: 50,
                margin:const EdgeInsets.only(left:10),
                decoration: BoxDecoration(
                    color: customer ?Colors.white:Colors.grey.shade200,
                    boxShadow:  [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:const Offset(0, 2),
                      ),
                    ],
                ),
                 child: Row(
                  children: [
                    const SizedBox(width: 5,),
                    const Icon(Icons.list,color: Colors.blueGrey,size: 15,),
                    const Text('Customers', style: TextStyle(fontSize: 20,color: Colors.lightBlueAccent)),
                    Container(
                      padding:const EdgeInsets.all(4),
                      decoration:const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent, // Customize the badge color
                      ),
                      child: Text(
                        '${_customer.length}', // You can set the badge text here
                        style:const TextStyle(color: Colors.blue),
                      ),
                    ),
                    
                  ]),
               ),
             ),

             GestureDetector(
               onTap: (){
                setState(() {
                  customer=false;
                  approved=true;
                  pending=false;
                  _journals=_approved;
                });
                },
               child: Container(
                height: 50,
                margin:const EdgeInsets.only(left:5),
                decoration: BoxDecoration(
                    color:approved ? Colors.white: Colors.grey.shade200,
                    boxShadow:  [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:const Offset(0, 2),
                      ),
                    ],
                ),
                 child: Row(
                  children: [
                    const SizedBox(width: 5,),
                    const Icon(Icons.check,color: Colors.green,size: 15,),
                    const Text('Approved', style: TextStyle(fontSize: 20,color: Colors.lightBlueAccent)),
                    Container(
                      padding:const EdgeInsets.all(4),
                      decoration:const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent, // Customize the badge color
                      ),
                      child: Text(
                        '${_approved.length}', // You can set the badge text here
                        style:const TextStyle(color: Colors.green),
                      ),
                    ),
                    
                  ]),
               ),
             ),


             GestureDetector(
               onTap: (){
                setState(() {
                  customer=false;
                  approved=false;
                  pending=true;
                  _journals=_pending;
                  
                });
                },
               child: Container(
                height: 50,
                margin:const EdgeInsets.only(left:5),
                decoration: BoxDecoration(
                    color:pending?Colors.white: Colors.grey.shade200,
                    boxShadow:  [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:const Offset(0, 2),
                      ),
                    ],
                ),
                 child: Row(
                  children: [
                    const SizedBox(width: 5,),
                    Icon(Icons.pending_outlined,color: Colors.red.shade200,size: 15,),
                    const Text('  Pending', style: TextStyle(fontSize: 20,color: Colors.lightBlueAccent)),
                    Container(
                      padding:const EdgeInsets.all(4),
                      decoration:const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent, // Customize the badge color
                      ),
                      child: Text(
                        '${_pending.length}', // You can set the badge text here
                        style: TextStyle(color: Colors.red.shade200),
                      ),
                    ),
                    
                  ]),
               ),
             ),
           ],
         ),
        Expanded(
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(left:10.0,right: 10,bottom: 10,top: 5),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset:const Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _journals.isEmpty ? const Center(child:Text('No records to display')) : DataTable(
                    headingRowColor: MaterialStateProperty.all(const Color.fromARGB(255, 241, 237, 237)),
                    columnSpacing: 30,
                    horizontalMargin: 10,
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Telephone')),
                      DataColumn(label: Text('ecosystem')),
                      DataColumn(label: Text('sub_ecosystem')),
                      DataColumn(label: Text('farm_size')),
                      DataColumn(label: Text(''))
                    ],
                    rows:  List.generate(
                       _journals.length ,
                      (index) {
                        
                        return  DataRow(cells: [
                          DataCell(Text("${_journals[index]['id']}")),
                          DataCell(Text("${_journals[index]['name']}")),
                          DataCell(Text("${_journals[index]['phone']}")),
                          DataCell(Text("${_journals[index]['ecosystem']}")),
                          DataCell(Text("${_journals[index]['sub_ecosystem']}")),
                          DataCell(Text("${_journals[index]['farm_size']}")),
                          DataCell(TextButton(onPressed:(){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=>Client(
                                id: _journals[index]['id'], 
                                name: _journals[index]['name'], 
                                phone: _journals[index]['phone'], 
                                ecosystem: _journals[index]['ecosystem'], 
                                subecosystem: _journals[index]['sub_ecosystem'], 
                                farmsize: _journals[index]['farm_size'],
                                approval: _journals[index]['approved'],
                                refresh: _refreshclients,
                                attatchemnt:_journals[index]['attatchemnt'] ,
                                )
                              )
                            );
                            // _showCustomPopup(context,"${_journals[index]['name']}","${_journals[index]['id']}","${_journals[index]['phone']}");
                          },style:const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.white)),child:const Icon(Icons.open_in_full,size: 10,) ),)
                        ]);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
