// Generic Hive cache service for the CookJar app.
//
// Responsibilities:
//  - Own the single call to Hive.initFlutter().
//  - Register all Hive TypeAdapters.
//  - Open all application boxes.
//  - Expose typed box getters for use by feature-level LocalDataSources.
//  - Provide generic CRUD / read / watch / count helpers so callers do not
//    need to import Hive directly.
//  - Guard every box access behind an initialization check.
//  - Implement idempotent init() — safe to call multiple times.
//
// What this service does NOT do:
//  - It does not hold any recipe-specific or favorites-specific business logic.
//  - It does not read from or write to GetIt internally.
//  - Feature data-sources and repositories receive this service via constructor
//    injection from the service locator.

import 'package:hive_flutter/hive_flutter.dart';

import '../../../models/recipe_details_model.dart';
import '../../../logging/app_logger.dart';
import 'hive_keys.dart';

class HiveService {
  static const String _tag = 'HiveService';

  bool _isInitialized = false;

  // Typed boxes — assigned during init().
  late Box<RecipeModel> _recipesBox;

  // ---------------------------------------------------------------------------
  // Initialization guard
  // ---------------------------------------------------------------------------

  /// Throws [StateError] if [init] has not been called yet.
  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError(
        'HiveService has not been initialized. '
        'Call await getIt<HiveService>().init() during app startup.',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // init
  // ---------------------------------------------------------------------------

  /// Initializes Hive, registers adapters, and opens all boxes.
  ///
  /// Idempotent — subsequent calls are silently ignored.
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      // Initialize Hive with the Flutter path provider.
      await Hive.initFlutter();

      // Register adapters — each must be registered exactly once.
      if (!Hive.isAdapterRegistered(RecipeModelAdapter().typeId)) {
        Hive.registerAdapter(RecipeModelAdapter());
      }

      // Open boxes.
      _recipesBox = await Hive.openBox<RecipeModel>(HiveKeys.recipesBox);

      _isInitialized = true;

      AppLogger.success('Hive initialized and boxes opened', tag: _tag);
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to initialize Hive',
        error: e,
        stackTrace: stackTrace,
        tag: _tag,
      );
      rethrow;
    }
  }

  // ---------------------------------------------------------------------------
  // Typed box getters
  // ---------------------------------------------------------------------------

  /// Strongly-typed box for [RecipeModel] objects.
  Box<RecipeModel> get recipesBox {
    _ensureInitialized();
    return _recipesBox;
  }

  // ---------------------------------------------------------------------------
  // Generic CRUD helpers
  // ---------------------------------------------------------------------------

  /// Stores [value] under [key] in [box].
  Future<void> put<T>(Box<T> box, dynamic key, T value) async {
    await box.put(key, value);
  }

  /// Stores all [entries] in [box].
  Future<void> putAll<T>(Box<T> box, Map<dynamic, T> entries) async {
    await box.putAll(entries);
  }

  /// Returns the value stored under [key], or `null` if absent.
  T? get<T>(Box<T> box, dynamic key) => box.get(key);

  /// Returns a safe snapshot of all values in [box].
  ///
  /// Returns a new [List] so callers cannot mutate the underlying Hive store.
  List<T> getAll<T>(Box<T> box) => box.values.toList();

  /// Deletes the entry under [key] from [box].
  Future<void> delete<T>(Box<T> box, dynamic key) async {
    await box.delete(key);
  }

  /// Deletes all entries whose keys are in [keys].
  Future<void> deleteAll<T>(Box<T> box, Iterable<dynamic> keys) async {
    await box.deleteAll(keys);
  }

  /// Returns `true` if [box] contains [key].
  bool containsKey<T>(Box<T> box, dynamic key) => box.containsKey(key);

  /// Removes all entries from [box].
  Future<void> clear<T>(Box<T> box) async {
    await box.clear();
  }

  /// Returns a raw [Stream<BoxEvent>] for [box].
  ///
  /// Feature-level data sources are responsible for mapping events to
  /// domain types. This layer stays infrastructure-only.
  Stream<BoxEvent> watch<T>(Box<T> box) => box.watch();

  /// Returns the number of entries in [box].
  int count<T>(Box<T> box) => box.length;

  /// Returns `true` when [box] has no entries.
  bool isEmpty<T>(Box<T> box) => box.isEmpty;

  /// Returns `true` when [box] has at least one entry.
  bool isNotEmpty<T>(Box<T> box) => box.isNotEmpty;

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  /// Closes Hive and resets initialization state.
  ///
  /// Safe to call even if [init] was never called.
  Future<void> close() async {
    if (!_isInitialized) return;

    try {
      await Hive.close();
      _isInitialized = false;
      AppLogger.success('Hive closed successfully', tag: _tag);
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to close Hive cleanly',
        error: e,
        stackTrace: stackTrace,
        tag: _tag,
      );
      // Do not rethrow — app shutdown must not be blocked by a Hive close error.
    }
  }
}
