import 'package:json_annotation/json_annotation.dart';
import 'package:test_3bee/models/apiary.dart';

part 'apiaries_response.g.dart';

@JsonSerializable()
class ApiariesResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<Apiary> results;

  const ApiariesResponse({
    required this.count,
    this.next,
    this.previous,
    this.results = const [],
  });

  factory ApiariesResponse.fromJson(Map<String, dynamic> json) => _$ApiariesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiariesResponseToJson(this);
}
