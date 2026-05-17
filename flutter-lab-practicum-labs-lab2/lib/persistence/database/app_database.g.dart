// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FavoritePlacesTableTable extends FavoritePlacesTable
    with TableInfo<$FavoritePlacesTableTable, FavoritePlacesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritePlacesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _placeIdMeta = const VerificationMeta(
    'placeId',
  );
  @override
  late final GeneratedColumn<int> placeId = GeneratedColumn<int>(
    'place_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PlaceType, int> type = GeneratedColumn<int>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  ).withConverter<PlaceType>($FavoritePlacesTableTable.$convertertype);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> images = GeneratedColumn<String>(
    'images',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<List<String>>($FavoritePlacesTableTable.$converterimages);
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lonMeta = const VerificationMeta('lon');
  @override
  late final GeneratedColumn<double> lon = GeneratedColumn<double>(
    'lon',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    placeId,
    name,
    description,
    type,
    images,
    lat,
    lon,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_places_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoritePlacesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('place_id')) {
      context.handle(
        _placeIdMeta,
        placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lon')) {
      context.handle(
        _lonMeta,
        lon.isAcceptableOrUnknown(data['lon']!, _lonMeta),
      );
    } else if (isInserting) {
      context.missing(_lonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoritePlacesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoritePlacesTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      placeId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}place_id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      type: $FavoritePlacesTableTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      images: $FavoritePlacesTableTable.$converterimages.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}images'],
        )!,
      ),
      lat:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}lat'],
          )!,
      lon:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}lon'],
          )!,
    );
  }

  @override
  $FavoritePlacesTableTable createAlias(String alias) {
    return $FavoritePlacesTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PlaceType, int, int> $convertertype = const EnumIndexConverter<PlaceType>(PlaceType.values);
  static TypeConverter<List<String>, String> $converterimages = const ListStringConverter();
}

