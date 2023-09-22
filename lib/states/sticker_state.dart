import 'package:flutter/cupertino.dart';
import 'package:sun_stickers/ui/_ui.dart';

import '../data/app_data.dart';
import '../data/models/sticker.dart';
import '../data/models/sticker_category.dart';

class StickerState {
  StickerState._();
  static final _instance = StickerState._();
  factory StickerState() => _instance;

  //Ключи
  GlobalKey<CartScreenState> cartKey = GlobalKey();
  GlobalKey<FavoriteScreenState> favoriteKey = GlobalKey();
  GlobalKey tabKey = GlobalKey();

  //Переменные
  List<StickerCategory> categories = AppData.categories;
  List<Sticker> stickers = AppData.stickers;
  List<Sticker> stickersByCategory = AppData.stickers;
  List<Sticker> get cart => stickers.where((element) => element.cart).toList();
  List<Sticker> get favorite => stickers.where((element) => element.isFavorite).toList();
  ValueNotifier<bool> isLight = ValueNotifier(true);

  //Действия
  Future<void> onCategoryTap(StickerCategory category) async {
    categories.map((e) {
      if (e.type == category.type) {
        e.isSelected = true;
      } else {
        e.isSelected = false;
      }
    }).toList();

    if (category.type == StickerType.all) {
      stickersByCategory = stickers;
    } else {
      stickersByCategory = stickers.where((e) => e.type == category.type).toList();
    }
  }
  Future<void> onIncreaseQuantityTap(Sticker sticker) async {
    sticker.quantity++;
  }
  Future<void> onDecreaseQuantityTap(Sticker sticker) async {
    if (sticker.quantity == 1) return;
    sticker.quantity--;
  }
  Future<void> onAddToCartTap(Sticker sticker) async {
    sticker.cart = true;
    cartKey.currentState?.update();
  }
  Future<void> onRemoveFromCartTap(Sticker sticker) async {
    sticker.cart = false;
    sticker.quantity = 1;
  }
  Future<void> onCheckOutTap() async {
    for (var element in cart) {
      element.cart = false;
      element.quantity = 1;
    }
  }
  Future<void> onAddRemoveFavoriteTap(Sticker sticker) async {
    sticker.isFavorite = !sticker.isFavorite;
    favoriteKey.currentState?.update();
  }

  //Вспомогательные методы
  String stickerPrice(Sticker sticker) {
    return (sticker.quantity * sticker.price).toString();
  }
  double get subtotal {
    double amount = 0.0;
    for (var element in cart) {
      amount = amount + element.price * element.quantity;
    }
    return amount;
  }

}
