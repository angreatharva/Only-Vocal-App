import 'package:flutter/material.dart';
import '../models/guidance_for_the_heart.dart';
import '../models/guidance_category.dart';
import '../models/song.dart';
import '../models/genre.dart';

class MockData {
  static Map<String, String> videoTitles = {
    // 'https://youtu.be/ITarXSw7Zhg?si=j_KfkIVrfMNuL78n': 'Example title here',
  };
  static List<Song> recentlyPlayed = [
  Song(
    id: 0,
    title: 'Levitating',
    artist: 'Dua Lipa',
    album: 'Future Nostalgia',
    albumArt: 'assets/thumbnails/levitating.jpeg',
    audioURL: 'audio/levitating.mp3',
    isLiked: true,
  ),
  Song(
    id: 1,
    title: 'As It Was',
    artist: 'Harry Styles',
    album: 'Harry’s House',
    albumArt: 'assets/thumbnails/as_it_was.jpeg',
    audioURL: 'audio/as-it-was.mp3',
  ),
  Song(
    id: 2,
    title: 'Shake It Off',
    artist: 'Taylor Swift',
    album: '1989',
    albumArt: 'assets/thumbnails/shake_it_off.jpeg',
    audioURL: 'audio/levitating.mp3',
  ),
  Song(
    id: 3,
    title: 'SICKO MODE',
    artist: 'Travis Scott',
    album: 'ASTROWORLD',
    albumArt: 'assets/thumbnails/sicko_mode.jpeg',
    audioURL: 'audio/sicko-mode.mp3',
    isLiked: true,
  ),
  Song(
    id: 4,
    title: 'Lose Yourself',
    artist: 'Eminem',
    album: '8 Mile',
    albumArt: 'assets/thumbnails/lose_yourself.jpeg',
    audioURL: 'audio/lose-yourself.mp3',
    isLiked: true,
  ),
  Song(
    id: 5,
    title: 'HUMBLE.',
    artist: 'Kendrick Lamar',
    album: 'DAMN.',
    albumArt: 'assets/thumbnails/humble.jpeg',
    audioURL: 'audio/humble.mp3',
  ),
  Song(
    id: 6,
    title: 'Summertime',
    artist: 'Ella Fitzgerald & Louis Armstrong',
    album: 'Porgy and Bess',
    albumArt: 'assets/thumbnails/summertime.jpeg',
    audioURL: 'audio/summertime.mp3',
    isLiked: true,
  ),
  Song(
    id: 7,
    title: 'My Favourite Things',
    artist: 'John Coltrane',
    album: 'My Favorite Things',
    albumArt: 'assets/thumbnails/my_favourite.jpeg',
    audioURL: 'audio/levitating.mp3',

  ),
  Song(
    id: 8,
    title: 'So What',
    artist: 'Miles Davis',
    album: 'Kind of Blue',
    albumArt: 'assets/thumbnails/so_what.jpeg',
    audioURL: 'audio/levitating.mp3',

  ),
  Song(
    id: 9,
    title: 'Bohemian Rhapsody',
    artist: 'Queen',
    album: 'A Night at the Opera',
    albumArt: 'assets/thumbnails/bohemian.jpeg',
    audioURL: 'audio/bohemian.mp3',
    isLiked: true,
  ),
  Song(
    id: 10,
    title: 'In The End',
    artist: 'Linkin Park',
    album: 'Hybrid Theory',
    albumArt: 'assets/thumbnails/in_the_end.jpeg',
    audioURL: 'audio/in-the-end.mp3',
  ),
  Song(
    id: 11,
    title: 'Back In Black',
    artist: 'AC/DC',
    album: 'Back In Black',
    albumArt: 'assets/thumbnails/back_in_black.jpeg',
    audioURL: 'audio/levitating.mp3',
  ),
];

static List<Song> likedSongs = [
  recentlyPlayed[0],  // Levitating
  recentlyPlayed[3],  // SICKO MODE
  recentlyPlayed[6],  // Summertime
  recentlyPlayed[9],  // Bohemian Rhapsody
];


