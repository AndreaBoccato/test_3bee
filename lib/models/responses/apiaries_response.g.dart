// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apiaries_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiariesResponse _$ApiariesResponseFromJson(Map<String, dynamic> json) =>
    ApiariesResponse(
      count: json['count'] as int,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      response: (json['response'] as List<dynamic>?)
              ?.map((e) => Apiary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ApiariesResponseToJson(ApiariesResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'response': instance.response,
    };
