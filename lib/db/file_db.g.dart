// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_db.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFolderCollection on Isar {
  IsarCollection<Folder> get folders => this.collection();
}

const FolderSchema = CollectionSchema(
  name: r'Folder',
  id: 6793289488482879694,
  properties: {
    r'folderName': PropertySchema(
      id: 0,
      name: r'folderName',
      type: IsarType.string,
    ),
    r'path': PropertySchema(
      id: 1,
      name: r'path',
      type: IsarType.string,
    )
  },
  estimateSize: _folderEstimateSize,
  serialize: _folderSerialize,
  deserialize: _folderDeserialize,
  deserializeProp: _folderDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _folderGetId,
  getLinks: _folderGetLinks,
  attach: _folderAttach,
  version: '3.1.7',
);

int _folderEstimateSize(
  Folder object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.folderName.length * 3;
  bytesCount += 3 + object.path.length * 3;
  return bytesCount;
}

void _folderSerialize(
  Folder object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.folderName);
  writer.writeString(offsets[1], object.path);
}

Folder _folderDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Folder(
    folderName: reader.readString(offsets[0]),
    path: reader.readString(offsets[1]),
  );
  object.id = id;
  return object;
}

P _folderDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _folderGetId(Folder object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _folderGetLinks(Folder object) {
  return [];
}

void _folderAttach(IsarCollection<dynamic> col, Id id, Folder object) {
  object.id = id;
}

extension FolderQueryWhereSort on QueryBuilder<Folder, Folder, QWhere> {
  QueryBuilder<Folder, Folder, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FolderQueryWhere on QueryBuilder<Folder, Folder, QWhereClause> {
  QueryBuilder<Folder, Folder, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Folder, Folder, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Folder, Folder, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Folder, Folder, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FolderQueryFilter on QueryBuilder<Folder, Folder, QFilterCondition> {
  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'folderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'folderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'folderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'folderName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'folderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'folderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'folderName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'folderName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'folderName',
        value: '',
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'folderName',
        value: '',
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> pathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> pathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> pathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> pathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'path',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> pathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> pathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> pathContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> pathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> pathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> pathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'path',
        value: '',
      ));
    });
  }
}

extension FolderQueryObject on QueryBuilder<Folder, Folder, QFilterCondition> {}

extension FolderQueryLinks on QueryBuilder<Folder, Folder, QFilterCondition> {}

extension FolderQuerySortBy on QueryBuilder<Folder, Folder, QSortBy> {
  QueryBuilder<Folder, Folder, QAfterSortBy> sortByFolderName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderName', Sort.asc);
    });
  }

  QueryBuilder<Folder, Folder, QAfterSortBy> sortByFolderNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderName', Sort.desc);
    });
  }

  QueryBuilder<Folder, Folder, QAfterSortBy> sortByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<Folder, Folder, QAfterSortBy> sortByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }
}

extension FolderQuerySortThenBy on QueryBuilder<Folder, Folder, QSortThenBy> {
  QueryBuilder<Folder, Folder, QAfterSortBy> thenByFolderName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderName', Sort.asc);
    });
  }

  QueryBuilder<Folder, Folder, QAfterSortBy> thenByFolderNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderName', Sort.desc);
    });
  }

  QueryBuilder<Folder, Folder, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Folder, Folder, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Folder, Folder, QAfterSortBy> thenByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<Folder, Folder, QAfterSortBy> thenByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }
}

extension FolderQueryWhereDistinct on QueryBuilder<Folder, Folder, QDistinct> {
  QueryBuilder<Folder, Folder, QDistinct> distinctByFolderName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'folderName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Folder, Folder, QDistinct> distinctByPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'path', caseSensitive: caseSensitive);
    });
  }
}

extension FolderQueryProperty on QueryBuilder<Folder, Folder, QQueryProperty> {
  QueryBuilder<Folder, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Folder, String, QQueryOperations> folderNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'folderName');
    });
  }

  QueryBuilder<Folder, String, QQueryOperations> pathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'path');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetExamFileCollection on Isar {
  IsarCollection<ExamFile> get examFiles => this.collection();
}

