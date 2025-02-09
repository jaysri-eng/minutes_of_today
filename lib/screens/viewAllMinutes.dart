import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../database/databaseHelper.dart';

class ViewAllMinutes extends StatefulWidget {
  const ViewAllMinutes({super.key});

  @override
  State<ViewAllMinutes> createState() => _ViewAllMinutesState();
}

class _ViewAllMinutesState extends State<ViewAllMinutes> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController search = TextEditingController();
  String? selectedValue;
  List<String> items = ['Education', 'Quotes/motivation', 'Read a book', 'Life lesson'];

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    final dbHelper = DatabaseHelper();
    //final userId = dbHelper.getAnonymousUser();
    return await dbHelper.getAllPostsOfUser();
  }
  String formatDateTime(String isoString) {
    DateTime dateTime = DateTime.parse(isoString).toLocal();
    String formattedDate = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    String formattedTime = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";

    return "$formattedDate $formattedTime"; // Outputs "YYYY-MM-DD HH:MM:SS"
  }
  Color getColorForOption(String? option) {
    switch (option) {
      case 'Education':
        return Colors.blue; // Example: Blue for Education
      case 'Quotes/motivation':
        return Colors.orange; // Example: Orange for Motivation
      case 'Read a book':
        return Colors.green; // Example: Green for Book Reading
      case 'Life lesson':
        return Colors.purple; // Example: Purple for Life Lessons
      default:
        return Colors.grey; // Default color if option is null or unrecognized
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No posts available.",style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 15,
            ),));
          }
          List<Map<String, dynamic>> posts = snapshot.data!;
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          inputDecorationTheme: const InputDecorationTheme(
                            border: InputBorder.none, // Removes the underline
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(left: 5),
                          height: MediaQuery.of(context).size.height*0.05,
                          width: MediaQuery.of(context).size.width*0.7,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: search,
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(labelText: "Search...",labelStyle: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: 15,
                            ),),
                            // validator: (value) => value!.contains('@')
                            //     ? null
                            //     : "Please enter a valid email address",
                            //controller: firstName,
                          ),
                        ),
                      ),
                      Theme(
                        data: Theme.of(context).copyWith(
                          inputDecorationTheme: const InputDecorationTheme(
                            border: InputBorder.none, // Removes the underline
                          ),
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.05,
                          width: MediaQuery.of(context).size.width*0.2,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonFormField<String>(
                            //alignment: AlignmentDirectional.center,
                            icon: const SizedBox.shrink(),
                            isExpanded: true,
                            value: selectedValue,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),
                              //floatingLabelAlignment: FloatingLabelAlignment.center,
                              labelStyle: GoogleFonts.montserrat(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                              //border: OutlineInputBorder(),
                              labelText: "Filter",
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
                                    fontSize: 13
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
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.08),
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final post = posts[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      padding: const EdgeInsets.all(12),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height*0.9,
                            width: 2,
                            decoration: BoxDecoration(
                              color: getColorForOption(post['option']),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post['option'] ?? 'No Title',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  child: Text(
                                    post['content'] ?? 'No Content',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: Colors.white,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                                Text(
                                  "Posted on: ${formatDateTime(post['created_at'])}",
                                  style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
