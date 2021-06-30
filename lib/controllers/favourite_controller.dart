import 'package:ecommerce_app_eid/models/favourite_item.dart';
import 'package:ecommerce_app_eid/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FavouriteController extends ChangeNotifier {
  var _favourite = List<FavouriteItem>();
  List<FavouriteItem> get favouritecart => _favourite;

  FavouriteItem _selectedItem = FavouriteItem();
  FavouriteItem get selectedItem => _selectedItem;

  bool _isLoadingProduct = true;
  bool get isLoadingProduct => _isLoadingProduct;

  // bool _isFavourite = false;
  //bool get IsFavourite => _isFavourite;

  void setCurrentItem(Product product) async {
    _isLoadingProduct = true;

    var item = FavouriteItem(product: product);

    if (isItemInFavouriteCart(item)) {
      var foundItem = getFavouriteItem(item);
      _selectedItem = foundItem;
      _isLoadingProduct = false;
      notifyListeners();
    } else {
      _selectedItem = FavouriteItem(product: product);
      _isLoadingProduct = false;
      notifyListeners();
    }
  }

  void addToFavouriteCart(FavouriteItem favouriteItem) {
    favouritecart.add(favouriteItem);
    //_isFavourite = true;

    //notifyListeners();
  }

  bool isItemInFavouriteCart(FavouriteItem favouriteItem) {
    bool isFound = false;
    if (favouritecart.length != 0) {
      for (FavouriteItem item in favouritecart) {
        if (item.product.id == favouriteItem.product.id) {
          isFound = true;
        }
      }
      return isFound;
    }
    return isFound;
  }

  void removeFromFavouriteCart(FavouriteItem favouriteItem) {
    var foundItem;
    if (favouritecart.length != 0) {
      for (FavouriteItem item in favouritecart) {
        if (item.product.id == favouriteItem.product.id) {
          foundItem = item;
        }
      }
      favouritecart.remove(foundItem);
      //_isFavourite = false;

      //notifyListeners();
    }
  }

  FavouriteItem getFavouriteItem(FavouriteItem favouriteItem) {
    var foundItem;
    for (FavouriteItem item in favouritecart) {
      if (item.product.id == favouriteItem.product.id) {
        foundItem = item;
      }
    }
    return foundItem;
  }
}
