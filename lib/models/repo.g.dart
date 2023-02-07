// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repo _$RepoFromJson(Map<String, dynamic> json) => Repo()
  ..total_count = json['total_count'] as num
  ..incomplete_results = json['incomplete_results'] as bool
  ..items = json['items'] as List<dynamic>;

Map<String, dynamic> _$RepoToJson(Repo instance) => <String, dynamic>{
      'total_count': instance.total_count,
      'incomplete_results': instance.incomplete_results,
      'items': instance.items,
    };