const ExamFileSchema = CollectionSchema(
  name: r'ExamFile',
  id: -6807050698570456567,
  properties: {
    r'examName': PropertySchema(
      id: 0,
      name: r'examName',
      type: IsarType.string,
    ),
    r'passage': PropertySchema(
      id: 1,
      name: r'passage',
      type: IsarType.string,
    ),
    r'path': PropertySchema(
      id: 2,
      name: r'path',
      type: IsarType.string,
    )
  },
  estimateSize: _examFileEstimateSize,
  serialize: _examFileSerialize,
  deserialize: _examFileDeserialize,
  deserializeProp: _examFileDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'questions': LinkSchema(
      id: -2876991240922479830,
      name: r'questions',
      target: r'QuestionFile',
      single: false,
    ),
    r'examResults': LinkSchema(
      id: 5134289959273896599,
      name: r'examResults',
      target: r'ExamResult',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _examFileGetId,
  getLinks: _examFileGetLinks,
  attach: _examFileAttach,
  version: '3.1.7',
);

int _examFileEstimateSize(
  ExamFile object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.examName.length * 3;
  bytesCount += 3 + object.passage.length * 3;
  bytesCount += 3 + object.path.length * 3;
  return bytesCount;
}

void _examFileSerialize(
  ExamFile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.examName);
  writer.writeString(offsets[1], object.passage);
  writer.writeString(offsets[2], object.path);
}

ExamFile _examFileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ExamFile(
    examName: reader.readString(offsets[0]),
    passage: reader.readString(offsets[1]),
    path: reader.readString(offsets[2]),
  );
  object.id = id;
  return object;
}

P _examFileDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _examFileGetId(ExamFile object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _examFileGetLinks(ExamFile object) {
  return [object.questions, object.examResults];
}

void _examFileAttach(IsarCollection<dynamic> col, Id id, ExamFile object) {
  object.id = id;
  object.questions
      .attach(col, col.isar.collection<QuestionFile>(), r'questions', id);
  object.examResults
      .attach(col, col.isar.collection<ExamResult>(), r'examResults', id);
}

extension ExamFileQueryWhereSort on QueryBuilder<ExamFile, ExamFile, QWhere> {
  QueryBuilder<ExamFile, ExamFile, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ExamFileQueryWhere on QueryBuilder<ExamFile, ExamFile, QWhereClause> {
  QueryBuilder<ExamFile, ExamFile, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ExamFileQueryFilter
    on QueryBuilder<ExamFile, ExamFile, QFilterCondition> {
  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> examNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'examName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> examNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'examName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> examNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'examName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> examNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'examName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> examNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'examName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> examNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'examName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> examNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'examName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> examNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'examName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> examNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'examName',
        value: '',
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> examNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'examName',
        value: '',
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> passageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'passage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> passageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'passage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> passageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'passage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> passageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'passage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> passageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'passage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> passageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'passage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> passageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'passage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> passageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'passage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> passageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'passage',
        value: '',
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> passageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'passage',
        value: '',
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> pathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> pathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> pathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> pathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'path',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> pathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> pathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> pathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> pathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> pathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> pathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'path',
        value: '',
      ));
    });
  }
}

extension ExamFileQueryObject
    on QueryBuilder<ExamFile, ExamFile, QFilterCondition> {}

extension ExamFileQueryLinks
    on QueryBuilder<ExamFile, ExamFile, QFilterCondition> {
  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> questions(
      FilterQuery<QuestionFile> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'questions');
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition>
      questionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questions', length, true, length, true);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> questionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questions', 0, true, 0, true);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition>
      questionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questions', 0, false, 999999, true);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition>
      questionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questions', 0, true, length, include);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition>
      questionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questions', length, include, 999999, true);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition>
      questionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'questions', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> examResults(
      FilterQuery<ExamResult> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'examResults');
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition>
      examResultsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'examResults', length, true, length, true);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition> examResultsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'examResults', 0, true, 0, true);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition>
      examResultsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'examResults', 0, false, 999999, true);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition>
      examResultsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'examResults', 0, true, length, include);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition>
      examResultsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'examResults', length, include, 999999, true);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterFilterCondition>
      examResultsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'examResults', lower, includeLower, upper, includeUpper);
    });
  }
}

extension ExamFileQuerySortBy on QueryBuilder<ExamFile, ExamFile, QSortBy> {
  QueryBuilder<ExamFile, ExamFile, QAfterSortBy> sortByExamName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'examName', Sort.asc);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterSortBy> sortByExamNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'examName', Sort.desc);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterSortBy> sortByPassage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passage', Sort.asc);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterSortBy> sortByPassageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passage', Sort.desc);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterSortBy> sortByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterSortBy> sortByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }
}

