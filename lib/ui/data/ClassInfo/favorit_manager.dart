import 'package:hive_flutter/hive_flutter.dart';

final favoritmanager = FavoritManager();

class FavoritManager {
  // static const _boxName = 'favorits';
  // final _box = Hive.box<UiProductEntity>(_boxName);

  // static init() async {
  //   await Hive.initFlutter();
  //   // Hive.registerAdapter(ProductEntityAdapter());
  //   Hive.openBox<UiProductEntity>(_boxName);
  // }

  // void addFavorite(UiProductEntity product) {
  //   _box.put(product.id, product);
  // }

  // void delete(UiProductEntity product) {
  //   _box.delete(product.id);
  // }

  // List<UiProductEntity> get favorites => _box.values.toList();

  // bool isFavorite(UiProductEntity product) {
  //   return _box.containsKey(product.id);
  // }
}
