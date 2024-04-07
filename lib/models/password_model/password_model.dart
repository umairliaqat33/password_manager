import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_model.freezed.dart';
part 'password_model.g.dart';

@freezed
class PasswordModel with _$PasswordModel {
  const factory PasswordModel({
    required String email,
    required String userName,
    required String password,
    required String website,
  }) = _PasswordModel;
  factory PasswordModel.fromJson(Map<String, dynamic> json) =>
      _$PasswordModelFromJson(json);
}
