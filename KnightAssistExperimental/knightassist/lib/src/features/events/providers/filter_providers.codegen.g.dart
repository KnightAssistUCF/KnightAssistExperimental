// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_providers.codegen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredEventsHash() => r'425cbd443fe26c8a026b0f77393090b2b18f32e4';

/// See also [filteredEvents].
@ProviderFor(filteredEvents)
final filteredEventsProvider =
    AutoDisposeFutureProvider<List<EventModel>>.internal(
  filteredEvents,
  name: r'filteredEventsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredEventsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FilteredEventsRef = AutoDisposeFutureProviderRef<List<EventModel>>;
String _$searchedEventsHash() => r'839d218c8272ff4eac73196eb64558f302402ae9';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [searchedEvents].
@ProviderFor(searchedEvents)
const searchedEventsProvider = SearchedEventsFamily();

/// See also [searchedEvents].
class SearchedEventsFamily extends Family<List<EventModel>> {
  /// See also [searchedEvents].
  const SearchedEventsFamily();

  /// See also [searchedEvents].
  SearchedEventsProvider call(
    List<EventModel> filteredEvents,
  ) {
    return SearchedEventsProvider(
      filteredEvents,
    );
  }

  @override
  SearchedEventsProvider getProviderOverride(
    covariant SearchedEventsProvider provider,
  ) {
    return call(
      provider.filteredEvents,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchedEventsProvider';
}

/// See also [searchedEvents].
class SearchedEventsProvider extends AutoDisposeProvider<List<EventModel>> {
  /// See also [searchedEvents].
  SearchedEventsProvider(
    List<EventModel> filteredEvents,
  ) : this._internal(
          (ref) => searchedEvents(
            ref as SearchedEventsRef,
            filteredEvents,
          ),
          from: searchedEventsProvider,
          name: r'searchedEventsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchedEventsHash,
          dependencies: SearchedEventsFamily._dependencies,
          allTransitiveDependencies:
              SearchedEventsFamily._allTransitiveDependencies,
          filteredEvents: filteredEvents,
        );

  SearchedEventsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filteredEvents,
  }) : super.internal();

  final List<EventModel> filteredEvents;

  @override
  Override overrideWith(
    List<EventModel> Function(SearchedEventsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchedEventsProvider._internal(
        (ref) => create(ref as SearchedEventsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filteredEvents: filteredEvents,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<EventModel>> createElement() {
    return _SearchedEventsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchedEventsProvider &&
        other.filteredEvents == filteredEvents;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filteredEvents.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchedEventsRef on AutoDisposeProviderRef<List<EventModel>> {
  /// The parameter `filteredEvents` of this provider.
  List<EventModel> get filteredEvents;
}

class _SearchedEventsProviderElement
    extends AutoDisposeProviderElement<List<EventModel>>
    with SearchedEventsRef {
  _SearchedEventsProviderElement(super.provider);

  @override
  List<EventModel> get filteredEvents =>
      (origin as SearchedEventsProvider).filteredEvents;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
