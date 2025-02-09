import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minutes_of_today/database/databaseHelper.dart';

class ViewMinutes extends StatefulWidget {
  const ViewMinutes({super.key});

  @override
  State<ViewMinutes> createState() => _ViewMinutesState();
}

class _ViewMinutesState extends State<ViewMinutes> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    final dbHelper = DatabaseHelper();
    //final userId = dbHelper.getAnonymousUser();
    return await dbHelper.getPostsByUserToday();
  }
  String formatDateTime(String isoString) {
    DateTime dateTime = DateTime.parse(isoString).toLocal();
    String formattedDate = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    String formattedTime = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";

    return "$formattedDate $formattedTime"; // Outputs "YYYY-MM-DD HH:MM:SS"
  }
  //Education', 'Quotes/motivation', 'Read a book', 'Life lesson
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
            return Center(child: Text("You haven't posted any minutes today!",style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 15,
            ),));
          }
          List<Map<String, dynamic>> posts = snapshot.data!;
          return ListView.builder(
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
                          SizedBox(height: 8),
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
          );
        },
      ),
    );
  }
}

