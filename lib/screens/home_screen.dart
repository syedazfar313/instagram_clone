import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'feed/feed_screen.dart';
import 'reels/reels_screen.dart';
import 'dm/dm_screen.dart';
import 'search/search_screen.dart';
import 'profile/profile_screen.dart';
import '../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _i = 0;

  // 2025 order: Home → Reels → DMs → Search → Profile
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const FeedScreen(),
      const ReelsScreen(),
      const DmScreen(),
      const SearchScreen(),
      const ProfileScreen(),
    ];
  }

  void _switchTab(int index) {
    if (_i == index) return;
    setState(() => _i = index);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        switchInCurve: Curves.easeOut,
        child: KeyedSubtree(
          key: ValueKey(_i),
          child: _screens[_i],
        ),
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: _i,
        onTap: _switchTab,
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const _BottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 0.3))),
      child: SafeArea(top: false,
        child: SizedBox(height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _item(0, Icons.home_rounded,       Icons.home_outlined,          'Home'),
              _item(1, Icons.play_circle_filled, Icons.play_circle_outline,    'Reels'),
              _item(2, Icons.send_rounded,       Icons.send_outlined,          'Messages'),
              _item(3, Icons.search_rounded,     Icons.search,                 'Search'),
              _profileItem(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(int index, IconData filled, IconData outlined, String label) {
    final active = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(width: 56, height: 56,
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            transitionBuilder: (child, anim) =>
              ScaleTransition(scale: anim, child: child),
            child: Icon(
              active ? filled : outlined,
              key: ValueKey(active),
              color: Colors.white,
              size: active ? 28 : 25),
          ),
        ),
      ),
    );
  }

  Widget _profileItem() {
    final active = currentIndex == 4;
    return GestureDetector(
      onTap: () => onTap(4),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(width: 56, height: 56,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: active ? 29 : 25,
            height: active ? 29 : 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: active
                ? Border.all(color: Colors.white, width: 2)
                : null),
            child: ClipOval(
              child: Image.network(
                'https://i.pravatar.cc/60?img=3',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                  Container(color: AppColors.surface2))),
          ),
        ),
      ),
    );
  }
}