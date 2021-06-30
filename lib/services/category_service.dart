import 'package:ecommerce_app_eid/application_url/app_url.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  static CategoryService _categoryService;

  CategoryService._internal() {
    _categoryService = this;
  }

  factory CategoryService() => _categoryService ?? CategoryService._internal();

  static var httpClient = http.Client();

  Future getCategories() async {
    return await httpClient.get(AppUrl.categoryUrl);
  }
}
