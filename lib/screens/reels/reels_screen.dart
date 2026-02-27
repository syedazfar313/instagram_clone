import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../models/dummy_data.dart';
import '../../widgets/comments_sheet.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        title: const Text('Reels', style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
        actions: [
          IconButton(icon: const Icon(Icons.camera_alt_outlined, color: Colors.white),
            onPressed: () {})]),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: dummyReels.length,
        itemBuilder: (_, i) => _ReelItem(reel: dummyReels[i]),
      ),
    );
  }
}

class _ReelItem extends StatefulWidget {
  final DummyReel reel;
  const _ReelItem({required this.reel});
  @override
  State<_ReelItem> createState() => _ReelItemState();
}

class _ReelItemState extends State<_ReelItem>
    with SingleTickerProviderStateMixin {
  bool _liked = false;
  late AnimationController _disc;

  @override
  void initState() {
    super.initState();
    _disc = AnimationController(vsync: this,
      duration: const Duration(seconds: 4))..repeat();
  }

  @override
  void dispose() { _disc.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final r = widget.reel;
    return Stack(children: [

      Positioned.fill(child: Image.network(r.image, fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(color: AppColors.surface))),

      Positioned.fill(child: DecoratedBox(decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.transparent, Colors.black.withOpacity(0.85)],
          stops: const [0, 0.45, 1]),
      ))),

      // Right actions
      Positioned(right: 12, bottom: 110,
        child: Column(children: [

          // Avatar + follow
          Stack(clipBehavior: Clip.none, children: [
            ClipOval(child: Image.network(r.avatar, width: 46, height: 46, fit: BoxFit.cover)),
            Positioned(bottom: -8, left: 13,
              child: Container(width: 22, height: 22,
                decoration: BoxDecoration(color: AppColors.blue, shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2)),
                child: const Icon(Icons.add, color: Colors.white, size: 13))),
          ]),
          const SizedBox(height: 26),

          // Like
          GestureDetector(
            onTap: () => setState(() => _liked = !_liked),
            child: _sideBtn(
              _liked ? Icons.favorite : Icons.favorite_border,
              r.likes,
              color: _liked ? AppColors.red : Colors.white)),
          const SizedBox(height: 20),

          // Comment
          GestureDetector(
            onTap: () => showModalBottomSheet(context: context,
              isScrollControlled: true, backgroundColor: Colors.transparent,
              builder: (_) => CommentsSheet(post: dummyPosts[0])),
            child: _sideBtn(Icons.mode_comment_outlined, r.comments)),
          const SizedBox(height: 20),

          _sideBtn(Icons.near_me_outlined, 'Share'),
          const SizedBox(height: 20),
          Icon(Icons.more_horiz, color: Colors.white, size: 28),
        ]),
      ),

      // Bottom info
      Positioned(left: 14, right: 80, bottom: 80,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('@${r.username}', style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 5),
          Text(r.description, style: const TextStyle(
            color: Color(0xFFE0E0E0), fontSize: 13, height: 1.4)),
          const SizedBox(height: 8),
          Row(children: [
            const Icon(Icons.music_note, color: Colors.white, size: 14),
            const SizedBox(width: 6),
            Expanded(child: Text(r.music, overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFFCCCCCC), fontSize: 12))),
          ]),
        ]),
      ),

      // Spinning disc
      Positioned(right: 16, bottom: 28,
        child: RotationTransition(turns: _disc,
          child: Container(width: 38, height: 38,
            decoration: BoxDecoration(shape: BoxShape.circle,
              border: Border.all(color: Colors.white38, width: 2.5)),
            child: ClipOval(child: Image.network(r.avatar, fit: BoxFit.cover))))),
    ]);
  }

  Widget _sideBtn(IconData icon, String label, {Color color = Colors.white}) {
    return Column(children: [
      Icon(icon, color: color, size: 30),
      const SizedBox(height: 4),
      Text(label, style: TextStyle(
        color: color, fontSize: 12, fontWeight: FontWeight.w600)),
    ]);
  }
}