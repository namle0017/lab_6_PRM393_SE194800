import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveMovieApp());
}

class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

const List<Movie> allMovies = [
  Movie(
    title: 'Inception',
    year: 2010,
    genres: ['Action', 'Sci-Fi', 'Thriller'],
    posterUrl:
        'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=500&auto=format&fit=crop&q=80',
    rating: 8.8,
  ),
  Movie(
    title: 'The Dark Knight',
    year: 2008,
    genres: ['Action', 'Crime', 'Drama'],
    posterUrl:
        'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=500&auto=format&fit=crop&q=80',
    rating: 9.0,
  ),
  Movie(
    title: 'Interstellar',
    year: 2014,
    genres: ['Adventure', 'Drama', 'Sci-Fi'],
    posterUrl:
        'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=500&auto=format&fit=crop&q=80',
    rating: 8.7,
  ),
  Movie(
    title: 'Pulp Fiction',
    year: 1994,
    genres: ['Crime', 'Drama'],
    posterUrl:
        'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=500&auto=format&fit=crop&q=80',
    rating: 8.9,
  ),
  Movie(
    title: 'Spirited Away',
    year: 2001,
    genres: ['Animation', 'Adventure', 'Fantasy'],
    posterUrl:
        'https://images.unsplash.com/photo-1578632767115-351597cf2477?w=500&auto=format&fit=crop&q=80',
    rating: 8.6,
  ),
  Movie(
    title: 'Parasite',
    year: 2019,
    genres: ['Comedy', 'Drama', 'Thriller'],
    posterUrl:
        'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?w=500&auto=format&fit=crop&q=80',
    rating: 8.5,
  ),
  Movie(
    title: 'Spider-Man: Into the Spider-Verse',
    year: 2018,
    genres: ['Animation', 'Action', 'Adventure'],
    posterUrl:
        'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?w=500&auto=format&fit=crop&q=80',
    rating: 8.4,
  ),
  Movie(
    title: 'The Grand Budapest Hotel',
    year: 2014,
    genres: ['Comedy', 'Adventure'],
    posterUrl:
        'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=500&auto=format&fit=crop&q=80',
    rating: 8.1,
  ),
  Movie(
    title: 'Whiplash',
    year: 2014,
    genres: ['Drama', 'Music'],
    posterUrl:
        'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=500&auto=format&fit=crop&q=80',
    rating: 8.5,
  ),
  Movie(
    title: 'Alien',
    year: 1979,
    genres: ['Horror', 'Sci-Fi'],
    posterUrl:
        'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=500&auto=format&fit=crop&q=80',
    rating: 8.5,
  ),
];