  static List<Genre> genres = [
    // Genre(
    //   id: 'pop',
    //   name: 'Pop',
    //   color: const Color.fromRGBO(115, 30, 233, 1),
    //   icon: Icons.music_note,
    //   imageUrl: 'assets/genres/pop.png',
    // ),
    // Genre(
    //   id: 'rock',
    //   name: 'Rock',
    //   color: Colors.red,
    //   icon: Icons.music_note,
    //   imageUrl: 'assets/genres/rock.png',
    // ),
    // Genre(
    //   id: 'hiphop',
    //   name: 'Hip-Hop',
    //   color: Colors.purple,
    //   icon: Icons.headphones,
    //   imageUrl: 'assets/genres/hiphop.jpeg',
    // ),
    // Genre(
    //   id: 'electronic',
    //   name: 'Electronic',
    //   color: Colors.cyan,
    //   icon: Icons.electric_bolt,
    //   imageUrl: 'assets/genres/electronic.jpeg',
    // ),
    // Genre(
    //   id: 'rnb',
    //   name: 'R&B',
    //   color: Colors.blue,
    //   icon: Icons.piano,
    //   imageUrl: 'assets/genres/rb.jpeg',
    // ),
    // Genre(
    //   id: 'country',
    //   name: 'Country',
    //   color: Colors.orange,
    //   icon: Icons.agriculture,
    //   imageUrl: 'assets/genres/country.jpeg',
    // ),
    // Genre(
    //   id: 'jazz',
    //   name: 'Jazz',
    //   color: Colors.amber,
    //   icon: Icons.music_note,
    //   imageUrl: 'assets/genres/jazz.jpeg',
    // ),
    // // Genre(
    // //   id: 'classical',
    // //   name: 'Classical',
    // //   color: Colors.grey,
    // //   icon: Icons.piano,
    // //   imageUrl: 'https://via.placeholder.com/300/C0C0C0/000000?text=Classical',
    // // ),
    // Genre(
    //   id: 'rap',
    //   name: 'Rap',
    //   color: Colors.green,
    //   icon: Icons.album,
    //   imageUrl: 'assets/genres/rap.png',
    // ),
    // // Genre(
    // //   id: 'metal',
    // //   name: 'Metal',
    // //   color: Colors.grey.shade800,
    // //   icon: Icons.music_note,
    // //   imageUrl: 'https://via.placeholder.com/300/333333/FFFFFF?text=Metal',
    // // ),

    //New genres
    Genre(
      id: 'bollywood',
      name: 'Bollywood',
      color: Colors.green,
      icon: Icons.album,
      imageUrl: 'assets/genres/country.jpeg',
    ),
    Genre(
      id: 'hollywood',
      name: 'Hollywood',
      color: Colors.red,
      icon: Icons.album,
      imageUrl: 'assets/genres/electronic.jpeg',
    ),Genre(
      id: 'artist',
      name: 'Artist',
      color: Colors.blue,
      icon: Icons.album,
      imageUrl: 'assets/genres/rap.png',
    ),
  ];

