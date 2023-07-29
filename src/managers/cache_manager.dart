import 'package:mineral_ioc/src/mineral_service.dart';

abstract class CacheManager<T> extends MineralService {
  CacheManager() : super(inject: true);

  Map<String, T> _cache = {};
  Map<String, T> get cache => _cache;
}