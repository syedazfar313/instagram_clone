import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import '../models/dummy_data.dart';
import 'comments_sheet.dart';

class PostCard extends StatefulWidget {
  final DummyPost post;
  final int index;
  const PostCard({super.key, required this.post, this.index = 0});
  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard>
    with TickerProviderStateMixin {

  late AnimationController _heartCtrl;
  late Animation<double>   _heartScale;
  bool _showHeart = false;

  late AnimationController _fadeCtrl;
  late Animation<double>   _fadeAnim;
  late Animation<Offset>   _slideAnim;

  late AnimationController _likeCtrl;
  late Animation<double>   _likeScale;

  @override
  void initState() {
    super.initState();

    _heartCtrl  = AnimationController(vsync: this,
      duration: const Duration(milliseconds: 400));
    _heartScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _heartCtrl, curve: Curves.elasticOut));

    _fadeCtrl  = AnimationController(vsync: this,
      duration: const Duration(milliseconds: 500));
    _fadeAnim  = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut));
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06), end: Offset.zero).animate(
      CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut));

    _likeCtrl  = AnimationController(vsync: this,
      duration: const Duration(milliseconds: 180));
    _likeScale = Tween<double>(begin: 1, end: 1.3).animate(
      CurvedAnimation(parent: _likeCtrl, curve: Curves.easeOut));

    Future.delayed(Duration(milliseconds: widget.index * 80), () {
      if (mounted) _fadeCtrl.forward();
    });
  }

  @override
  void dispose() {
    _heartCtrl.dispose();
    _fadeCtrl.dispose();
    _likeCtrl.dispose();
    super.dispose();
  }

  void _doubleTap() async {
    setState(() { widget.post.isLiked = true; _showHeart = true; });
    _heartCtrl.forward(from: 0);
    _likeCtrl.forward().then((_) => _likeCtrl.reverse());
    await Future.delayed(const Duration(milliseconds: 900));
    if (mounted) setState(() => _showHeart = false);
  }

  void _like() {
    setState(() {
      widget.post.isLiked = !widget.post.isLiked;
      widget.post.likes  += widget.post.isLiked ? 1 : -1;
    });
    _likeCtrl.forward().then((_) => _likeCtrl.reverse());
  }

  void _save() => setState(() => widget.post.isSaved = !widget.post.isSaved);

  void _comments() => showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => CommentsSheet(post: widget.post));

  // Share sheet with Repost option
  void _share() => showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => _ShareSheet(post: widget.post));

  // Three dot menu
  void _moreMenu() => showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1C1C1C),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (_) => _PostMenuSheet(post: widget.post));

  String _fmt(int n) {
    if (n >= 1000000) return '${(n/1e6).toStringAsFixed(1)}M';
    if (n >= 1000)    return '${(n/1000).toStringAsFixed(1)}K';
    return '$n';
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.post;
    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          // ── Header ──────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.storyGradient),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black),
                  child: ClipOval(child: Image.network(p.avatar,
                    width: 32, height: 32, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                      Icon(Icons.person, color: AppColors.textSecondary))),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(p.username, style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700, fontSize: 13.5)),
                    const SizedBox(width: 4),
                    Text('• Follow', style: TextStyle(
                      color: AppColors.blue,
                      fontWeight: FontWeight.w600, fontSize: 13)),
                  ]),
                  Text(p.location,
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                ],
              )),
              GestureDetector(
                onTap: _moreMenu,
                child: Icon(Icons.more_horiz, color: AppColors.textPrimary)),
            ]),
          ),

          // ── Image ───────────────────────────
          GestureDetector(
            onDoubleTap: _doubleTap,
            child: Stack(alignment: Alignment.center, children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(p.image, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                    Container(color: AppColors.surface2),
                  loadingBuilder: (_, child, progress) => progress == null
                    ? child
                    : Container(color: AppColors.surface2,
                        child: Center(child: CircularProgressIndicator(
                          color: AppColors.textSecondary, strokeWidth: 1.5)))),
              ),
              if (_showHeart)
                ScaleTransition(scale: _heartScale,
                  child: const Icon(Icons.favorite,
                    color: Colors.white, size: 100,
                    shadows: [Shadow(blurRadius: 30, color: Colors.black54)])),
            ]),
          ),

          // ── Action Buttons ──────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(children: [

              // Like
              ScaleTransition(
                scale: _likeScale,
                child: IconButton(
                  onPressed: _like,
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    transitionBuilder: (child, anim) =>
                      ScaleTransition(scale: anim, child: child),
                    child: Icon(
                      p.isLiked ? Icons.favorite : Icons.favorite_border,
                      key: ValueKey(p.isLiked),
                      color: p.isLiked ? AppColors.red : AppColors.textPrimary,
                      size: 27)),
                ),
              ),

              // Comment
              IconButton(
                onPressed: _comments,
                icon: Icon(Icons.mode_comment_outlined,
                  color: AppColors.textPrimary, size: 27)),

              // Share/Repost
              IconButton(
                onPressed: _share,
                icon: Icon(Icons.near_me_outlined,
                  color: AppColors.textPrimary, size: 25)),

              const Spacer(),

              // Save
              IconButton(
                onPressed: _save,
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  transitionBuilder: (child, anim) =>
                    ScaleTransition(scale: anim, child: child),
                  child: Icon(
                    p.isSaved ? Icons.bookmark : Icons.bookmark_border,
                    key: ValueKey(p.isSaved),
                    color: AppColors.textPrimary, size: 27)),
              ),
            ]),
          ),

          // ── Likes ───────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text('${_fmt(p.likes)} likes',
                key: ValueKey(p.likes),
                style: TextStyle(color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700, fontSize: 13.5)),
            ),
          ),

          // ── Caption ─────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 2),
            child: RichText(text: TextSpan(children: [
              TextSpan(text: '${p.username} ',
                style: TextStyle(color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700, fontSize: 13.5)),
              TextSpan(text: p.caption,
                style: TextStyle(color: AppColors.textPrimary, fontSize: 13.5)),
            ])),
          ),

          // ── View Comments ────────────────────
          GestureDetector(
            onTap: _comments,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 3, 14, 2),
              child: Text('View all comments',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13.5)),
            ),
          ),

          // ── Time ────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 2, 14, 12),
            child: Text(p.time,
              style: TextStyle(color: AppColors.textSecondary,
                fontSize: 10, letterSpacing: 0.5)),
          ),

          Divider(color: AppColors.border, height: 0.5),
        ]),
      ),
    );
  }
}