class FavoritePlacesTableData extends DataClass implements Insertable<FavoritePlacesTableData> {
  final int id;
  final int placeId;
  final String name;
  final String description;
  final PlaceType type;
  final List<String> images;
  final double lat;
  final double lon;
  const FavoritePlacesTableData({
    required this.id,
    required this.placeId,
    required this.name,
    required this.description,
    required this.type,
    required this.images,
    required this.lat,
    required this.lon,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['place_id'] = Variable<int>(placeId);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    {
      map['type'] = Variable<int>(
        $FavoritePlacesTableTable.$convertertype.toSql(type),
      );
    }
    {
      map['images'] = Variable<String>(
        $FavoritePlacesTableTable.$converterimages.toSql(images),
      );
    }
    map['lat'] = Variable<double>(lat);
    map['lon'] = Variable<double>(lon);
    return map;
  }

  FavoritePlacesTableCompanion toCompanion(bool nullToAbsent) {
    return FavoritePlacesTableCompanion(
      id: Value(id),
      placeId: Value(placeId),
      name: Value(name),
      description: Value(description),
      type: Value(type),
      images: Value(images),
      lat: Value(lat),
      lon: Value(lon),
    );
  }

  factory FavoritePlacesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoritePlacesTableData(
      id: serializer.fromJson<int>(json['id']),
      placeId: serializer.fromJson<int>(json['placeId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      type: $FavoritePlacesTableTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      images: serializer.fromJson<List<String>>(json['images']),
      lat: serializer.fromJson<double>(json['lat']),
      lon: serializer.fromJson<double>(json['lon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'placeId': serializer.toJson<int>(placeId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'type': serializer.toJson<int>(
        $FavoritePlacesTableTable.$convertertype.toJson(type),
      ),
      'images': serializer.toJson<List<String>>(images),
      'lat': serializer.toJson<double>(lat),
      'lon': serializer.toJson<double>(lon),
    };
  }

  FavoritePlacesTableData copyWith({
    int? id,
    int? placeId,
    String? name,
    String? description,
    PlaceType? type,
    List<String>? images,
    double? lat,
    double? lon,
  }) => FavoritePlacesTableData(
    id: id ?? this.id,
    placeId: placeId ?? this.placeId,
    name: name ?? this.name,
    description: description ?? this.description,
    type: type ?? this.type,
    images: images ?? this.images,
    lat: lat ?? this.lat,
    lon: lon ?? this.lon,
  );
  FavoritePlacesTableData copyWithCompanion(FavoritePlacesTableCompanion data) {
    return FavoritePlacesTableData(
      id: data.id.present ? data.id.value : this.id,
      placeId: data.placeId.present ? data.placeId.value : this.placeId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present ? data.description.value : this.description,
      type: data.type.present ? data.type.value : this.type,
      images: data.images.present ? data.images.value : this.images,
      lat: data.lat.present ? data.lat.value : this.lat,
      lon: data.lon.present ? data.lon.value : this.lon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoritePlacesTableData(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('images: $images, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, placeId, name, description, type, images, lat, lon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoritePlacesTableData &&
          other.id == this.id &&
          other.placeId == this.placeId &&
          other.name == this.name &&
          other.description == this.description &&
          other.type == this.type &&
          other.images == this.images &&
          other.lat == this.lat &&
          other.lon == this.lon);
}

class FavoritePlacesTableCompanion extends UpdateCompanion<FavoritePlacesTableData> {
  final Value<int> id;
  final Value<int> placeId;
  final Value<String> name;
  final Value<String> description;
  final Value<PlaceType> type;
  final Value<List<String>> images;
  final Value<double> lat;
  final Value<double> lon;
  const FavoritePlacesTableCompanion({
    this.id = const Value.absent(),
    this.placeId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.images = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
  });
  FavoritePlacesTableCompanion.insert({
    this.id = const Value.absent(),
    required int placeId,
    required String name,
    required String description,
    required PlaceType type,
    required List<String> images,
    required double lat,
    required double lon,
  }) : placeId = Value(placeId),
       name = Value(name),
       description = Value(description),
       type = Value(type),
       images = Value(images),
       lat = Value(lat),
       lon = Value(lon);
  static Insertable<FavoritePlacesTableData> custom({
    Expression<int>? id,
    Expression<int>? placeId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? type,
    Expression<String>? images,
    Expression<double>? lat,
    Expression<double>? lon,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placeId != null) 'place_id': placeId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (images != null) 'images': images,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
    });
  }

  FavoritePlacesTableCompanion copyWith({
    Value<int>? id,
    Value<int>? placeId,
    Value<String>? name,
    Value<String>? description,
    Value<PlaceType>? type,
    Value<List<String>>? images,
    Value<double>? lat,
    Value<double>? lon,
  }) {
    return FavoritePlacesTableCompanion(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      images: images ?? this.images,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $FavoritePlacesTableTable.$convertertype.toSql(type.value),
      );
    }
    if (images.present) {
      map['images'] = Variable<String>(
        $FavoritePlacesTableTable.$converterimages.toSql(images.value),
      );
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<double>(lon.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritePlacesTableCompanion(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('images: $images, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon')
          ..write(')'))
        .toString();
  }
}

class $HistorySearchTableTable extends HistorySearchTable
    with TableInfo<$HistorySearchTableTable, HistorySearchTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistorySearchTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _keywordMeta = const VerificationMeta(
    'keyword',
  );
  @override
  late final GeneratedColumn<String> keyword = GeneratedColumn<String>(
    'keyword',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, keyword];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'history_search_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<HistorySearchTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('keyword')) {
      context.handle(
        _keywordMeta,
        keyword.isAcceptableOrUnknown(data['keyword']!, _keywordMeta),
      );
    } else if (isInserting) {
      context.missing(_keywordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistorySearchTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistorySearchTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      keyword:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}keyword'],
          )!,
    );
  }

  @override
  $HistorySearchTableTable createAlias(String alias) {
    return $HistorySearchTableTable(attachedDatabase, alias);
  }
}

class HistorySearchTableData extends DataClass implements Insertable<HistorySearchTableData> {
  final int id;
  final String keyword;
  const HistorySearchTableData({required this.id, required this.keyword});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['keyword'] = Variable<String>(keyword);
    return map;
  }

  HistorySearchTableCompanion toCompanion(bool nullToAbsent) {
    return HistorySearchTableCompanion(id: Value(id), keyword: Value(keyword));
  }

  factory HistorySearchTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistorySearchTableData(
      id: serializer.fromJson<int>(json['id']),
      keyword: serializer.fromJson<String>(json['keyword']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'keyword': serializer.toJson<String>(keyword),
    };
  }

