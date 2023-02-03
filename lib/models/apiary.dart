import 'dart:math';

import 'package:json_annotation/json_annotation.dart';
import 'package:test_3bee/models/apiary_weights.dart';

part 'apiary.g.dart';

@JsonSerializable()
class Apiary {
  final int id;
  final String name;
  final String color;
  @JsonKey(name: 'thumbnail_apiary_list_url')
  final String? imageUrl;
  final ApiaryWeights weights;

  const Apiary({
    required this.id,
    required this.name,
    required this.color,
    required this.imageUrl,
    required this.weights,
  });

  factory Apiary.fromJson(Map<String, dynamic> json) => _$ApiaryFromJson(json);

  Map<String, dynamic> toJson() => _$ApiaryToJson(this);

  int getLatestTimestamp() {
    final Map<String, dynamic> mean = weights.delta['mean'];
    final List<int> keys = mean.keys.map((e) => int.parse(e)).toList();
    final int latest = keys.reduce(max);
    return latest;
  }

  String getWeightOfTimestamp(int timestamp) {
    final Map<String, dynamic> mean = weights.delta['mean'];
    final double weight = mean['$timestamp'];
    return weight.toStringAsFixed(2);
  }
}
