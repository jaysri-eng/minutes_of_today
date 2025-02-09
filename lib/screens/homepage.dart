import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minutes_of_today/database/databaseHelper.dart';
import 'package:minutes_of_today/screens/getInTouch.dart';
import 'package:minutes_of_today/screens/viewAllMinutes.dart';
import 'package:minutes_of_today/screens/viewMinutes.dart';
import 'package:minutes_of_today/screens/viewReports.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedValue;
  List<String> items = ['Education', 'Quotes/motivation', 'Read a book', 'Life lesson'];
  int _selectedIndex = 0;
  TextEditingController mot = TextEditingController();
  TextEditingController option = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const List<Widget> _widgetOptions = <Widget>[
    ViewMinutes(),
    ViewReports(),
    ViewAllMinutes(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void _showAddTodoModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      isScrollControlled: true, // Makes the modal use more space
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height*0.95,
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
              left: 20,
              right: 20,
              top: 0,
            ),
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: (){
                            mot.clear();
                            Navigator.pop(context);
                            },
                          icon: const Icon(Icons.close,color: Colors.white,size: 25,),
                        ),
                        const SizedBox(width: 0,),
                        Text("Add MoT",style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        databaseHelper.insertPost(selectedValue!, mot.text);
                      },
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width*0.15,
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text("Post",style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        ),),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          inputDecorationTheme: const InputDecorationTheme(
                            border: InputBorder.none, // Removes the underline
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: selectedValue,
                          decoration: InputDecoration(
                            labelStyle: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                            //border: OutlineInputBorder(),
                            labelText: "Choose an option",
                          ),
                          selectedItemBuilder: (BuildContext context) {
                            return items.map((String item) {
                              return Text(
                                item,
                                style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w400),
                              );
                            }).toList();
                          },
                          items: items.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item,style: GoogleFonts.montserrat(
                                  fontSize: 15
                              ),),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Theme(
                        data: Theme.of(context).copyWith(
                          inputDecorationTheme: const InputDecorationTheme(
                            border: InputBorder.none, // Removes the underline
                          ),
                        ),
                        child: TextFormField(
                          controller: mot,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(labelText: "What have you learnt?",labelStyle: GoogleFonts.montserrat(
                            color: Colors.grey,
                            fontSize: 13,
                          ),),
                          // validator: (value) => value!.contains('@')
                          //     ? null
                          //     : "Please enter a valid email address",
                          //controller: firstName,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void _showMenuModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      //isScrollControlled: true, // Makes the modal use more space
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height*0.25,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.07,
                    width: MediaQuery.of(context).size.width*0.7,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: TextButton(
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => GetInTouch()));},
                        child: Text("Get in touch with us",style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 15,
                        ),)),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.07,
                    width: MediaQuery.of(context).size.width*0.15,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: (){},
                      icon: const Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextButton(
                  onPressed: (){Navigator.pop(context);},
                  child: Text("Close",style: GoogleFonts.montserrat(
                    color:Colors.white,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1,
                    decorationColor: Colors.white,
                    fontSize: 15,
                  ),),
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _showMenuModal(context),
            icon: const Icon(Icons.menu,color: Colors.white,),
          ),
        ],
        backgroundColor: Colors.black,
        title: Text("MoT",style: GoogleFonts.montserratAlternates(
          color:Colors.white,
        ),),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: GoogleFonts.montserrat(color: Colors.white),
        unselectedLabelStyle: GoogleFonts.montserrat(color: Colors.grey,fontSize:0),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 0,
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.timer, size: 25, color: Colors.white),
            icon: Icon(Icons.timer, size: 25, color: Colors.grey),
            label: 'Your minutes',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.add_chart, size: 25, color: Colors.white),
            icon: Icon(Icons.add_chart, size: 25, color: Colors.grey),
            label: 'Your reports',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.all_inbox_sharp, size: 25, color: Colors.white),
            icon: Icon(Icons.all_inbox_sharp, size: 25, color: Colors.grey),
            label: 'All minutes',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: false,
        shape: CircleBorder(),
        onPressed: () => _showAddTodoModal(context),
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: _widgetOptions[_selectedIndex],
    );
  }
}
