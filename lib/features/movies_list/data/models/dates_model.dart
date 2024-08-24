import 'package:json_annotation/json_annotation.dart';
import 'package:movie_catalog/features/movies_list/domain/entities/entities.dart';

part 'dates_model.g.dart';

@JsonSerializable()
class DatesModel extends Dates {
  DatesModel({
    required super.maximum,
    required super.minimum,
  });

  factory DatesModel.fromJson(Map<String, dynamic> json) => _$DatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$DatesModelToJson(this);
}
