import 'package:flutter/widgets.dart';

const String textKey = 'counter_text';
const String fabKey = 'counter_fab';
const String headerKey = 'counter_header';

const String revealHeaderKey = 'reveal_header';
const String revealFirstLoaderKey = 'reveal_first_loader';
const String revealSecondLoaderKey = 'reveal_second_loader';


class GlobalKeyRegistry {
  GlobalKeyRegistry._();
  static final GlobalKeyRegistry _instance = GlobalKeyRegistry._();
  static GlobalKeyRegistry get instance => _instance;

  final _keys = <String, WeakReference<GlobalKey>>{};

  GlobalKey getKey(String key) {
    final weakKey = _keys[key];
    if (weakKey == null) {
      // if the key does not exist, create a new GlobalKey
      final newKey = GlobalKey();
      _keys[key] = WeakReference(newKey);
      return newKey;
    }
    
    // if the key exists, check if it is still valid
    final existingKey = weakKey.target;
    if (existingKey != null) {
      return existingKey;
    }
    
    // if the key is no longer valid, create a new GlobalKey
    final newKey = GlobalKey();
    _keys[key] = WeakReference(newKey);
    return newKey;
  }

  void cleanUp() {
    // Clean up the keys that are no longer valid
    _keys.removeWhere((key, weakKey) => weakKey.target == null);
  }
}