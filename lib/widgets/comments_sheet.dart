import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../models/dummy_data.dart';

class CommentsSheet extends StatefulWidget {
  final DummyPost post;
  const CommentsSheet({super.key, required this.post});
  @override
  State<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<CommentsSheet> {
  final _ctrl        = TextEditingController();
  final _focusNode   = FocusNode();
  String? _replyingTo;

  final List<Map<String, dynamic>> _comments = [
    {
      'u': 'ali_photo',
      'text': 'Absolutely stunning shot! 🔥',
      'time': '2h',
      'av': 'https://i.pravatar.cc/40?img=5',
      'likes': 24,
      'liked': false,
      'replies': [
        {'u': 'sara.life', 'text': 'Totally agree! 😍', 'time': '1h',
         'av': 'https://i.pravatar.cc/40?img=11', 'likes': 5, 'liked': false},
      ],
      'showReplies': false,
    },
    {
      'u': 'sara.life',
      'text': 'Where was this taken? Pakistan is so beautiful 🏔️',
      'time': '4h',
      'av': 'https://i.pravatar.cc/40?img=11',
      'likes': 12,
      'liked': false,
      'replies': [],
      'showReplies': false,
    },
    {
      'u': 'travel_lover',
      'text': 'Goals! 🌴✨ Adding this to my bucket list ASAP',
      'time': '6h',
      'av': 'https://i.pravatar.cc/40?img=15',
      'likes': 8,
      'liked': true,
      'replies': [],
      'showReplies': false,
    },
    {
      'u': 'hamza_pk',
      'text': 'Mashallah yaar kia shot hai 🤩 Camera konsa use kiya?',
      'time': '8h',
      'av': 'https://i.pravatar.cc/40?img=22',
      'likes': 31,
      'liked': false,
      'replies': [
        {'u': 'your_username', 'text': 'Sony A7III hai bhai 📸',
         'time': '7h', 'av': 'https://i.pravatar.cc/40?img=3',
         'likes': 9, 'liked': false},
      ],
      'showReplies': false,
    },
    {
      'u': 'nadia.arts',
      'text': 'The lighting is just perfect here 🎨',
      'time': '10h',
      'av': 'https://i.pravatar.cc/40?img=16',
      'likes': 6,
      'liked': false,
      'replies': [],
      'showReplies': false,
    },
  ];

  @override
  void dispose() {
    _ctrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _postComment() {
    if (_ctrl.text.trim().isEmpty) return;
    setState(() {
      _comments.insert(0, {
        'u': 'your_username',
        'text': _ctrl.text.trim(),
        'time': 'Just now',
        'av': 'https://i.pravatar.cc/40?img=3',
        'likes': 0,
        'liked': false,
        'replies': [],
        'showReplies': false,
      });
      _ctrl.clear();
      _replyingTo = null;
    });
  }

  void _startReply(String username) {
    setState(() => _replyingTo = username);
    _ctrl.text = '@$username ';
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (_, sc) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C1C),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        child: Column(children: [

          // Handle bar
          Container(
            width: 36, height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2))),

          // Title row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              const Spacer(),
              Text('Comments',
                style: TextStyle(color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700, fontSize: 15)),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.close, color: AppColors.textSecondary, size: 22)),
            ]),
          ),

          const SizedBox(height: 10),
          Divider(color: AppColors.border, height: 0.5),

          // Comments list
          Expanded(
            child: ListView.builder(
              controller: sc,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _comments.length,
              itemBuilder: (_, i) => _commentTile(i),
            ),
          ),

          // Reply indicator
          if (_replyingTo != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: AppColors.surface2,
              child: Row(children: [
                Text('Replying to ',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                Text('@$_replyingTo',
                  style: TextStyle(color: AppColors.blue,
                    fontWeight: FontWeight.w600, fontSize: 13)),
                const Spacer(),
                GestureDetector(
                  onTap: () => setState(() {
                    _replyingTo = null;
                    _ctrl.clear();
                  }),
                  child: Icon(Icons.close, color: AppColors.textSecondary, size: 18)),
              ]),
            ),

          Divider(color: AppColors.border, height: 0.5),

          // Input bar
          Container(
            padding: EdgeInsets.only(
              left: 12, right: 12, top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16),
            color: const Color(0xFF1C1C1C),
            child: Row(children: [
              ClipOval(child: Image.network(
                'https://i.pravatar.cc/36?img=3',
                width: 36, height: 36, fit: BoxFit.cover)),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: AppColors.surface2,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: AppColors.border, width: 0.5)),
                  child: Row(children: [
                    Expanded(child: TextField(
                      controller: _ctrl,
                      focusNode: _focusNode,
                      style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        hintStyle: TextStyle(color: AppColors.textSecondary),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 10)),
                    )),
                    // Emoji button
                    GestureDetector(
                      onTap: () {},
                      child: Text('😊', style: const TextStyle(fontSize: 18))),
                  ]),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: _postComment,
                child: Text('Post',
                  style: TextStyle(color: AppColors.blue,
                    fontWeight: FontWeight.w700, fontSize: 14))),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _commentTile(int i) {
    final c = _comments[i];
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        // Main comment row
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Avatar
          ClipOval(child: Image.network(c['av'],
            width: 38, height: 38, fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
              CircleAvatar(backgroundColor: AppColors.surface2, radius: 19))),
          const SizedBox(width: 10),

          // Comment content
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Name + text bubble
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: const BorderRadius.only(
                    topRight:    Radius.circular(14),
                    bottomLeft:  Radius.circular(14),
                    bottomRight: Radius.circular(14))),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c['u'],
                      style: TextStyle(color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700, fontSize: 13.5)),
                    const SizedBox(height: 3),
                    Text(c['text'],
                      style: const TextStyle(
                        color: Color(0xFFE8E8E8), fontSize: 14, height: 1.4)),
                  ]),
              ),

              // Action row: time, like, reply
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: Row(children: [
                  Text(c['time'],
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  const SizedBox(width: 14),
                  GestureDetector(
                    onTap: () => _startReply(c['u']),
                    child: Text('Reply',
                      style: TextStyle(color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600, fontSize: 12))),
                  const SizedBox(width: 14),
                  GestureDetector(
                    onTap: () {},
                    child: Text('More',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12))),
                ]),
              ),
            ]),
          ),

          const SizedBox(width: 8),

          // Like button
          GestureDetector(
            onTap: () => setState(() {
              c['liked'] = !c['liked'];
              c['likes'] += c['liked'] ? 1 : -1;
            }),
            child: Column(children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
                child: Icon(
                  c['liked'] ? Icons.favorite : Icons.favorite_border,
                  key: ValueKey(c['liked']),
                  color: c['liked'] ? AppColors.red : AppColors.textSecondary,
                  size: 18)),
              const SizedBox(height: 2),
              Text('${c['likes']}',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
            ]),
          ),
        ]),

        // Replies section
        if ((c['replies'] as List).isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 48, top: 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GestureDetector(
                onTap: () => setState(() => c['showReplies'] = !c['showReplies']),
                child: Row(children: [
                  Container(width: 24, height: 0.5, color: AppColors.textSecondary),
                  const SizedBox(width: 8),
                  Text(
                    c['showReplies']
                      ? 'Hide replies'
                      : 'View ${(c['replies'] as List).length} replies',
                    style: TextStyle(color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600, fontSize: 12.5)),
                ]),
              ),

              // Reply items
              if (c['showReplies'] == true)
                ...((c['replies'] as List).map((r) => Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    ClipOval(child: Image.network(r['av'],
                      width: 30, height: 30, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                        CircleAvatar(backgroundColor: AppColors.surface2, radius: 15))),
                    const SizedBox(width: 8),
                    Expanded(child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        color: AppColors.surface2,
                        borderRadius: const BorderRadius.only(
                          topRight:    Radius.circular(12),
                          bottomLeft:  Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r['u'], style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700, fontSize: 12.5)),
                          const SizedBox(height: 2),
                          Text(r['text'], style: const TextStyle(
                            color: Color(0xFFE8E8E8), fontSize: 13)),
                        ]),
                    )),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () => setState(() {
                        r['liked'] = !r['liked'];
                        r['likes'] += r['liked'] ? 1 : -1;
                      }),
                      child: Column(children: [
                        Icon(
                          r['liked'] ? Icons.favorite : Icons.favorite_border,
                          color: r['liked'] ? AppColors.red : AppColors.textSecondary,
                          size: 15),
                        Text('${r['likes']}',
                          style: TextStyle(
                            color: AppColors.textSecondary, fontSize: 10)),
                      ]),
                    ),
                  ]),
                ))),
            ]),
          ),
        ],
      ]),
    );
  }
}