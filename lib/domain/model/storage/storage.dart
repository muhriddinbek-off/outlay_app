import 'package:outlay/common/base/base_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';


@lazySingleton
class Storage {
  Storage(this._box);

  final Box _box;

  @FactoryMethod(preResolve: true)
  static Future<Storage> create() async {
    await Hive.initFlutter();
    final box = await Hive.openBox('storage');
    return Storage(box);
  }

  BaseStorage<String> get token => BaseStorage(_box, 'token');

  BaseStorage<bool> get onboarded => BaseStorage(_box, 'onboarded');

}