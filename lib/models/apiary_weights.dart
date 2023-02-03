import 'package:json_annotation/json_annotation.dart';

part 'apiary_weights.g.dart';

@JsonSerializable()
class ApiaryWeights {
  final Map<String, dynamic> daily;
  final Map<String, dynamic> delta;

  const ApiaryWeights({
    required this.daily,
    required this.delta,
  });

  factory ApiaryWeights.fromJson(Map<String, dynamic> json) => _$ApiaryWeightsFromJson(json);

  Map<String, dynamic> toJson() => _$ApiaryWeightsToJson(this);
}
