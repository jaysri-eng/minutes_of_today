import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetInTouch extends StatefulWidget {
  const GetInTouch({super.key});

  @override
  State<GetInTouch> createState() => _GetInTouchState();
}

class _GetInTouchState extends State<GetInTouch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text("Get in touch",style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 20,
        ),),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding( //MediaQuery.of(context).size.width*0.3
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.3,top: 40),
              child: Text("Feedback & support",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.85,
              height: MediaQuery.of(context).size.height*0.2,
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white12,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Share feedback",style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.white,
                        ),),
                        const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,size:15),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rate us",style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.white,
                        ),),
                        const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,size:15),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Contact Support",style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.white,
                        ),),
                        const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,size:15),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.3),
              child: Text("Privacy & Terms Of Use",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.85,
              height: MediaQuery.of(context).size.height*0.13,
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white12,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Privacy & Policy",style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.white,
                        ),),
                        const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,size:15),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Terms of use",style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.white,
                        ),),
                        const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,size:15),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text("Version 0.0.1",style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 15,
            ),)
          ],
        ),
      ),
    );
  }
}
