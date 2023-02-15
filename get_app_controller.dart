import 'dart:convert';
import 'package:get/get.dart';
import 'package:vasundhara_api_2/model/modelclass.dart';
import 'package:http/http.dart'as http;

class GetAppController extends GetxController{
  var model = ModelClass();
  var sub = <SubCategory>[].obs;

  gameListApi()async{
    var response = await http.get(Uri.parse("http://vasundharaapps.com/artwork_apps/api/AdvertiseNewApplications/17/com.latest.status.message.text.jokes.funny"));
    // print("RESPONSE ::::: ${response.body}");

    if(response.statusCode==200) {
      var jsonDecodeResponse = await jsonDecode(response.body);
      model = ModelClass.fromJson(jsonDecodeResponse);
      // print("done");

      for (var i = 0; i < model.appCenter!.length; i++) {
        var subCategoryList = model.appCenter![i].subCategory;
        for (var j = 0; j < subCategoryList!.length; j++) {
          sub.value.add(subCategoryList[j]);
        }
      }

    }
  }


}