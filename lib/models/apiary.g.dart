// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apiary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Apiary _$ApiaryFromJson(Map<String, dynamic> json) => Apiary(
      id: json['id'] as int,
      name: json['name'] as String,
      color: json['color'] as String,
      imageUrl: json['thumbnail_apiary_list_url'] as String?,
    );

Map<String, dynamic> _$ApiaryToJson(Apiary instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'thumbnail_apiary_list_url': instance.imageUrl,
    };
