import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionEdit extends StatefulWidget {
  const DescriptionEdit({super.key});

  @override
  State<DescriptionEdit> createState() => _DescriptionEditState();
}

class _DescriptionEditState extends State<DescriptionEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

           // top four icons ==============================================================================================

            Container(
              margin: const EdgeInsets.only(top: 50),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 197, 197, 197),
                    blurRadius: 2,
                    offset: Offset(0, 3))
              ]),
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("assets/images/backarrow.svg")),
                  Container(
                      margin: const EdgeInsets.only(),
                      child: const Text(
                        "Description",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                  const SizedBox(
                    width: 20,
                    height: 20,
                  )
                ],
              ),
            ),

            // edittext full screen

            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10,right: 10,top: 20),
                child: TextFormField(
                  maxLines: 50,
                  initialValue:"Introducing the Afra. This top sits off your shoulders creating a striking neckline. It has voluminous sleeves that gather and tie at your wrist. Wear yours with a skirt and side-pose to highlight the cutout sides. Featuring back zipper. 100% Polyester, Satin Back Crepe",
              
              
                   style: GoogleFonts.lexendExa(
                    fontSize: 10,
              
                    color: Colors.black
                   ),
                  decoration: const InputDecoration(
              
                  
              
                    border: InputBorder.none,
                    hintText: "Please enter some description"
                  ),
                ),
              ),
            ),



            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 15, right: 15, bottom: 40),
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  width: 220,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child:  Text(
                    "SAVE",
                    style: GoogleFonts.lexendExa(color: Colors.white, fontSize: 15,fontWeight: FontWeight.w300),
                  ),
                ),
            ),


        ],
      ),
    );
  }
}