import 'package:flutter/material.dart';
import 'guidance_category.dart';

class GuidanceForTheHeart {
  final String id;
  final String name;
  final Color color;
  final IconData icon;
  final String imageUrl;
  final List<String> videoUrls; // optional direct videos (unused if categories present)
  final List<GuidanceCategory> categories;

  GuidanceForTheHeart({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    required this.imageUrl,
    required this.videoUrls,
    this.categories = const [],
  });
}
