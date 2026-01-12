import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:only_vocal/resources/user_provider.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../models/genre.dart';
import '../models/guidance_for_the_heart.dart';
import '../models/user.dart' as ModelUser;
import '../models/song.dart';
import 'genre_detail_screen.dart';
import 'full_player_screen.dart';
import 'guidance_for_the_heart_details.dart';
import 'search_screen.dart';
import 'features_screen.dart';
import '../components/colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final carouselImages=[
    'assets/carousel/one.png',
    'assets/carousel/two.png',
    'assets/carousel/three.png',
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    print('User:');
    print(user);
    final ModelUser.User? customUser = Provider.of<UserProvider>(context).getUser;

print('Heloooo');
if (customUser != null) {
  print("✅ Username: ${customUser.username}");
  print("✅ Email: ${customUser.email}");
} else {
  print("❌ Custom user is null");
}

print('Doneeee');

    return Scaffold(
      // backgroundColor: const Color(0xFF05152E),
      // backgroundColor: const Color(0xFFFCFCFC),
      backgroundColor: AppColors.background, 
      appBar: AppBar(
        // backgroundColor: const Color(0xFF05152E),
        backgroundColor: AppColors.background, 
        title: Text(
          'Qalberooh',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                // color: const Color.fromARGB(255, 156, 98, 167),
                // color: const Color(0xFFFCFCFC),
                color: AppColors.primary, 
              ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppColors.primary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    height:180,
                    autoPlay: true,
                    //reverse: true,
                    autoPlayInterval: Duration(seconds:4),
                    viewportFraction: 0.9
                  ),
                  itemCount:carouselImages.length,
                  itemBuilder: (context,index,realIndex){
                    final carouselImage=carouselImages[index];
                    return buildImage(carouselImage,index);
                  },
                )
                ,
              ),

              SizedBox(height:20),

              // Your Features Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Your Features',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FeaturesScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'View All',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              // color: const Color(0xFF2B90CA),
                              // color: const Color(0xFFFCFCFC),
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              SizedBox(
                height: 110,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFeatureItem(context, Icons.explore, 'Qibla'),
                    const SizedBox(width: 16),
                    _buildFeatureItem(context, Icons.pan_tool_alt, 'Duas'),
                    const SizedBox(width: 16),
                    _buildFeatureItem(context, Icons.bubble_chart, 'Tasbih'),
                    const SizedBox(width: 16),
                    _buildFeatureItem(context, Icons.menu_book, 'Journal'),
                  ],
                ),
              ),

              // Recently Played Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Recently Played',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: MockData.recentlyPlayed.length,
                  itemBuilder: (context, index) {
                    final song = MockData.recentlyPlayed[index];
                    return _buildRecentlyPlayedItem(context, song);
                  },
                ),
              ),

              // Genre Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Capella Songs',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: MockData.genres.length,
                  itemBuilder: (context, index) {
                    final genre = MockData.genres[index];
                    return _buildGenreItem(context, genre);
                  },
                ),
              ),

              // // Liked Songs Slider
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Text(
              //     'Your Favorites',
              //     style: Theme.of(context).textTheme.headlineSmall,
              //   ),
              // ),
              // SizedBox(
              //   height: 120,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.all(16.0),
              //     scrollDirection: Axis.horizontal,
              //     itemCount: MockData.likedSongs.length + 1, // +1 for "See All"
              //     itemBuilder: (context, index) {
              //       if (index == MockData.likedSongs.length) {
              //         return _buildSeeAllItem(context);
              //       }
              //       final song = MockData.likedSongs[index];
              //       return _buildLikedSongItem(context, song);
              //     },
              //   ),
              // ),


              // Genre Grid

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Guidance for the Heart',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: MockData.guidanceForTheHeart.length,
                  itemBuilder: (context, index) {
                    final genre = MockData.guidanceForTheHeart[index];
                    final guidanceForTheHeartList = MockData.guidanceForTheHeart[index];
                    return _buildGuidanceForTheHeart(context, guidanceForTheHeartList);
                  },
                ),
              ),
              // Bottom padding to account for mini player
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildImage(String carouselImage,int index)=>Container(
    margin:EdgeInsets.symmetric(horizontal:8),
    // color:Colors.grey,
    color: AppColors.darkGray,
    child:Image.asset(
      carouselImage,
      fit:BoxFit.cover,
    )
  );
  Widget _buildFeatureItem(BuildContext context, IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            // color: const Color(0xFF1A1E3F),
            // color: const Color(0xFF082149),
            // color: const Color(0xFF2B90CA),
            color: AppColors.primary, 
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppColors.background,
            // color: const Color(0xFF05152E),
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 72,
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            // style: Theme.of(context).textTheme.bodySmall?.copyWith(
            //       color: Colors.white.withOpacity(0.9),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textPrimary, 
                ),
          ),
        ),
      ],
    );
  }
  Widget _buildRecentlyPlayedItem(BuildContext context, Song song) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MusicAppScreen(song: song),
          ),
        );
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                song.albumArt,
                height: 100,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              song.title,
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              song.artist,
              // style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              //       color: Colors.white.withOpacity(0.7),
              //     ),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.lightGray,
            ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreItem(BuildContext context, Genre genre) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GenreDetailScreen(genre: genre),
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
              genre.color ?? Colors.transparent,
              (genre.color ?? Colors.transparent).withOpacity(0.7),
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
                    genre.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    genre.icon,
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    genre.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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

  Widget _buildGuidanceForTheHeart(BuildContext context, GuidanceForTheHeart guidanceForTheHeartList) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GuidanceForTheHeartDetails(guidanceForTheHeart: guidanceForTheHeartList),
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
              guidanceForTheHeartList.color ?? Colors.transparent,
              (guidanceForTheHeartList.color ?? Colors.transparent).withOpacity(0.7),
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
                    guidanceForTheHeartList.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    guidanceForTheHeartList.icon,
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    guidanceForTheHeartList.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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

  Widget _buildLikedSongItem(BuildContext context, Song song) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MusicAppScreen(song: song),
          ),
        );
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                song.albumArt,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeeAllItem(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1E3F),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_forward,
                // color: Color(0xFFFFD700),
                color: Color(0xFF2B90CA),
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
