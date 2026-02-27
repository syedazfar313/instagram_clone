import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../models/dummy_data.dart';
import '../../widgets/story_widget.dart';
import '../../widgets/post_card.dart';
import '../upload/upload_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: RefreshIndicator(
        color: AppColors.blue,
        backgroundColor: AppColors.surface2,
        onRefresh: _onRefresh,
        child: ListView(children: [
          const StoriesRow(),
          Divider(color: AppColors.border, height: 0.5),
          ...dummyPosts.asMap().entries.map((e) =>
            PostCard(post: e.value, index: e.key)),
          const SizedBox(height: 80),
        ]),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      // 2025: + icon top LEFT
      leading: GestureDetector(
        onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const UploadScreen())),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border, width: 1.5),
              borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.add, color: Colors.white, size: 18)),
        ),
      ),
      // 2025: Username/Logo center
      title: const Text('Instagram',
        style: TextStyle(
          fontSize: 24, color: Colors.white,
          fontWeight: FontWeight.w500, letterSpacing: 0.3)),
      centerTitle: true,
      // 2025: Heart (Activity) top RIGHT
      actions: [
        IconButton(
          icon: Icon(Icons.favorite_border_rounded,
            color: Colors.white, size: 26),
          onPressed: () {}),
      ],
    );
  }
}