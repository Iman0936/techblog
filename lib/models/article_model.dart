// models/article_model.dart
import 'package:techblog/component/constant/api_constant.dart';

class ArticleModel {
  final String id;
  final String title;
  final String image;
  final String catId;
  final String catName;
  final String author;
  final String view;
  final String status;
  final String createdAt;

  ArticleModel({
    required this.id,
    required this.title,
    required this.image,
    required this.catId,
    required this.catName,
    required this.author,
    required this.view,
    required this.status,
    required this.createdAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id']?.toString() ?? '0',
      title: json['title']?.toString() ?? 'بدون عنوان',
      image:
          '${ApiUrlConstant.hostDlUrl}${json['image']?.toString() ?? 'default.jpg'}',
      catId: json['cat_id']?.toString() ?? '0',
      catName: json['cat_name']?.toString() ?? 'دسته‌بندی نامشخص',
      author: json['author']?.toString() ?? 'ناشناس',
      view: json['view']?.toString() ?? '0',
      status: json['status']?.toString() ?? '0',
      createdAt: json['created_at']?.toString() ?? 'نامشخص',
    );
  }
}
