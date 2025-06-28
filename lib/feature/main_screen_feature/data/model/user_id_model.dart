import 'package:json_annotation/json_annotation.dart';

part 'user_id_model.g.dart';

@JsonSerializable()
class UserIdModel{
  UserIdModel({this.userId = ''});

  @JsonKey(name: 'user_id')
  final String userId;

  factory UserIdModel.fromJson(Map<String,dynamic> json) => _$UserIdModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserIdModelToJson(this);
}