class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Genre Browser',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF000000),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE50914),
          onPrimary: Color(0xFFFFFFFF),
          surface: Color(0xFF000000),
          onSurface: Color(0xFFFFFFFF),
          surfaceContainerHighest: Color(0xFF232323),
          outline: Color(0xFF414141),
          outlineVariant: Color(0xFF2D2D2D),
          onSurfaceVariant: Color(0xFF808080),
        ),
        fontFamily: 'Arial',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontFamily: 'Times New Roman',
            fontWeight: FontWeight.w700,
            color: Color(0xFFFFFFFF),
          ),
          headlineSmall: TextStyle(
            fontFamily: 'Times New Roman',
            fontWeight: FontWeight.w700,
            color: Color(0xFFFFFFFF),
          ),
          titleMedium: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.w700,
            color: Color(0xFFFFFFFF),
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Arial',
            color: Color(0xFFFFFFFF),
          ),
          bodySmall: TextStyle(
            fontFamily: 'Arial',
            color: Color(0xFF808080),
          ),
        ),
      ),
      home: const GenreScreen(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const ResponsiveMovieApp();
}

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<String> _availableGenres = const [
    'Action',
    'Adventure',
    'Animation',
    'Comedy',
    'Crime',
    'Drama',
    'Fantasy',
    'Horror',
    'Music',
    'Sci-Fi',
    'Thriller',
  ];
  final Set<String> _selectedGenres = {};

  static const List<String> _sortOptions = ['A–Z', 'Z–A', 'Year', 'Rating'];
  String _selectedSort = 'A–Z';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Movie> _getVisibleMovies() {
    final filtered = allMovies.where((movie) {
      final matchesSearch = _searchQuery.trim().isEmpty ||
          movie.title.toLowerCase().contains(_searchQuery.trim().toLowerCase());

      final matchesGenre = _selectedGenres.isEmpty ||
          movie.genres.any((genre) => _selectedGenres.contains(genre));

      return matchesSearch && matchesGenre;
    }).toList();

    filtered.sort((a, b) {
      switch (_selectedSort) {
        case 'Z–A':
        case 'Z-A':
          return b.title.toLowerCase().compareTo(a.title.toLowerCase());
        case 'Year':
          final cmp = b.year.compareTo(a.year);
          return cmp != 0 ? cmp : a.title.compareTo(b.title);
        case 'Rating':
          final cmp = b.rating.compareTo(a.rating);
          return cmp != 0 ? cmp : a.title.compareTo(b.title);
        case 'A–Z':
        case 'A-Z':
        default:
          return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      }
    });

    return filtered;
  }

  void _clearAllFilters() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _selectedGenres.clear();
      _selectedSort = 'A–Z';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTabletOrWeb = screenWidth >= 800;
    final visibleMovies = _getVisibleMovies();
    final hasActiveFilters = _searchQuery.isNotEmpty ||
        _selectedGenres.isNotEmpty ||
        _selectedSort != 'A–Z';

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTabletOrWeb ? 32.0 : 16.0,
            vertical: 12.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeadingSection(theme, isTabletOrWeb),
              const SizedBox(height: 12),
              _buildGradientLine(),
              const SizedBox(height: 16),
              _buildSearchBar(theme),
              const SizedBox(height: 14),
              _buildGenreChips(theme),
              const SizedBox(height: 12),
              _buildSortAndCountBar(theme, visibleMovies.length, hasActiveFilters),
              const SizedBox(height: 10),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (visibleMovies.isEmpty) {
                      return _buildEmptyState(theme);
                    }

                    final isWideView = constraints.maxWidth >= 800;

                    if (isWideView) {
                      final itemWidth = (constraints.maxWidth - 16) / 2;
                      const desiredCardHeight = 175.0;
                      final computedAspectRatio = itemWidth / desiredCardHeight;

                      return GridView.count(
                        key: const ValueKey('movie_grid_tablet'),
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: computedAspectRatio,
                        children: visibleMovies
                            .map((movie) => MovieCard(movie: movie))
                            .toList(),
                      );
                    } else {
                      return ListView.builder(
                        key: const ValueKey('movie_list_phone'),
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: MovieCard(movie: visibleMovies[index]),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeadingSection(ThemeData theme, bool isTabletOrWeb) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find a Movie',
                style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontWeight: FontWeight.w700,
                  fontSize: isTabletOrWeb ? 38 : 28,
                  color: const Color(0xFFFFFFFF),
                  letterSpacing: -0.5,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Browse and filter films across your favorite genres',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 14,
                  color: Color(0xFF808080),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF232323),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFF414141), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFFE50914),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                isTabletOrWeb ? 'Tablet / Web' : 'Phone View',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'Arial',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGradientLine() {
    return Container(
      height: 2,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF132144),
            Color(0xFFE50914),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFF414141),
          width: 1,
        ),
      ),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 15,
          fontFamily: 'Arial',
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Search by movie title...',
          hintStyle: const TextStyle(
            color: Color(0xFF808080),
            fontSize: 14,
            fontFamily: 'Arial',
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFFE50914),
            size: 20,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Color(0xFF808080),
                    size: 18,
                  ),
                  tooltip: 'Clear search',
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildGenreChips(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Genres',
              style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(0xFFFFFFFF),
              ),
            ),
            const SizedBox(width: 8),
            if (_selectedGenres.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE50914),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${_selectedGenres.length}',
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
                  ),
                ),
              ),
            const Spacer(),
            if (_selectedGenres.isNotEmpty)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedGenres.clear();
                  });
                },
                child: const Text(
                  'Reset Genres',
                  style: TextStyle(
                    color: Color(0xFF808080),
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    fontFamily: 'Arial',
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _availableGenres.map((genre) {
            final isSelected = _selectedGenres.contains(genre);
            return FilterChip(
              label: Text(genre),
              selected: isSelected,
              showCheckmark: isSelected,
              checkmarkColor: const Color(0xFFFFFFFF),
              backgroundColor: const Color(0xFF232323),
              selectedColor: const Color(0xFFE50914),
              labelStyle: TextStyle(
                color: const Color(0xFFFFFFFF),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 12,
                fontFamily: 'Arial',
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(
                  color: isSelected
                      ? const Color(0xFFE50914)
                      : const Color(0xFF414141),
                  width: 1,
                ),
              ),
              elevation: 0,
              pressElevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              visualDensity: VisualDensity.compact,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedGenres.add(genre);
                  } else {
                    _selectedGenres.remove(genre);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSortAndCountBar(
      ThemeData theme, int count, bool hasActiveFilters) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                '$count found',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color(0xFF808080),
                  fontFamily: 'Arial',
                ),
              ),
              if (hasActiveFilters) ...[
                const SizedBox(width: 8),
                InkWell(
                  onTap: _clearAllFilters,
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE50914),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Clear all',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.sort_rounded,
              size: 16,
              color: Color(0xFFE50914),
            ),
            const SizedBox(width: 4),
            const Text(
              'Sort:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Color(0xFF808080),
                fontFamily: 'Arial',
              ),
            ),
            const SizedBox(width: 6),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedSort,
                isDense: true,
                dropdownColor: const Color(0xFF232323),
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFFE50914),
                  size: 18,
                ),
                items: _sortOptions.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(
                      option,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'Arial',
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedSort = newValue;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.movie_filter_outlined,
              size: 64,
              color: Color(0xFF414141),
            ),
            const SizedBox(height: 16),
            const Text(
              'No movies found',
              style: TextStyle(
                fontFamily: 'Times New Roman',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Try adjusting your search query or removing some genre filters.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: Color(0xFF808080),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _clearAllFilters,
              icon: const Icon(Icons.refresh_rounded, size: 18, color: Colors.white),
              label: const Text(
                'Reset Filters',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Arial',
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE50914),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideCard = constraints.maxWidth >= 450;
        final posterWidth = isWideCard ? 130.0 : 105.0;
        final cardHeight = isWideCard ? 175.0 : 150.0;

        return Card(
          elevation: 0,
          color: const Color(0xFF232323),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Color(0xFF333333),
              width: 1,
            ),
          ),
          child: SizedBox(
            height: cardHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: posterWidth,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        movie.posterUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: const Color(0xFF181818),
                            child: const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xFFE50914),
                                ),
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF141414),
                                  Color(0xFF232323),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.movie_rounded,
                                size: 36,
                                color: Color(0xFFE50914),
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: 6,
                        left: 6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFF000000).withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: const Color(0xFF414141),
                              width: 0.5,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 13,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                movie.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Arial',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isWideCard ? 16 : 14,
                                color: const Color(0xFFFFFFFF),
                                fontFamily: 'Arial',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_rounded,
                                  size: 12,
                                  color: Color(0xFF808080),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${movie.year}',
                                  style: const TextStyle(
                                    color: Color(0xFF808080),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: movie.genres.map((genre) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFF161616),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: const Color(0xFF414141),
                                  width: 0.8,
                                ),
                              ),
                              child: Text(
                                genre,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'Arial',
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
