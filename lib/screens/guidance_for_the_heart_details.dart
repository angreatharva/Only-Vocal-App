import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/genre.dart';
import '../models/guidance_for_the_heart.dart';
import '../models/guidance_category.dart';
import 'webview_screen.dart';

class GuidanceForTheHeartDetails extends StatefulWidget {
  final GuidanceForTheHeart guidanceForTheHeart;

  const GuidanceForTheHeartDetails({super.key,required this.guidanceForTheHeart});

  @override
  State<GuidanceForTheHeartDetails> createState() => _GuidanceForTheHeartDetailsState();
}

class _GuidanceForTheHeartDetailsState extends State<GuidanceForTheHeartDetails> {

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(


        body: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: widget.guidanceForTheHeart.color,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.guidanceForTheHeart.name,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      widget.guidanceForTheHeart.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.guidanceForTheHeart.categories.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Categories',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            if (widget.guidanceForTheHeart.categories.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final cat = widget.guidanceForTheHeart.categories[index];
                      return _buildCategoryTile(context, cat);
                    },
                    childCount: widget.guidanceForTheHeart.categories.length,
                  ),
                ),
              ),
            if (widget.guidanceForTheHeart.categories.isEmpty)
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final url = widget.guidanceForTheHeart.videoUrls[index];
                      return _buildVideoTile(context, url, index);
                    },
                    childCount: widget.guidanceForTheHeart.videoUrls.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  Widget _buildCategoryTile(BuildContext context, GuidanceCategory cat) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _CategoryDetailsScreen(
              title: cat.name,
              color: widget.guidanceForTheHeart.color,
              fallbackImage: widget.guidanceForTheHeart.imageUrl,
              videoUrls: cat.videoUrls,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.guidanceForTheHeart.color,
              widget.guidanceForTheHeart.color.withOpacity(0.7),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    widget.guidanceForTheHeart.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  cat.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildVideoTile(BuildContext context, String url, int index) {
    final videoId = _extractYouTubeId(url);
    final thumbUrl = videoId != null
        ? 'https://img.youtube.com/vi/$videoId/hqdefault.jpg'
        : null;
    final title = MockData.videoTitles[url] ?? 'Video ${index + 1}';
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(url: url, title: title),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.guidanceForTheHeart.color,
              widget.guidanceForTheHeart.color.withOpacity(0.7),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: thumbUrl != null
                    ? Image.network(thumbUrl, fit: BoxFit.cover)
                    : Opacity(
                        opacity: 0.2,
                        child: Image.asset(
                          widget.guidanceForTheHeart.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),
            Center(
              child: Icon(Icons.play_circle_fill, color: Colors.white.withOpacity(0.9), size: 48),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _extractYouTubeId(String url) {
    try {
      final uri = Uri.parse(url);
      if (uri.host.contains('youtu.be')) {
        return uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;
      }
      if (uri.host.contains('youtube.com')) {
        if (uri.path == '/watch') {
          return uri.queryParameters['v'];
        }
        if (uri.pathSegments.contains('embed')) {
          return uri.pathSegments.last;
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }

}

class _CategoryDetailsScreen extends StatelessWidget {
  final String title;
  final Color color;
  final String fallbackImage;
  final List<String> videoUrls;

  const _CategoryDetailsScreen({
    required this.title,
    required this.color,
    required this.fallbackImage,
    required this.videoUrls,
  });

  String? _extractYouTubeId(String url) {
    try {
      final uri = Uri.parse(url);
      if (uri.host.contains('youtu.be')) {
        return uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;
      }
      if (uri.host.contains('youtube.com')) {
        if (uri.path == '/watch') {
          return uri.queryParameters['v'];
        }
        if (uri.pathSegments.contains('embed')) {
          return uri.pathSegments.last;
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          final url = videoUrls[index];
          final videoId = _extractYouTubeId(url);
          final thumbUrl = videoId != null ? 'https://img.youtube.com/vi/$videoId/hqdefault.jpg' : null;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewScreen(url: url, title: MockData.videoTitles[url] ?? '$title • Video ${index + 1}'),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color,
                    color.withOpacity(0.7),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: thumbUrl != null
                          ? Image.network(thumbUrl, fit: BoxFit.cover)
                          : Opacity(
                              opacity: 0.2,
                              child: Image.asset(
                                fallbackImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  Center(
                    child: Icon(Icons.play_circle_fill, color: Colors.white.withOpacity(0.9), size: 48),
                  ),
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: Text(
                      'Video ${index + 1}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

