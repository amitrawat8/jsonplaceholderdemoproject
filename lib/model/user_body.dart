import 'package:json_annotation/json_annotation.dart';

/**
 * Created by Amit Rawat on 3/30/2022.
 */
part 'user_body.g.dart';
@JsonSerializable()
class UserBody {
  const UserBody(this.title, this.body, this.id, this.userId);

  final String? title;
  final String? body;
  final int? id;
  final int? userId;


  factory UserBody.fromJson(Map<String, dynamic> json) =>
      _$UserBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UserBodyToJson(this);
}
