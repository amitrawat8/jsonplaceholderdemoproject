// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBody _$UserBodyFromJson(Map<String, dynamic> json) => UserBody(
      json['title'] as String?,
      json['body'] as String?,
      json['id'] as int?,
      json['userId'] as int?,
    );

Map<String, dynamic> _$UserBodyToJson(UserBody instance) => <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'id': instance.id,
      'userId': instance.userId,
    };
