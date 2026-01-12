import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:only_vocal/components/colors.dart';

import '../data/mock_data.dart';
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
    print("_GuidanceForTheHeartDetailsScreen");
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
                  // child: Text(
                  //   'Categories',
                  //   style: Theme.of(context).textTheme.headlineSmall,
                  // ),
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
                    crossAxisCount: 1,
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
              color: widget.guidanceForTheHeart.color ?? Colors.transparent,
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
              widget.guidanceForTheHeart.color ?? Colors.transparent,
              (widget.guidanceForTheHeart.color ?? Colors.transparent).withOpacity(0.7),
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
    return _YouTubeTile(
      url: url,
      color: widget.guidanceForTheHeart.color ?? Colors.transparent,
      fallbackImage: widget.guidanceForTheHeart.imageUrl,
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
          crossAxisCount: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          final url = videoUrls[index];
          return _YouTubeTile(
            url: url,
            color: color,
            fallbackImage: fallbackImage,
          );
        },
      ),
    );
  }
}

class _YouTubeTile extends StatefulWidget {
  final String url;
  final Color color;
  final String fallbackImage;

  const _YouTubeTile({required this.url, required this.color, required this.fallbackImage});

  @override
  State<_YouTubeTile> createState() => _YouTubeTileState();
}

class _YouTubeTileState extends State<_YouTubeTile> {
  String _title = '';
  String? _thumbUrl;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    final cached = MockData.videoTitles[widget.url];
    if (cached != null && cached.isNotEmpty) {
      setState(() => _title = cached);
    } else {
      final fetched = await _fetchYouTubeTitle(widget.url);
      if (!mounted) return;
      if (fetched != null && fetched.isNotEmpty) {
        setState(() => _title = fetched);
        MockData.videoTitles[widget.url] = fetched;
      }
    }
    final videoId = _extractYouTubeId(widget.url);
    if (videoId != null) {
      setState(() => _thumbUrl = 'https://img.youtube.com/vi/$videoId/hqdefault.jpg');
    }
  }

  Future<String?> _fetchYouTubeTitle(String videoUrl) async {
    try {
      final Uri endpoint = Uri.parse('https://www.youtube.com/oembed?format=json&url=${Uri.encodeComponent(videoUrl)}');
      final res = await http.get(endpoint);
      if (res.statusCode == 200) {
        final data = json.decode(res.body) as Map<String, dynamic>;
        final dynamic t = data['title'];
        if (t is String) return t.trim();
      }
    } catch (_) {}
    return null;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: const Color(0xFF1A1E3F),
        color: AppColors.background,
        // color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewScreen(url: widget.url),
                ),
              );
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: _thumbUrl != null
                        ? Image.network(_thumbUrl!, fit: BoxFit.cover)
                        : Opacity(
                            opacity: 0.2,
                            child: Image.asset(
                              widget.fallbackImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                Positioned.fill(
                  child: IgnorePointer(
                    child: Center(
                      child: Icon(Icons.play_circle_fill, color: Colors.white.withOpacity(0.9), size: 48),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    _title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isLiked = !_isLiked;
                    });
                    if (_isLiked) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Added to liked'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Removed from liked'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  icon: Icon(_isLiked ? Icons.favorite : Icons.favorite_border),
                  color: _isLiked ? Colors.red : Colors.white,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

