import 'package:done_app/services/cache_service/cache_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../constants/hive_constants.dart';
import '../../models/goal_model.dart';

class GoalCacheService extends ICacheService<Goal> { //TODO: CACHE SERVİS DÜZENLENCEK kullanılmayanlar vs çoğu aynı override etmeye gerek yok //habit veya goal eklenirken aynı isimle varsa eklenmicek
  GoalCacheService(super.boxName);

  @override
  Future<void> addItem(item) async {
    await box?.add(item);
  }

  @override
  Future<void> addItems(List<Goal> items) async {
    await box?.addAll(items);
  }

  @override
  Goal? getItem(String key) {
    return box?.get(key);
  }

  @override
  Future<void> putItem(String key, item) async {
    await box?.put(key, item);
  }

  @override
  Future<void> putItems(List<Goal> items) async {
    await box?.putAll(Map.fromEntries(items.map((e) => MapEntry(e.goalTitle, e))));
  }

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.goalTypeId)) {
      Hive.registerAdapter(GoalAdapter());
    }    
    if (!Hive.isAdapterRegistered(HiveConstants.taskTypeId)) {
      Hive.registerAdapter(TaskAdapter());
    }
  }

  @override
  Future<void> removeItem(String key) async {
    await box?.delete(key);
  }

}