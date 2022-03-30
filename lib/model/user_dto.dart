import 'package:json_annotation/json_annotation.dart';

/**
 * Created by Amit Rawat on 3/30/2022.
 */
part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO {
  int? id;
  String? name;
  String? username;
  String? email;

  String? phone;
  String? website;

  UserDTO(
      this.id, this.name, this.username, this.email, this.phone, this.website);

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
}
