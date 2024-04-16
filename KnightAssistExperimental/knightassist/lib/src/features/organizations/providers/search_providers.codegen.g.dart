// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_providers.codegen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredOrgsHash() => r'92e7aa1208fbd1dc7ccc55aacd81c5a8fb5f9372';

/// See also [filteredOrgs].
@ProviderFor(filteredOrgs)
final filteredOrgsProvider =
    AutoDisposeFutureProvider<List<OrganizationModel>>.internal(
  filteredOrgs,
  name: r'filteredOrgsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$filteredOrgsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FilteredOrgsRef = AutoDisposeFutureProviderRef<List<OrganizationModel>>;
String _$searchedOrgsHash() => r'ade607d4bed33d5c774a80f8621b8564f1261d21';

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

/// See also [searchedOrgs].
@ProviderFor(searchedOrgs)
const searchedOrgsProvider = SearchedOrgsFamily();

/// See also [searchedOrgs].
class SearchedOrgsFamily extends Family<List<OrganizationModel>> {
  /// See also [searchedOrgs].
  const SearchedOrgsFamily();

  /// See also [searchedOrgs].
  SearchedOrgsProvider call(
    List<OrganizationModel> orgs,
  ) {
    return SearchedOrgsProvider(
      orgs,
    );
  }

  @override
  SearchedOrgsProvider getProviderOverride(
    covariant SearchedOrgsProvider provider,
  ) {
    return call(
      provider.orgs,
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
  String? get name => r'searchedOrgsProvider';
}

/// See also [searchedOrgs].
class SearchedOrgsProvider
    extends AutoDisposeProvider<List<OrganizationModel>> {
  /// See also [searchedOrgs].
  SearchedOrgsProvider(
    List<OrganizationModel> orgs,
  ) : this._internal(
          (ref) => searchedOrgs(
            ref as SearchedOrgsRef,
            orgs,
          ),
          from: searchedOrgsProvider,
          name: r'searchedOrgsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchedOrgsHash,
          dependencies: SearchedOrgsFamily._dependencies,
          allTransitiveDependencies:
              SearchedOrgsFamily._allTransitiveDependencies,
          orgs: orgs,
        );

  SearchedOrgsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orgs,
  }) : super.internal();

  final List<OrganizationModel> orgs;

  @override
  Override overrideWith(
    List<OrganizationModel> Function(SearchedOrgsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchedOrgsProvider._internal(
        (ref) => create(ref as SearchedOrgsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orgs: orgs,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<OrganizationModel>> createElement() {
    return _SearchedOrgsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchedOrgsProvider && other.orgs == orgs;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orgs.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchedOrgsRef on AutoDisposeProviderRef<List<OrganizationModel>> {
  /// The parameter `orgs` of this provider.
  List<OrganizationModel> get orgs;
}

class _SearchedOrgsProviderElement
    extends AutoDisposeProviderElement<List<OrganizationModel>>
    with SearchedOrgsRef {
  _SearchedOrgsProviderElement(super.provider);

  @override
  List<OrganizationModel> get orgs => (origin as SearchedOrgsProvider).orgs;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