  HistorySearchTableData copyWith({int? id, String? keyword}) => HistorySearchTableData(
    id: id ?? this.id,
    keyword: keyword ?? this.keyword,
  );
  HistorySearchTableData copyWithCompanion(HistorySearchTableCompanion data) {
    return HistorySearchTableData(
      id: data.id.present ? data.id.value : this.id,
      keyword: data.keyword.present ? data.keyword.value : this.keyword,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistorySearchTableData(')
          ..write('id: $id, ')
          ..write('keyword: $keyword')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, keyword);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistorySearchTableData && other.id == this.id && other.keyword == this.keyword);
}

class HistorySearchTableCompanion extends UpdateCompanion<HistorySearchTableData> {
  final Value<int> id;
  final Value<String> keyword;
  const HistorySearchTableCompanion({
    this.id = const Value.absent(),
    this.keyword = const Value.absent(),
  });
  HistorySearchTableCompanion.insert({
    this.id = const Value.absent(),
    required String keyword,
  }) : keyword = Value(keyword);
  static Insertable<HistorySearchTableData> custom({
    Expression<int>? id,
    Expression<String>? keyword,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (keyword != null) 'keyword': keyword,
    });
  }

  HistorySearchTableCompanion copyWith({
    Value<int>? id,
    Value<String>? keyword,
  }) {
    return HistorySearchTableCompanion(
      id: id ?? this.id,
      keyword: keyword ?? this.keyword,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (keyword.present) {
      map['keyword'] = Variable<String>(keyword.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistorySearchTableCompanion(')
          ..write('id: $id, ')
          ..write('keyword: $keyword')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoritePlacesTableTable favoritePlacesTable = $FavoritePlacesTableTable(this);
  late final $HistorySearchTableTable historySearchTable = $HistorySearchTableTable(this);
  late final FavoritesDao favoritesDao = FavoritesDao(this as AppDatabase);
  late final HistorySearchDao historySearchDao = HistorySearchDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    favoritePlacesTable,
    historySearchTable,
  ];
}

typedef $$FavoritePlacesTableTableCreateCompanionBuilder =
    FavoritePlacesTableCompanion Function({
      Value<int> id,
      required int placeId,
      required String name,
      required String description,
      required PlaceType type,
      required List<String> images,
      required double lat,
      required double lon,
    });
typedef $$FavoritePlacesTableTableUpdateCompanionBuilder =
    FavoritePlacesTableCompanion Function({
      Value<int> id,
      Value<int> placeId,
      Value<String> name,
      Value<String> description,
      Value<PlaceType> type,
      Value<List<String>> images,
      Value<double> lat,
      Value<double> lon,
    });

class $$FavoritePlacesTableTableFilterComposer extends Composer<_$AppDatabase, $FavoritePlacesTableTable> {
  $$FavoritePlacesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get placeId => $composableBuilder(
    column: $table.placeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PlaceType, PlaceType, int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String> get images => $composableBuilder(
    column: $table.images,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoritePlacesTableTableOrderingComposer extends Composer<_$AppDatabase, $FavoritePlacesTableTable> {
  $$FavoritePlacesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get placeId => $composableBuilder(
    column: $table.placeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get images => $composableBuilder(
    column: $table.images,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoritePlacesTableTableAnnotationComposer extends Composer<_$AppDatabase, $FavoritePlacesTableTable> {
  $$FavoritePlacesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get placeId => $composableBuilder(column: $table.placeId, builder: (column) => column);

  GeneratedColumn<String> get name => $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<PlaceType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get images =>
      $composableBuilder(column: $table.images, builder: (column) => column);

  GeneratedColumn<double> get lat => $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lon => $composableBuilder(column: $table.lon, builder: (column) => column);
}

class $$FavoritePlacesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritePlacesTableTable,
          FavoritePlacesTableData,
          $$FavoritePlacesTableTableFilterComposer,
          $$FavoritePlacesTableTableOrderingComposer,
          $$FavoritePlacesTableTableAnnotationComposer,
          $$FavoritePlacesTableTableCreateCompanionBuilder,
          $$FavoritePlacesTableTableUpdateCompanionBuilder,
          (FavoritePlacesTableData, BaseReferences<_$AppDatabase, $FavoritePlacesTableTable, FavoritePlacesTableData>),
          FavoritePlacesTableData,
          PrefetchHooks Function()
        > {
  $$FavoritePlacesTableTableTableManager(
    _$AppDatabase db,
    $FavoritePlacesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$FavoritePlacesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$FavoritePlacesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$FavoritePlacesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> placeId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<PlaceType> type = const Value.absent(),
                Value<List<String>> images = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lon = const Value.absent(),
              }) => FavoritePlacesTableCompanion(
                id: id,
                placeId: placeId,
                name: name,
                description: description,
                type: type,
                images: images,
                lat: lat,
                lon: lon,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int placeId,
                required String name,
                required String description,
                required PlaceType type,
                required List<String> images,
                required double lat,
                required double lon,
              }) => FavoritePlacesTableCompanion.insert(
                id: id,
                placeId: placeId,
                name: name,
                description: description,
                type: type,
                images: images,
                lat: lat,
                lon: lon,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoritePlacesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritePlacesTableTable,
      FavoritePlacesTableData,
      $$FavoritePlacesTableTableFilterComposer,
      $$FavoritePlacesTableTableOrderingComposer,
      $$FavoritePlacesTableTableAnnotationComposer,
      $$FavoritePlacesTableTableCreateCompanionBuilder,
      $$FavoritePlacesTableTableUpdateCompanionBuilder,
      (FavoritePlacesTableData, BaseReferences<_$AppDatabase, $FavoritePlacesTableTable, FavoritePlacesTableData>),
      FavoritePlacesTableData,
      PrefetchHooks Function()
    >;
typedef $$HistorySearchTableTableCreateCompanionBuilder =
    HistorySearchTableCompanion Function({
      Value<int> id,
      required String keyword,
    });
typedef $$HistorySearchTableTableUpdateCompanionBuilder =
    HistorySearchTableCompanion Function({
      Value<int> id,
      Value<String> keyword,
    });

class $$HistorySearchTableTableFilterComposer extends Composer<_$AppDatabase, $HistorySearchTableTable> {
  $$HistorySearchTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keyword => $composableBuilder(
    column: $table.keyword,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HistorySearchTableTableOrderingComposer extends Composer<_$AppDatabase, $HistorySearchTableTable> {
  $$HistorySearchTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keyword => $composableBuilder(
    column: $table.keyword,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HistorySearchTableTableAnnotationComposer extends Composer<_$AppDatabase, $HistorySearchTableTable> {
  $$HistorySearchTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get keyword => $composableBuilder(column: $table.keyword, builder: (column) => column);
}

class $$HistorySearchTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HistorySearchTableTable,
          HistorySearchTableData,
          $$HistorySearchTableTableFilterComposer,
          $$HistorySearchTableTableOrderingComposer,
          $$HistorySearchTableTableAnnotationComposer,
          $$HistorySearchTableTableCreateCompanionBuilder,
          $$HistorySearchTableTableUpdateCompanionBuilder,
          (HistorySearchTableData, BaseReferences<_$AppDatabase, $HistorySearchTableTable, HistorySearchTableData>),
          HistorySearchTableData,
          PrefetchHooks Function()
        > {
  $$HistorySearchTableTableTableManager(
    _$AppDatabase db,
    $HistorySearchTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$HistorySearchTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$HistorySearchTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$HistorySearchTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> keyword = const Value.absent(),
              }) => HistorySearchTableCompanion(id: id, keyword: keyword),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String keyword,
              }) => HistorySearchTableCompanion.insert(id: id, keyword: keyword),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HistorySearchTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HistorySearchTableTable,
      HistorySearchTableData,
      $$HistorySearchTableTableFilterComposer,
      $$HistorySearchTableTableOrderingComposer,
      $$HistorySearchTableTableAnnotationComposer,
      $$HistorySearchTableTableCreateCompanionBuilder,
      $$HistorySearchTableTableUpdateCompanionBuilder,
      (HistorySearchTableData, BaseReferences<_$AppDatabase, $HistorySearchTableTable, HistorySearchTableData>),
      HistorySearchTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoritePlacesTableTableTableManager get favoritePlacesTable =>
      $$FavoritePlacesTableTableTableManager(_db, _db.favoritePlacesTable);
  $$HistorySearchTableTableTableManager get historySearchTable =>
      $$HistorySearchTableTableTableManager(_db, _db.historySearchTable);
}
