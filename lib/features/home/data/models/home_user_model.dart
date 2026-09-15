import 'package:flutter/foundation.dart';

@immutable
class HomeUserModel {
  final String name;
  final String profileImageUrl;

  const HomeUserModel({required this.name, this.profileImageUrl = ''});
}
