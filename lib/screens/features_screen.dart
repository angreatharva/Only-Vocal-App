import 'package:flutter/material.dart';
import 'package:only_vocal/components/colors.dart';

class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF05152E),
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Features',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                // color: const Color.fromARGB(255, 156, 98, 167),
                color: AppColors.primary,
              ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Divider(
              color: AppColors.background,
              thickness: 1, // Set thickness of the line
              height: 0, // No extra space above/below
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _Section(
                      title: 'Featured',
                      grid: const [
                        _GridItem('Ummah\nPro', Icons.forum_outlined),
                        _GridItem('Journal', Icons.menu_book_outlined),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      title: 'Deen',
                      grid: const [
                        _GridItem('Prayer\nTimes', Icons.access_time),
                        _GridItem('Quran', Icons.menu_book),
                        _GridItem('Tasbih', Icons.bubble_chart),
                        _GridItem('Qibla', Icons.explore),
                        _GridItem('Duas', Icons.pan_tool_alt),
                        _GridItem('Khatam', Icons.auto_stories),
                        _GridItem('Mosques', Icons.mosque),
                        _GridItem('Daily Deen', Icons.nights_stay),
                        _GridItem('Learn', Icons.psychology),
                        _GridItem('Immerse', Icons.headset),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      title: 'Community',
                      grid: const [
                        _GridItem('Quests', Icons.extension),
                        _GridItem('Deen\nMode', Icons.alarm),
                        _GridItem('Ask Rubina', Icons.smart_toy_outlined),
                        _GridItem('Qalbox', Icons.play_arrow),
                        _GridItem('Inspiration', Icons.lightbulb_outline),
                        _GridItem('Greeting\nMessages',
                            Icons.mark_email_read_outlined),
                        _GridItem('Ummah Pro', Icons.forum_outlined),
                        _GridItem('Blog', Icons.article_outlined),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      title: 'Utility',
                      grid: const [
                        _GridItem('Journal', Icons.menu_book_outlined),
                        _GridItem('Tracker', Icons.show_chart),
                        _GridItem('Calendar', Icons.calendar_today),
                        _GridItem('Zakat', Icons.calculate_outlined),
                        _GridItem('Shahadah', Icons.grid_view),
                        _GridItem('Names', Icons.translate),
                        _GridItem('Halal', Icons.ramen_dining),
                        _GridItem(
                            'Widgets', Icons.dashboard_customize_outlined),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      title: 'Hajj',
                      grid: const [
                        _GridItem('Makkah\nLive', Icons.play_circle_outline),
                        _GridItem('Hajj &\nUmrah', Icons.account_balance),
                        _GridItem('Hajj\nJourney', Icons.location_on_outlined),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    this.grid,
    this.chips,
  });

  final String title;
  final List<_GridItem>? grid;
  final List<_ChipItem>? chips;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 12),
        if (chips != null) _buildChips(context),
        if (grid != null) _buildGrid(context),
      ],
    );
  }

  Widget _buildChips(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: chips!
          .map((c) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  // color: const Color(0xFF1A1E3F),
                  // color: const Color(0xFF2B90CA),
                  // color: const Color(0xFF2B90CA),
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(24),
                ),
                constraints: const BoxConstraints(minHeight: 56),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(c.icon, size: 22, color: AppColors.background),
                    const SizedBox(width: 8),
                    Text(
                      c.label,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.background,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        mainAxisExtent: 75,
      ),
      itemCount: grid!.length,
      itemBuilder: (context, index) {
        final g = grid![index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            // color: const Color(0xFF1A1E3F),
            // color: const Color(0xFF082149),
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      g.label,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.background,
                      )
                    ),
                  ),
                  Icon(g.icon, size: 32, color: AppColors.background),
                  // color: const Color(0xFF05152E)
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GridItem {
  const _GridItem(this.label, this.icon);
  final String label;
  final IconData icon;
}

class _ChipItem {
  const _ChipItem(this.label, this.icon);
  final String label;
  final IconData icon;
}