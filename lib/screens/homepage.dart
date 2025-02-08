import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minutes_of_today/screens/getInTouch.dart';
import 'package:minutes_of_today/screens/viewMinutes.dart';
import 'package:minutes_of_today/screens/viewReports.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    ViewMinutes(),
    ViewReports(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void _showAddTodoModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Makes the modal use more space
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add a new To-Do",
                style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close modal on save
                },
                child: Text("Save"),
              ),
              SizedBox(height: 10),
            ],
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
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: GoogleFonts.montserrat(color: Colors.white),
            unselectedLabelStyle: GoogleFonts.montserrat(color: Colors.grey),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            elevation: 0,
            backgroundColor: Colors.black,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.timer, size: 25, color: Colors.white),
                icon: Icon(Icons.timer, size: 20, color: Colors.grey),
                label: 'Your minutes',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.add_chart, size: 25, color: Colors.white),
                icon: Icon(Icons.add_chart, size: 20, color: Colors.grey),
                label: 'Your reports',
              ),
            ],
          ),
          Positioned(
            bottom: 20, // Adjust for alignment
            left: MediaQuery.of(context).size.width / 2 - 30, // Centers the FAB
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: FloatingActionButton(
                mini: false,
                shape: CircleBorder(),
                onPressed: () => _showAddTodoModal(context),
                backgroundColor: Colors.deepPurpleAccent,
                child: Icon(Icons.add, color: Colors.white, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
