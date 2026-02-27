import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../models/dummy_data.dart';
import 'story_viewer.dart';

class StoriesRow extends StatelessWidget {
  const StoriesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        itemCount: dummyStories.length + 1,
        itemBuilder: (_, i) => i == 0
          ? _yourStory()
          : _storyItem(context, dummyStories[i - 1]),
      ),
    );
  }

  Widget _yourStory() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(children: [
        Stack(children: [
          Container(
            width: 62, height: 62,
            decoration: const BoxDecoration(shape: BoxShape.circle,
              color: AppColors.surface2),
            child: ClipOval(child: Image.network(
              'https://i.pravatar.cc/62?img=3', fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                Icon(Icons.person, color: AppColors.textSecondary))),
          ),
          Positioned(bottom: 0, right: 0,
            child: Container(
              width: 20, height: 20,
              decoration: BoxDecoration(
                color: AppColors.blue, shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1.5)),
              child: const Icon(Icons.add, color: Colors.white, size: 13),
            )),
        ]),
        const SizedBox(height: 5),
        const Text('Your Story',
          style: TextStyle(color: Colors.white, fontSize: 10)),
      ]),
    );
  }

  Widget _storyItem(BuildContext ctx, DummyStory s) {
    return GestureDetector(
      onTap: () => Navigator.push(ctx, PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black,
        pageBuilder: (_, __, ___) => StoryViewer(story: s),
        transitionsBuilder: (_, anim, __, child) =>
          FadeTransition(opacity: anim, child: child),
      )),
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Column(children: [
          Container(
            width: 66, height: 66, padding: const EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: s.isSeen ? null : AppColors.storyGradient,
              color: s.isSeen ? AppColors.border : null,
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              child: ClipOval(child: Image.network(s.avatar, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                  Icon(Icons.person, color: AppColors.textSecondary))),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(width: 64,
            child: Text(s.username, textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 10))),
        ]),
      ),
    );
  }
}