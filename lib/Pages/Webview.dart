// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siz/Pages/Wishlist.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview extends StatefulWidget {


  String heading="";
  String link="";
  Webview({super.key,required this.heading,required this.link});

  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {


  late WebViewController controller;

  @override
  void initState() {
    
    super.initState();

    controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://siz.ae/')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse(widget.link));

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
     Scaffold(
      body: Column(
        children: [
           // top four icons ==============================================================================================

          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            padding: const EdgeInsets.only(top: 5, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: ()
                  {

                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset("assets/images/backarrow.svg")),
                Container(
                    margin: const EdgeInsets.only(left: 30),
                    child:  Text(
                      widget.heading,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.horizontal,
                  children: [
                    InkWell(
                      
                       onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Wishlist()));
                      },
                      child: SvgPicture.asset("assets/images/heart.svg")),
                    const SizedBox(width: 20),
                    SvgPicture.asset("assets/images/bag.svg"),
                  ],
                )
              ],
            ),
          ),


          Expanded(
            
            child: WebViewWidget(controller: controller)),

        ],
      ),
     )
    );
  }
}