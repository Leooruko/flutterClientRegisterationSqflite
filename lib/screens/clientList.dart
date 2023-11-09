import 'package:flutter/material.dart';
import 'package:francs/database.dart';

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {


   @override
  void initState() {
    super.initState();
    _refreshclients(); // Call the refresh method when the widget is initialized
  }



List<Map<String, dynamic>> _journals = [];


 void _refreshclients() async {
    final data = await SqlHelper.getItems();
    setState(() {
      _journals = data;      
    });
  }


  @override
  Widget build(BuildContext context) {
    return        Expanded(
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
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
                      _journals.length,
                      (index) {
                        return  DataRow(cells: [
                          DataCell(Text("${_journals[index]['id']}")),
                          DataCell(Text("${_journals[index]['name']}")),
                          DataCell(Text("${_journals[index]['phone']}")),
                          DataCell(Text("${_journals[index]['ecosystem']}")),
                          DataCell(Text("${_journals[index]['sub_ecosystem']}")),
                          DataCell(Text("${_journals[index]['farm_size']}")),
                          DataCell(TextButton(onPressed:(){
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
        );
  }
}