// ── Share / Repost Sheet ────────────────────────────────────

class _ShareSheet extends StatelessWidget {
  final DummyPost post;
  const _ShareSheet({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1C),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(mainAxisSize: MainAxisSize.min, children: [

        // Handle
        Container(width: 36, height: 4,
          margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: AppColors.border,
            borderRadius: BorderRadius.circular(2))),

        // Send to friends row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(children: [
            Text('Send to',
              style: TextStyle(color: AppColors.textPrimary,
                fontWeight: FontWeight.w700, fontSize: 16)),
          ]),
        ),

        const SizedBox(height: 12),

        // Friends horizontal list
        SizedBox(height: 86,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 6,
            itemBuilder: (_, i) {
              final imgs = ['1','5','8','11','16','20'];
              final names = ['ahmed_k','sara','travel','hamza','nadia','usman'];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(children: [
                  ClipOval(child: Image.network(
                    'https://i.pravatar.cc/56?img=${imgs[i]}',
                    width: 56, height: 56, fit: BoxFit.cover)),
                  const SizedBox(height: 5),
                  Text(names[i], style: TextStyle(
                    color: AppColors.textPrimary, fontSize: 11)),
                ]),
              );
            },
          ),
        ),

        Divider(color: AppColors.border),

        // Share options
        _shareOption(context, Icons.repeat_rounded,
          'Repost',        'Share to your feed',   _repost),
        _shareOption(context, Icons.history_rounded,
          'Add to Story',  'Share as your story',  _addStory),
        _shareOption(context, Icons.bookmark_border_rounded,
          'Save Post',     'Add to your collection', _save),
        _shareOption(context, Icons.link_rounded,
          'Copy Link',     'Copy post link',        _copyLink),

        const SizedBox(height: 16),

        // Cancel
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: double.infinity, height: 46,
              decoration: BoxDecoration(
                color: AppColors.surface2,
                borderRadius: BorderRadius.circular(12)),
              alignment: Alignment.center,
              child: Text('Cancel', style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600, fontSize: 15)),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _shareOption(BuildContext context, IconData icon, String title,
      String subtitle, VoidCallback onTap) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      leading: Container(
        width: 44, height: 44,
        decoration: BoxDecoration(
          color: AppColors.surface2,
          borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: Colors.white, size: 22)),
      title: Text(title,
        style: TextStyle(color: AppColors.textPrimary,
          fontWeight: FontWeight.w600, fontSize: 14.5)),
      subtitle: Text(subtitle,
        style: TextStyle(color: AppColors.textSecondary, fontSize: 12.5)),
    );
  }

  void _repost()   {}
  void _addStory() {}
  void _save()     {}
  void _copyLink() {}
}

// ── Post Three Dot Menu ─────────────────────────────────────

class _PostMenuSheet extends StatelessWidget {
  final DummyPost post;
  const _PostMenuSheet({required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 36, height: 4,
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: AppColors.border,
          borderRadius: BorderRadius.circular(2))),

      _item(context, Icons.bookmark_border_rounded, 'Save',          false),
      _item(context, Icons.person_add_outlined,     'Follow',        false),
      _item(context, Icons.info_outline_rounded,    'About Account', false),
      _item(context, Icons.link_rounded,            'Copy Link',     false),
      _item(context, Icons.share_outlined,          'Share to...',   false),
      Divider(color: AppColors.border, height: 1),
      _item(context, Icons.report_outlined,         'Report',        true),
      _item(context, Icons.not_interested_rounded,  'Not Interested',true),
      const SizedBox(height: 16),
    ]);
  }

  Widget _item(BuildContext ctx, IconData icon, String label, bool isDanger) {
    return ListTile(
      onTap: () => Navigator.pop(ctx),
      leading: Icon(icon,
        color: isDanger ? AppColors.red : AppColors.textPrimary, size: 22),
      title: Text(label,
        style: TextStyle(
          color: isDanger ? AppColors.red : AppColors.textPrimary,
          fontSize: 15, fontWeight: FontWeight.w500)),
    );
  }
}