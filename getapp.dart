import 'dart:convert';
import 'package:flutter/material.dart';
import 'Controller/get_app_controller.dart';
import 'model/modelclass.dart';
import 'package:http/http.dart'as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class GetApp extends StatefulWidget {
  const GetApp({Key? key}) : super(key: key);

  @override
  State<GetApp> createState() => _GetAppState();
}

class _GetAppState extends State<GetApp> {
  String baseUrl ="https://play.google.com/store/apps/details?id=";

  var subbcontroller = Get.put(GetAppController());


  // var model = modelclass();
  // var sub = <SubCategory>[];



  // gameListApi()async{
  //   var response = await http.get(Uri.parse("http://vasundharaapps.com/artwork_apps/api/AdvertiseNewApplications/17/com.latest.status.message.text.jokes.funny"));
  //   // print("RESPONSE ::::: ${response.body}");
  //
  //   if(response.statusCode==200) {
  //     var jsonDecodeResponse = await jsonDecode(response.body);
  //      model = modelclass.fromJson(jsonDecodeResponse);
  //     // print("done");
  //     setState(() {
  //
  //     });
  //
  //     for (var i = 0; i < model.appCenter!.length; i++) {
  //       var subCategoryList = model.appCenter![i].subCategory;
  //       for (var j = 0; j < subCategoryList!.length; j++) {
  //         sub.add(subCategoryList[j]);
  //       }
  //     }
  //
  //   }
  // }
  //


  @override
  void initState() {
    // TODO: implement initState
    subbcontroller.gameListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("APPS"),),

      body:Obx(() => subbcontroller.sub.value== null
          ?Center(child: CircularProgressIndicator(),)
          :ListView.separated(
          itemCount: subbcontroller.sub.value.length,
          itemBuilder: (context,index){
          return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.7),
                    offset:Offset(0.5,0.5),
                    blurRadius: 12,
                    spreadRadius: 7,
                  )
                ]
            ),
            child: Row(
              children: [
                Image.network(subbcontroller.sub.value![index].icon.toString(),height: 80,width: 80,),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(subbcontroller.sub.value![index].name.toString()),
                      RatingBar.builder(
                        initialRating: double.parse(subbcontroller.sub.value![index].star.toString()),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        ignoreGestures: true,
                        // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),

                      Text(subbcontroller.sub.value![index].installedRange.toString()),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    _launchUrl(appLink: subbcontroller.sub.value![index].appLink);
                  },
                  child: Container(
                    height: 30,
                    width: 85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                    ),
                    child: Center(child: Text("Download")),
                  ),
                ),
              ],
            ),
          );
        }, separatorBuilder: (context,index){return SizedBox(height: 10,);}, ),

      ),

    );
  }

  Future<void> _launchUrl({String? appLink}) async {
    if (!await launchUrl(Uri.parse(baseUrl+appLink!))) {
      throw 'Could not launch $baseUrl+appLink!';
    }
  }


}