extension ExamFileQuerySortThenBy
    on QueryBuilder<ExamFile, ExamFile, QSortThenBy> {
  QueryBuilder<ExamFile, ExamFile, QAfterSortBy> thenByExamName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'examName', Sort.asc);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterSortBy> thenByExamNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'examName', Sort.desc);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterSortBy> thenByPassage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passage', Sort.asc);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterSortBy> thenByPassageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passage', Sort.desc);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterSortBy> thenByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QAfterSortBy> thenByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }
}

extension ExamFileQueryWhereDistinct
    on QueryBuilder<ExamFile, ExamFile, QDistinct> {
  QueryBuilder<ExamFile, ExamFile, QDistinct> distinctByExamName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'examName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QDistinct> distinctByPassage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'passage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExamFile, ExamFile, QDistinct> distinctByPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'path', caseSensitive: caseSensitive);
    });
  }
}

extension ExamFileQueryProperty
    on QueryBuilder<ExamFile, ExamFile, QQueryProperty> {
  QueryBuilder<ExamFile, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ExamFile, String, QQueryOperations> examNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'examName');
    });
  }

  QueryBuilder<ExamFile, String, QQueryOperations> passageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'passage');
    });
  }

  QueryBuilder<ExamFile, String, QQueryOperations> pathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'path');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuestionFileCollection on Isar {
  IsarCollection<QuestionFile> get questionFiles => this.collection();
}

const QuestionFileSchema = CollectionSchema(
  name: r'QuestionFile',
  id: 3283779628763814680,
  properties: {
    r'answer': PropertySchema(
      id: 0,
      name: r'answer',
      type: IsarType.long,
    ),
    r'choices': PropertySchema(
      id: 1,
      name: r'choices',
      type: IsarType.stringList,
    ),
    r'comment': PropertySchema(
      id: 2,
      name: r'comment',
      type: IsarType.string,
    ),
    r'question': PropertySchema(
      id: 3,
      name: r'question',
      type: IsarType.string,
    )
  },
  estimateSize: _questionFileEstimateSize,
  serialize: _questionFileSerialize,
  deserialize: _questionFileDeserialize,
  deserializeProp: _questionFileDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _questionFileGetId,
  getLinks: _questionFileGetLinks,
  attach: _questionFileAttach,
  version: '3.1.7',
);

int _questionFileEstimateSize(
  QuestionFile object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.choices.length * 3;
  {
    for (var i = 0; i < object.choices.length; i++) {
      final value = object.choices[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.comment.length * 3;
  bytesCount += 3 + object.question.length * 3;
  return bytesCount;
}

void _questionFileSerialize(
  QuestionFile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.answer);
  writer.writeStringList(offsets[1], object.choices);
  writer.writeString(offsets[2], object.comment);
  writer.writeString(offsets[3], object.question);
}

QuestionFile _questionFileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuestionFile(
    answer: reader.readLong(offsets[0]),
    choices: reader.readStringList(offsets[1]) ?? [],
    comment: reader.readString(offsets[2]),
    question: reader.readString(offsets[3]),
  );
  object.id = id;
  return object;
}

P _questionFileDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _questionFileGetId(QuestionFile object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _questionFileGetLinks(QuestionFile object) {
  return [];
}

void _questionFileAttach(
    IsarCollection<dynamic> col, Id id, QuestionFile object) {
  object.id = id;
}

extension QuestionFileQueryWhereSort
    on QueryBuilder<QuestionFile, QuestionFile, QWhere> {
  QueryBuilder<QuestionFile, QuestionFile, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension QuestionFileQueryWhere
    on QueryBuilder<QuestionFile, QuestionFile, QWhereClause> {
  QueryBuilder<QuestionFile, QuestionFile, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuestionFileQueryFilter
    on QueryBuilder<QuestionFile, QuestionFile, QFilterCondition> {
  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition> answerEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'answer',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      answerGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'answer',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      answerLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'answer',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition> answerBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'answer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      choicesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'choices',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      choicesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'choices',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      choicesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'choices',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      choicesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'choices',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      choicesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'choices',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      choicesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'choices',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      choicesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'choices',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      choicesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'choices',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      choicesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'choices',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      choicesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'choices',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      choicesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'choices',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      choicesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'choices',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      choicesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'choices',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      choicesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'choices',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      choicesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'choices',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      choicesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'choices',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      commentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      commentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'comment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      commentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'comment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      commentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'comment',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      commentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'comment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      commentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'comment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      commentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'comment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      commentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'comment',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      commentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comment',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      commentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comment',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      questionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      questionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      questionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      questionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'question',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      questionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      questionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      questionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      questionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'question',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      questionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterFilterCondition>
      questionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'question',
        value: '',
      ));
    });
  }
}

