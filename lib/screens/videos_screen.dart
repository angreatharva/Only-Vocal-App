import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/guidance_for_the_heart.dart';
import 'guidance_for_the_heart_details.dart';
import '../components/colors.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<GuidanceForTheHeart> items = MockData.guidanceForTheHeart;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Videos',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        // backgroundColor: const Color(0xFF1A1E3F),
        backgroundColor: AppColors.background,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _GuidanceCard(item: item);
        },
      ),
    );
  }
}

class _GuidanceCard extends StatelessWidget {
  final GuidanceForTheHeart item;

  const _GuidanceCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                GuidanceForTheHeartDetails(guidanceForTheHeart: item),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              item.color ?? Colors.transparent,
              (item.color ?? Colors.transparent).withOpacity(0.7),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Opacity(
                  opacity: 0.25,
                  child: Image.asset(
                    item.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.play_circle_fill,
                      size: 32, color: Colors.white.withOpacity(0.9)),
                  const Spacer(),
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
