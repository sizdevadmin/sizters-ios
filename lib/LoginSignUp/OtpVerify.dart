// ignore_for_file: must_be_immutable, use_build_context_synchronously, non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:device_information/device_information.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siz/Controllers/ChatController.dart';
import 'package:siz/Controllers/ProfileController.dart';

import 'package:siz/LoginSignUp/BasicLoginInfo.dart';
import 'package:siz/LoginSignUp/LoginPage.dart';

import 'package:siz/Utils/Colors.dart';
import 'package:http/http.dart' as http;
import 'package:siz/Utils/Value.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OTPVerify extends StatefulWidget {
  String email = '';

  OTPVerify({super.key, required this.email});

  @override
  State<OTPVerify> createState() => _OTPVerifyState();
}

class _OTPVerifyState extends State<OTPVerify> {

  late CountdownController controller;
  Map<dynamic, dynamic> otpResult = {};
  Map<dynamic, dynamic> verifyResponse = {};
  TextEditingController otpController = TextEditingController();
  bool showresent = false;
   String deviceName="";


  // initState ==============================================================================================================

  @override
  void initState() {
    // sendotp(widget.countryCode, widget.number);
    sendotp();
    controller = CountdownController(autoStart: true);


   
    super.initState();
  }

  // send otp ================================================================================================================

