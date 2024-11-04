import 'package:flutter/foundation.dart';
import 'package:social_media_app/service/model/image_model.dart';
import 'package:dio/dio.dart';

class HomeApiServices {
  Future<QuoteSet> getImages() async {
    try {
      final responce = await Dio().get('https://dummyjson.com/quotes');
      // debugPrint('responce $responce');
      if (responce.statusCode == 200) {
        return QuoteSet.fromJson(responce.data);
      }
    } catch (e) {
      debugPrint('error in getImages $e');
      return QuoteSet(quotes: []);
    }
    return QuoteSet(quotes: []);
  }
}
