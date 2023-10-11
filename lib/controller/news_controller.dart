import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:k_news/api_key.dart';
import 'package:k_news/core/services/services.dart';
import 'package:k_news/model/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:k_news/model/status_enum.dart';

class NewsController extends GetxController {
  List<NewsModel> news = [];

  MyServices service = Get.find();

  RxString currentCountryCode = ''.obs;

  StatusEnum statusEnum = StatusEnum.none;

  getNewsByCountryCode(String code) async {
    try {
      statusEnum = StatusEnum.loading;
      update();
      var response = await http.get(
        Uri.parse(
            'https://newsapi.org/v2/top-headlines?country=$code&apiKey=$apiKey'),
      );
      if (response.statusCode == 200) {
        statusEnum = StatusEnum.success;
        var body = jsonDecode(response.body);
        List<NewsModel> data = body['articles']
            .map(
              (info) => NewsModel.fromJsom(info),
            )
            .cast<NewsModel>()
            .toList();

        log(data.toString());
        news = data;
        update();
      } else {
        statusEnum = StatusEnum.error;
        update();
      }
    } on Exception catch (e) {
      statusEnum = StatusEnum.error;
      update();
    }
  }

  changeCountry(String value) async {
    service.sharedPreferences.setString('code', value);
    currentCountryCode.value = value;
    await getNewsByCountryCode(value);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    String? code = service.sharedPreferences.getString('code');
    if (code == null) {
      currentCountryCode.value = 'eg';
      getNewsByCountryCode('eg');
    } else {
      currentCountryCode.value = code;
      getNewsByCountryCode(code);
    }
    super.onInit();
  }
}
