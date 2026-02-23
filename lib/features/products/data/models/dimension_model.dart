import '../../domain/entities/dimension_entity.dart';

class DimensionModel extends DimensionEntity {
  DimensionModel({
    required super.width,
    required super.height,
    required super.depth,
  });

  factory DimensionModel.fromJson(Map<String, dynamic> json) {
    return DimensionModel(
      width: json['width'],
      height: json['height'],
      depth: json['depth'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'depth': depth,
    };
  }

  DimensionModel copyWith({
    double? width,
    double? height,
    double? depth,
  }) {
    return DimensionModel(
      width: width ?? this.width,
      height: height ?? this.height,
      depth: depth ?? this.depth,
    );
  }
}