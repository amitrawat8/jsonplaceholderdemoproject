import 'package:json_annotation/json_annotation.dart';

/**
 * Created by Amit Rawat on 3/30/2022.
 */
part 'post_dto.g.dart';

@JsonSerializable()
class PostDTO {
  int? userId;
  int? id;
  String? title;
  String? body;
  String? authorName;

  PostDTO({this.userId, this.id, this.title, this.body,this.authorName});

  factory PostDTO.fromJson(Map<String, dynamic> json) =>
      _$PostDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PostDTOToJson(this);
}