  static List<GuidanceForTheHeart> guidanceForTheHeart = [
    GuidanceForTheHeart(
      id: 'scholars_corner',
      name: 'Scholar\'s Corner' ,
      color: Colors.lightGreen,
      icon: Icons.album,
      imageUrl: 'assets/genres/electronic.jpeg',
      videoUrls: [
        'https://youtu.be/ITarXSw7Zhg?si=j_KfkIVrfMNuL78n',
        'https://youtu.be/arp0eBn1nG8?si=vbNb1s-JD56TuX6x',
        'https://www.youtube.com/live/qaF6jyXbIsk',
        'https://youtu.be/LhezSOSnOEM?si=fs0gvYSErAIWSBWa',
      ],
      categories: const [],
    ),
    GuidanceForTheHeart(
      id: 'little_muslim',
      name: 'Little Muslim',
      color: Colors.yellow,
      icon: Icons.album,
      imageUrl: 'assets/genres/jazz.jpeg',
      videoUrls: [],
      categories: [
        GuidanceCategory(
            id: 'quran_stories',
            name: 'Quran Stories',
            videoUrls: [

            ]
        ),
        GuidanceCategory(
            id: 'nasheeds_for_kids',
            name: 'Nasheeds for Kids',
            videoUrls: [
              'https://youtu.be/AwW8s_r4g4w?si=X-ev5u8MtoteoCNd',
              'https://youtu.be/7fyAtfGytGk?si=-ZyzeFRV3G_bOKDX',
              'https://youtu.be/T3DuAFu2ZoY?si=ydqNJ1VXx68ps_si',
              'https://youtu.be/mQwgJ2-9lVI?si=7aQdKcKV6YumMlgL',
              'https://youtu.be/EmyuGk9GmKk?si=t82GPfzBt6VN6xKM',
            ]
        ),
        GuidanceCategory(
            id: 'fun_learning',
            name: 'Fun Learning',
            videoUrls: [
              'https://youtu.be/v3oRq32Ruzo?si=xEsTby5ehnL7tsJN',
              'https://youtu.be/d2D6WuKlymM?si=b40xcGgdgDLZXIAr',
              'https://youtu.be/u2e2Uk4qEXs?si=dJNTdhWypNUAgFkb',
              'https://youtu.be/JbfEZMdgZ_A?si=m-EQzio0Vm_1ZlEb',
              'https://youtu.be/xxnZuAHCAjY?si=_9GuDvch7k1IGSka',
            ]
        ),
        GuidanceCategory(
            id: 'dua_adab',
            name: 'Dua & Adab',
            videoUrls: [
            ]
        ),
      ],
    ),
    GuidanceForTheHeart(
      id: 'islamicLifestyle',
      name: 'Islamic Lifestyle',
      color: Colors.blue,
      icon: Icons.album,
      imageUrl: 'assets/genres/pop.png',
      videoUrls: [],
      categories: [
        GuidanceCategory(
            id: 'sunnah_beauty',
            name: 'Sunnah beauty',
            videoUrls: [
              'https://youtu.be/MrVQn2FK1KI?si=Cin_ON0y1Q_i6vBx',
              'https://youtu.be/Izr5r4TrWOs?si=zWLVXB3iPqhUTrLJ',
              'https://youtu.be/45kpQgUR_lg?si=hGu98-Kk8Tja2G6s',
            ]
        ),
        GuidanceCategory(
            id: 'sunnah_daily_routine',
            name: 'Sunnah in daily routine',
            videoUrls: [
              'https://youtu.be/GYkVMNLscw0?si=qb1GmWU8zYOFpFN4',
              'https://youtu.be/MLlGt24Yv1s?si=7yMoZOMF0DQKmeU-',
              'https://youtu.be/-ZSxXF79r3g?si=jLOR6kEZrlpEJto4',
              'https://youtu.be/Ht1qrhJBcAk?si=tisHoFhx_OX1hvgW',
            ]
        ),
      ],
    ),
  ];

  static List<Song> genreSongs(String genreId) {
    // Return a list of songs for a specific genre
    return List.generate(
      20,
      (index) => Song(
        id: index,
        title: 'Song ${index + 1}',
        artist: 'Artist ${index % 5 + 1}',
        album: 'Album ${index % 3 + 1}',
        // albumArt: 'https://via.placeholder.com/300/1A1E3F/FFFFFF?text=Song+${index + 1}',
        albumArt: 'assets/images/song.jpeg',
        audioURL: 'audio/levitating.mp3',
        isLiked: index % 3 == 0,
      ),
    );
  }

  static Song currentlyPlaying = Song(
    id: 8,
    title: 'So What',
    artist: 'Miles Davis',
    album: 'Kind of Blue',
    albumArt: 'assets/thumbnails/so_what.jpeg',
    audioURL: 'audio/levitating.mp3',
  );
}