   void sendotp() async {
    dialodShow();

      
try {
        
     
      String modelName = await DeviceInformation.deviceModel;
      
      setState(() {
        deviceName=modelName;
      });
  
    
      
    } on PlatformException {
    setState(() {
        deviceName="Not Found";
      });
    }


    try { 
      final response = await http.post(Uri.parse(SizValue.loginOTP), body: {
        'code': "971",
        'phone': widget.email,
        'device': deviceName,
      });

    

      otpResult = jsonDecode(response.body);

      print("otp send response ===  "+otpResult.toString());

      if (otpResult["success"] == true) {

       

      Navigator.pop(context);
    
      
        ScaffoldMessenger.of(context)
            .showSnackBar( SnackBar(content: Text("OTP sent successfully",style: GoogleFonts.lexendDeca(fontSize: 13,fontWeight: FontWeight.w300,color: Colors.white)),duration: const Duration(seconds: 1),));
      
       
     
      } else if (otpResult["success"] == false) {
        Navigator.pop(context);
         Navigator.pop(context);
    


        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(otpResult["error"],style: GoogleFonts.lexendDeca(fontSize: 13,fontWeight: FontWeight.w300,color: Colors.white))));
      }

     
    } on ClientException {
      Navigator.pop(context);
      Navigator.pop(context);
      Mysnackbar("Server not responding please try again after sometime");
    } on SocketException {
      Navigator.pop(context);
      Navigator.pop(context);
      Mysnackbar("No Internet connection 😑 please try again after sometime");
    } on HttpException {
      Navigator.pop(context);
      Navigator.pop(context);
      Mysnackbar("Something went wrong please try after sometime");
    } on FormatException {
      Navigator.pop(context);
      Navigator.pop(context);
      Mysnackbar("Something went wrong please try after sometime");
    }
  }


  // snackbar  =================================================================================================================

  Mysnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        
        content: Text(message,style: GoogleFonts.lexendDeca(fontSize: 13,fontWeight: FontWeight.w300,color: Colors.white))));
  }


    // dialog show  =================================================================================================================


  dialodShow() {


    WidgetsBinding.instance.addPostFrameCallback(
        (_) {

          showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: MyColors.themecolor,
            ),
          );
        });
         
          
        },
      );
 
  }


   // verify otp  =================================================================================================================


   
  void verifyOTP(String otp, String token) async {

      final firebaseMessaging = FirebaseMessaging.instance;
      final FCMToken = await firebaseMessaging.getToken();

       SharedPreferences sharedPreferences=await SharedPreferences.getInstance();


    dialodShow();
    try {
      final response = await http.post(Uri.parse(SizValue.loginVerify), body: {
         'otp': otp,
         'token': token,
         'push_token': FCMToken.toString(),
       
      });


       

      verifyResponse = jsonDecode(response.body);

      print("Verify otp ===  "+verifyResponse.toString());

   

      if (verifyResponse["success"] == true) {

        Navigator.pop(context);

       print("LOGIN RESPONSE ==== $verifyResponse");

       if(verifyResponse["account_status"].toString()=="1")
       {
        sharedPreferences.setString(SizValue.mobile, verifyResponse["mobile_no"].toString());
        sharedPreferences.setString(SizValue.userKey, verifyResponse["user_key"].toString());
        sharedPreferences.setString(SizValue.isLogged, "1");
        sharedPreferences.setString(SizValue.source, SizValue.phoneSource);
        sharedPreferences.setString(SizValue.channelId,        verifyResponse["id"].toString());

        
        ChatController chatController=Get.put(ChatController());
        chatController.getProfleValue();
        profileController pController=Get.put(profileController());
        pController.getProfleValue();

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BasicLoginInfo(fromWhere:SizValue.phoneSource)));
       }

       else if(verifyResponse["account_status"].toString()=="2")
       {

        
        sharedPreferences.setString(SizValue.mobile, verifyResponse["mobile_no"].toString());
        sharedPreferences.setString(SizValue.channelId,        verifyResponse["id"].toString());
        sharedPreferences.setString(SizValue.userKey, verifyResponse["user_key"].toString());
        sharedPreferences.setString(SizValue.firstname, verifyResponse["first_name"].toString());
        sharedPreferences.setString(SizValue.lastname, verifyResponse["last_name"].toString());
        sharedPreferences.setString(SizValue.username, verifyResponse["username"].toString());
        sharedPreferences.setString(SizValue.email, verifyResponse["email"].toString());
        sharedPreferences.setString(SizValue.instagramhandle, verifyResponse["instagram"].toString());
        sharedPreferences.setString(SizValue.referral, verifyResponse["referral_code"].toString());
        sharedPreferences.setString(SizValue.bio, verifyResponse["bio"].toString());
         sharedPreferences.setString(SizValue.source, SizValue.phoneSource);
        sharedPreferences.setString(SizValue.profile, verifyResponse["profile"].toString());
        sharedPreferences.setString(SizValue.isLogged, "2");

        ChatController chatController=Get.put(ChatController());
        chatController.getProfleValue();
        profileController pController=Get.put(profileController());
        pController.getProfleValue();

         chatController.onConnectPressed();
         chatController.getChatListOutside(1, "");
         pController. getaccontDetails(context,"2024");


          Navigator.pop(context);

        

       }

       else if(verifyResponse["account_status"].toString()=="3")
       {  

        
        sharedPreferences.setString(SizValue.mobile, verifyResponse["mobile_no"].toString());
        sharedPreferences.setString(SizValue.channelId,        verifyResponse["id"].toString());
        sharedPreferences.setString(SizValue.source, SizValue.phoneSource);
        sharedPreferences.setString(SizValue.underReview,      verifyResponse["id_user_verified"].toString());
        sharedPreferences.setString(SizValue.userKey, verifyResponse["user_key"].toString());
        sharedPreferences.setString(SizValue.firstname, verifyResponse["first_name"].toString());
        sharedPreferences.setString(SizValue.lastname, verifyResponse["last_name"].toString());
        sharedPreferences.setString(SizValue.username, verifyResponse["username"].toString());
        sharedPreferences.setString(SizValue.email, verifyResponse["email"].toString());
        sharedPreferences.setString(SizValue.instagramhandle, verifyResponse["instagram"].toString());
        sharedPreferences.setString(SizValue.referral, verifyResponse["referral_code"].toString());
        sharedPreferences.setString(SizValue.bio, verifyResponse["bio"].toString());
        sharedPreferences.setString(SizValue.profile, verifyResponse["profile"].toString());
        sharedPreferences.setString(SizValue.isLogged, "3");

        ChatController chatController=Get.put(ChatController());
        chatController.getProfleValue();
        profileController pController=Get.put(profileController());
        pController.getProfleValue();



        if( verifyResponse["id_user_verified"].toString()=="1")
        {
          
         chatController.onConnectPressed();
         chatController.getChatListOutside(1, "");
         pController. getaccontDetails(context,"2024");

        }

         Navigator.pop(context);


       }


        
      } else if (verifyResponse["success"] == false) {
        Navigator.pop(context);
        
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(verifyResponse["error"],style: GoogleFonts.lexendDeca(fontSize: 13,fontWeight: FontWeight.w300,color: Colors.white))));
      }

      setState(() {});
    } on ClientException {
      Navigator.pop(context);
      Mysnackbar("Server not responding please try again after sometime");
    } on SocketException {
      Navigator.pop(context);
      Mysnackbar("No Internet connection 😑 please try again after sometime");
    } on HttpException {
      Navigator.pop(context);
      Mysnackbar("Something went wrong please try after sometime");
    } on FormatException {
      Navigator.pop(context);
      Mysnackbar("Something went wrong please try after sometime");
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Column(
          
          children: [

            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top:60,left: 20),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back,color: Colors.black,))),

          


          Expanded(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              
              children: [
          
                 // app icon and text =============================================================================
              Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/appiconpng.png",
                    height: 70,
                    width: 70,
                  )),
              const SizedBox(height: 40),
               Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 40,right: 40),
                 child: Text(
                  "One Time Password has been sent to",
                  style: GoogleFonts.lexendDeca(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w300),
                             ),
               ),
              const SizedBox(
                height: 30,
              ),
          
              // change number text================================================================================
              Container(
                margin: const EdgeInsets.only(left: 40,right: 40),
                child: Row(
                  
                  children: [
                    Expanded(
                      child: Text(
                        
                        "+971-${widget.email}",
                        
                      maxLines: 1,
                          style: GoogleFonts.lexendDeca(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w300),),
                    ),
                    InkWell(
                      onTap: () {
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => LoginPage(email: widget.email,))));
                      },
                      child:  Text(
                        "Change",
                        style: GoogleFonts.lexendDeca(fontSize: 16,color: const Color(0xff4098FF),fontWeight: FontWeight.w300,  decoration: TextDecoration.underline),
                        
                        
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // otp textformfield ===================================================================================
          
              SizedBox(
                width: 160,
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  controller: otpController,
                  autoFocus: true,
          
                  textStyle: GoogleFonts.lexendDeca(fontSize: 16,color: Colors.black,  fontWeight: FontWeight.w300),
                  pinTheme: PinTheme(
                    selectedFillColor: MyColors.themecolor,
                    selectedColor: MyColors.themecolor,
                    activeColor: MyColors.themecolor,
                    inactiveColor: const Color.fromARGB(255, 199, 199, 199),
                    inactiveFillColor: const Color.fromARGB(255, 240, 240, 240),
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 30,
                    activeFillColor: Colors.white,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
          
                  enableActiveFill: true,
          
                  // controller: textEditingController,
                  onCompleted: (v) {
          
            
                     verifyOTP(v.toString(),otpResult["token"].toString());
                   
                  },
                  //  onChanged: (value) {
          
                  //   setState(() {
                  //     // currentText = value;
                  //   });
                  //  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
              ),
          
              // resend otp text ============================================================================
          
              Container(
                margin: const EdgeInsets.only( top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     Text("Didn't receive OTP?",style: GoogleFonts.lexendDeca(fontSize: 16,color: Colors.black,  fontWeight: FontWeight.w300),),
                    Visibility(
                        visible: showresent ? false : true,
                        child:  Text(" wait for" , style: GoogleFonts.lexendDeca(fontSize: 16,color: Colors.black,  fontWeight: FontWeight.w300),)),
                    Visibility(
                        visible: showresent ? true : false,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              showresent = false;
                              controller.start();
                              sendotp();
          
                              
                            });
                          },
                          child:  Text(
                            " RESEND OTP",
                            style: GoogleFonts.lexendDeca(fontSize: 16,color: MyColors.themecolor,  fontWeight: FontWeight.w400)
                          ),
                        )),
                    const SizedBox(
                      width: 2,
                    ),
                    Visibility(
                      visible: showresent ? false : true,
                      child: Countdown(
                        controller: controller,
                        seconds: 30,
                        build: (BuildContext context, double time) => Text(
                          "${time.toString().replaceAll(".0", "")} seconds",
                          style: GoogleFonts.lexendDeca(fontSize: 16,color: MyColors.themecolor,  fontWeight: FontWeight.w300),
                        ),
                        interval: const Duration(seconds: 1),
                        onFinished: () {
                          setState(() {
                            showresent = true;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 100,)
          
              ],
            ),
          )




           
          ],
        ),
      ),
    );
  }
}