extension QuestionFileQueryObject
    on QueryBuilder<QuestionFile, QuestionFile, QFilterCondition> {}

extension QuestionFileQueryLinks
    on QueryBuilder<QuestionFile, QuestionFile, QFilterCondition> {}

extension QuestionFileQuerySortBy
    on QueryBuilder<QuestionFile, QuestionFile, QSortBy> {
  QueryBuilder<QuestionFile, QuestionFile, QAfterSortBy> sortByAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.asc);
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterSortBy> sortByAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.desc);
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterSortBy> sortByComment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.asc);
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterSortBy> sortByCommentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.desc);
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterSortBy> sortByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterSortBy> sortByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }
}

extension QuestionFileQuerySortThenBy
    on QueryBuilder<QuestionFile, QuestionFile, QSortThenBy> {
  QueryBuilder<QuestionFile, QuestionFile, QAfterSortBy> thenByAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.asc);
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterSortBy> thenByAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.desc);
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterSortBy> thenByComment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.asc);
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterSortBy> thenByCommentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.desc);
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterSortBy> thenByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QAfterSortBy> thenByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }
}

extension QuestionFileQueryWhereDistinct
    on QueryBuilder<QuestionFile, QuestionFile, QDistinct> {
  QueryBuilder<QuestionFile, QuestionFile, QDistinct> distinctByAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'answer');
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QDistinct> distinctByChoices() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'choices');
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QDistinct> distinctByComment(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comment', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuestionFile, QuestionFile, QDistinct> distinctByQuestion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'question', caseSensitive: caseSensitive);
    });
  }
}

extension QuestionFileQueryProperty
    on QueryBuilder<QuestionFile, QuestionFile, QQueryProperty> {
  QueryBuilder<QuestionFile, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuestionFile, int, QQueryOperations> answerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'answer');
    });
  }

  QueryBuilder<QuestionFile, List<String>, QQueryOperations> choicesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'choices');
    });
  }

  QueryBuilder<QuestionFile, String, QQueryOperations> commentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comment');
    });
  }

  QueryBuilder<QuestionFile, String, QQueryOperations> questionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'question');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetExamResultCollection on Isar {
  IsarCollection<ExamResult> get examResults => this.collection();
}

const ExamResultSchema = CollectionSchema(
  name: r'ExamResult',
  id: -4973695977191503399,
  properties: {
    r'correctNumber': PropertySchema(
      id: 0,
      name: r'correctNumber',
      type: IsarType.long,
    ),
    r'examName': PropertySchema(
      id: 1,
      name: r'examName',
      type: IsarType.string,
    ),
    r'selectedChoices': PropertySchema(
      id: 2,
      name: r'selectedChoices',
      type: IsarType.longList,
    ),
    r'totalNumber': PropertySchema(
      id: 3,
      name: r'totalNumber',
      type: IsarType.long,
    )
  },
  estimateSize: _examResultEstimateSize,
  serialize: _examResultSerialize,
  deserialize: _examResultDeserialize,
  deserializeProp: _examResultDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _examResultGetId,
  getLinks: _examResultGetLinks,
  attach: _examResultAttach,
  version: '3.1.7',
);

int _examResultEstimateSize(
  ExamResult object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.examName.length * 3;
  bytesCount += 3 + object.selectedChoices.length * 8;
  return bytesCount;
}

void _examResultSerialize(
  ExamResult object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.correctNumber);
  writer.writeString(offsets[1], object.examName);
  writer.writeLongList(offsets[2], object.selectedChoices);
  writer.writeLong(offsets[3], object.totalNumber);
}

ExamResult _examResultDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ExamResult(
    correctNumber: reader.readLong(offsets[0]),
    examName: reader.readString(offsets[1]),
    selectedChoices: reader.readLongList(offsets[2]) ?? [],
    totalNumber: reader.readLong(offsets[3]),
  );
  object.id = id;
  return object;
}

