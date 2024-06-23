import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siz/Controllers/FilterController.dart';
import 'package:siz/Pages/Cart.dart';
import 'package:siz/Pages/Wishlist.dart';

class FilterClothesColor extends StatefulWidget {
  const FilterClothesColor({super.key});

  @override
  State<FilterClothesColor> createState() => _FilterClothesColorState();
}

class _FilterClothesColorState extends State<FilterClothesColor> {
   
 


   late FilterController controller;

  @override
  void initState()
  {

    controller=Get.put(FilterController());

   
     getdata();

  
    super.initState();
  }


  getdata() async
  {

     if(!controller.tabbedColor)
    {

       await controller.getcolorData(context,"1");

        // call app
       controller.tabbedColor=true;
       controller.forseUpdate();
    }


  }

 

  



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FilterController(),
      builder: (controller) {
        return Scaffold(
          body:  Column(
           children: [
            // top four icon ===========================

                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 216, 216, 216),
                          blurRadius: 2,
                          offset: Offset(0, 2))
                    ]),
                    padding: const EdgeInsets.only(right: 20, top: 65, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: 50,
                              child: SvgPicture.asset("assets/images/backarrow.svg",width: 20,height: 20,),
                            )),
                        Container(
                            margin: const EdgeInsets.only(left: 30),
                            child: Image.asset(
                              "assets/images/appiconpng.png",
                              width: 40,
                              height: 40,
                            )),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          direction: Axis.horizontal,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  Wishlist()));
                                },
                                child: SvgPicture.asset("assets/images/heart.svg",width: 20,height: 20,)),
                            const SizedBox(width: 20),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Cart()));
                                },
                                child: SvgPicture.asset("assets/images/bag.svg",width: 20,height: 20,)),
                          ],
                        )
                      ],
                    ),
                  ),
// top text and clear text ============================

                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10,bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 40,
                          height: 20,
                        ),
                        Text(
                          'Colors',
                          style: GoogleFonts.dmSerifDisplay(
                            fontWeight: FontWeight.w400,
                              fontSize: 20, color: Colors.black),
                        ),
                        InkWell(
                          onTap: () {
                           
                          },
                          child: InkWell(
                            onTap: () {
                              controller.tabbedColor=false;
                              controller.colorListMultiple.clear();
                              controller.forseUpdate();
                              Navigator.pop(context);
                            },
                            child:  Text(
                              "Clear",
                              style: GoogleFonts.lexendDeca(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w300),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  

                  // body ====================================


   Expanded(
            child: Stack(
              children: [
                
                DynamicHeightGridView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.colorList.length,
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    builder: (context, index) {
                      return Center(
                        child: InkWell(
                          splashFactory: NoSplash.splashFactory,
                          splashColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              if(controller.colorListMultiple.contains(controller.colorList[index]))
                              {
                                int found=controller.colorListMultiple.indexWhere((element) => element==controller.colorList[index]);
                                controller.colorListMultiple.removeAt(found);

                                controller.forseUpdate();
                                
                              }

                              else
                              {
                                controller.colorListMultiple.add(controller.colorList[index]);
                                controller.forseUpdate();
                              }
                            });
                          },
                          child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    margin: EdgeInsets.only(top: 5),
                                     decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: 
                                               Color(int.parse( "0xff${controller.colorList[index]['outline']}")),
                                              spreadRadius: 2)
                                        ],
                                        color:  Color(int.parse( "0xff${controller.colorList[index]['code']}")),
                                        shape: BoxShape.circle),
                                  ),


                                   Visibility(
                                    visible:    controller.colorList[index]["name"].toString()=="Other"? true : false,
                                    // visible: true,

                                    child: SvgPicture.asset("assets/images/questionmark.svg",height: 25,width: 25,)),
          
                                  Visibility(
                                    visible: controller.colorListMultiple.contains(controller.colorList[index])? true:false,
                                    child: SvgPicture.asset("assets/images/tick.svg",height: 25,width: 25,))
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                controller.colorList[index]["name"].toString(),
                                style: GoogleFonts.lexendDeca(
                                    color: Colors.black,fontWeight: FontWeight.w300 ,fontSize: 13),
                              )
                            ],
                          ),
                        ),
                      );
                    }),


              ],
            ),
          ),



                  InkWell(
                    onTap: () {
                       

                     
                      // controller.updateColor(item[controller.colorIndex]['name'].toString(),controller.colorIndex);
                      Navigator.pop(context);
                     
                    },
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(right: 15,left: 15, bottom: 30,top: 10),
                      
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.black),
                      child:  Text(
                        "APPLY FILTER",
                        style: GoogleFonts.lexendExa(color: Colors.white,fontWeight: FontWeight.w300, fontSize: 18),
                      ),
                    ),
                  ),

           ],

          ) 
          ,
        );
      }
    );
  }
}