import 'package:flutter/material.dart';
import '../models/dummy_data.dart';
import '../utils/colors.dart';

class StoryViewer extends StatefulWidget {
  final DummyStory story;
  const StoryViewer({super.key, required this.story});
  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final _msgCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this, duration: const Duration(seconds: 5))
      ..forward()
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed && mounted) Navigator.pop(context);
      });
  }

  @override
  void dispose() { _ctrl.dispose(); _msgCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (_) => _ctrl.stop(),
        onTapUp:   (_) => _ctrl.forward(),
        child: Stack(children: [

          Positioned.fill(
            child: Image.network(
              'https://picsum.photos/480/860?random=${widget.story.username.length * 7}',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: AppColors.surface2),
            ),
          ),

          Positioned.fill(child: DecoratedBox(
            decoration: BoxDecoration(gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.transparent,
                Colors.black.withOpacity(0.6),
              ],
            )),
          )),

          SafeArea(child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: AnimatedBuilder(
                animation: _ctrl,
                builder: (_, __) => ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: _ctrl.value,
                    backgroundColor: Colors.white.withOpacity(0.4),
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                    minHeight: 2,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(children: [
                ClipOval(child: Image.network(widget.story.avatar,
                  width: 36, height: 36, fit: BoxFit.cover)),
                const SizedBox(width: 10),
                Text(widget.story.username,
                  style: const TextStyle(color: Colors.white,
                    fontWeight: FontWeight.w700, fontSize: 14)),
                const SizedBox(width: 8),
                Text('2h', style: TextStyle(color: Colors.white70, fontSize: 12)),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.white, size: 26),
                ),
              ]),
            ),
          ])),

          Positioned(bottom: 30, left: 16, right: 16,
            child: Row(children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white60),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    controller: _msgCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Send message',
                      hintStyle: TextStyle(color: Colors.white60),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onTap: () => _ctrl.stop(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.send_outlined, color: Colors.white),
            ]),
          ),
        ]),
      ),
    );
  }
}