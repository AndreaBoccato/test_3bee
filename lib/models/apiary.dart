import 'package:json_annotation/json_annotation.dart';

part 'apiary.g.dart';

@JsonSerializable()
class Apiary {
  final int id;
  final String name;
  final String color;
  final String latitude;
  final String longitude;
  final String route;
  @JsonKey(name: 'thumbnail_apiary_list_url')
  final String imageUrl;

  const Apiary({
    required this.id,
    required this.name,
    required this.color,
    required this.latitude,
    required this.longitude,
    required this.route,
    required this.imageUrl,
  });

  factory Apiary.fromJson(Map<String, dynamic> json) => _$ApiaryFromJson(json);

  Map<String, dynamic> toJson() => _$ApiaryToJson(this);
}
