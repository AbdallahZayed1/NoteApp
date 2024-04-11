import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:path/path.dart';

String _basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'abdu:zombie'));
  
    Map<String, String> myheaders = {
          'authorization': _basicAuth
        };

mixin ManageData {
  
  getrequest(String url) async {
    try {
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("error ${response.statusCode}");
      }
    } catch (e) {
      print("error catch $e");
    }
  }

  postrequest(String url, Map data) async {
    try {
      var response = await post(Uri.parse(url), body: data, headers: myheaders);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("error ${response.statusCode}");
      }
    } catch (e) {
      print("error catch $e");
    }
  }

  postrequestwithfile(String url, Map data, File file) async {
    var request = MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = ByteStream(file.openRead());
    var multipartfile =
        MultipartFile("file", stream, length, filename: basename(file.path));
         request.headers.addAll(myheaders) ; 
    request.files.add(multipartfile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myrequest = await request.send();
    var response = await Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      return jsonDecode(response.body);
    }else{
      print("Error ${myrequest.statusCode}");
    }
  }
}