P _examResultDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLongList(offset) ?? []) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _examResultGetId(ExamResult object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _examResultGetLinks(ExamResult object) {
  return [];
}

void _examResultAttach(IsarCollection<dynamic> col, Id id, ExamResult object) {
  object.id = id;
}

extension ExamResultQueryWhereSort
    on QueryBuilder<ExamResult, ExamResult, QWhere> {
  QueryBuilder<ExamResult, ExamResult, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ExamResultQueryWhere
    on QueryBuilder<ExamResult, ExamResult, QWhereClause> {
  QueryBuilder<ExamResult, ExamResult, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ExamResultQueryFilter
    on QueryBuilder<ExamResult, ExamResult, QFilterCondition> {
  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      correctNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'correctNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      correctNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'correctNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      correctNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'correctNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      correctNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'correctNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition> examNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'examName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      examNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'examName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition> examNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'examName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition> examNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'examName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      examNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'examName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition> examNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'examName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition> examNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'examName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition> examNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'examName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      examNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'examName',
        value: '',
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      examNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'examName',
        value: '',
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      selectedChoicesElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedChoices',
        value: value,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      selectedChoicesElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selectedChoices',
        value: value,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      selectedChoicesElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selectedChoices',
        value: value,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      selectedChoicesElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selectedChoices',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      selectedChoicesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedChoices',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      selectedChoicesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedChoices',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      selectedChoicesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedChoices',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      selectedChoicesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedChoices',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      selectedChoicesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedChoices',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      selectedChoicesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedChoices',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      totalNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      totalNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      totalNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterFilterCondition>
      totalNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ExamResultQueryObject
    on QueryBuilder<ExamResult, ExamResult, QFilterCondition> {}

extension ExamResultQueryLinks
    on QueryBuilder<ExamResult, ExamResult, QFilterCondition> {}

extension ExamResultQuerySortBy
    on QueryBuilder<ExamResult, ExamResult, QSortBy> {
  QueryBuilder<ExamResult, ExamResult, QAfterSortBy> sortByCorrectNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctNumber', Sort.asc);
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterSortBy> sortByCorrectNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctNumber', Sort.desc);
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterSortBy> sortByExamName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'examName', Sort.asc);
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterSortBy> sortByExamNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'examName', Sort.desc);
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterSortBy> sortByTotalNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalNumber', Sort.asc);
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterSortBy> sortByTotalNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalNumber', Sort.desc);
    });
  }
}

extension ExamResultQuerySortThenBy
    on QueryBuilder<ExamResult, ExamResult, QSortThenBy> {
  QueryBuilder<ExamResult, ExamResult, QAfterSortBy> thenByCorrectNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctNumber', Sort.asc);
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterSortBy> thenByCorrectNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctNumber', Sort.desc);
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterSortBy> thenByExamName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'examName', Sort.asc);
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterSortBy> thenByExamNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'examName', Sort.desc);
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterSortBy> thenByTotalNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalNumber', Sort.asc);
    });
  }

  QueryBuilder<ExamResult, ExamResult, QAfterSortBy> thenByTotalNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalNumber', Sort.desc);
    });
  }
}

extension ExamResultQueryWhereDistinct
    on QueryBuilder<ExamResult, ExamResult, QDistinct> {
  QueryBuilder<ExamResult, ExamResult, QDistinct> distinctByCorrectNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'correctNumber');
    });
  }

  QueryBuilder<ExamResult, ExamResult, QDistinct> distinctByExamName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'examName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExamResult, ExamResult, QDistinct> distinctBySelectedChoices() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selectedChoices');
    });
  }

  QueryBuilder<ExamResult, ExamResult, QDistinct> distinctByTotalNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalNumber');
    });
  }
}

extension ExamResultQueryProperty
    on QueryBuilder<ExamResult, ExamResult, QQueryProperty> {
  QueryBuilder<ExamResult, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ExamResult, int, QQueryOperations> correctNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'correctNumber');
    });
  }

  QueryBuilder<ExamResult, String, QQueryOperations> examNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'examName');
    });
  }

  QueryBuilder<ExamResult, List<int>, QQueryOperations>
      selectedChoicesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selectedChoices');
    });
  }

  QueryBuilder<ExamResult, int, QQueryOperations> totalNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalNumber');
    });
  }
}
