import 'package:flutter/material.dart';

class GuidanceCategory {
  final String id;
  final String name;
  final List<String> videoUrls;
  final IconData? icon;

  GuidanceCategory({
    required this.id,
    required this.name,
    required this.videoUrls,
    this.icon,
  });
}


