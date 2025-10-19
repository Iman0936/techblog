import 'package:techblog/component/api_constant.dart';

class PosterModel {
  String? id;
  String? title;
  String? image;

  PosterModel({this.id, this.title, this.image});

  PosterModel.fromJson(Map<String, dynamic> element) {
    id = element["id"];
    image = ApiConstant.hostDLUrl + element["image"];
    title = element["title"];
  }
}
