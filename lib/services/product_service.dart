import 'package:ecommerce_app_eid/application_url/app_url.dart';
import 'package:ecommerce_app_eid/controllers/loginApi_controller.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static ProductService _productService;
  ProductService._internal() {
    _productService = this;
  }

  factory ProductService() => _productService ?? ProductService._internal();

  var _loginApiContriller = LoginApiController;

  Future getAllProducts() async {
    return await http.get(AppUrl.productUrl);
  }

  Future getProductByCategoryOrName(String value) async {
    return await http.get('${AppUrl.searchByCategoryOrNameUrl}$value');
  }

  Future getProductByCategory(String value) async {
    return await http.get('${AppUrl.searchByCategoryUrl}$value');
  }

  Future getProductById(String id) async {
    return await http.get('${AppUrl.productUrl}$id');
  }
}
