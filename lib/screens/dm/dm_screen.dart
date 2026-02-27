import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class DmScreen extends StatefulWidget {
  const DmScreen({super.key});
  @override
  State<DmScreen> createState() => _DmScreenState();
}

class _DmScreenState extends State<DmScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;

  final List<Map<String, dynamic>> _chats = [
    {'name': 'ahmed_k',    'msg': 'That shot was incredible! 🔥', 'time': '2m',  'av': 'https://i.pravatar.cc/56?img=1',  'unread': 3, 'online': true},
    {'name': 'sara_life',  'msg': 'When are you free to meet? 😊', 'time': '15m', 'av': 'https://i.pravatar.cc/56?img=5',  'unread': 0, 'online': true},
    {'name': 'travel.log', 'msg': 'Check out my new reel!',        'time': '1h',  'av': 'https://i.pravatar.cc/56?img=8',  'unread': 1, 'online': false},
    {'name': 'hamza_pk',   'msg': 'Yaar kia scene hai 😂',         'time': '3h',  'av': 'https://i.pravatar.cc/56?img=11', 'unread': 0, 'online': false},
    {'name': 'nadia.arts', 'msg': 'Loved your story ❤️',          'time': '5h',  'av': 'https://i.pravatar.cc/56?img=16', 'unread': 0, 'online': true},
    {'name': 'usman.fx',   'msg': 'Sent you a photo',              'time': '1d',  'av': 'https://i.pravatar.cc/56?img=20', 'unread': 0, 'online': false},
    {'name': 'faraz_k',    'msg': 'Bhai reply to karo 😅',         'time': '2d',  'av': 'https://i.pravatar.cc/56?img=25', 'unread': 0, 'online': false},
    {'name': 'ali_photo',  'msg': 'Amazing photography skills!',   'time': '3d',  'av': 'https://i.pravatar.cc/56?img=30', 'unread': 0, 'online': false},
  ];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() { _tabs.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.black, elevation: 0,
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          Text('your_username',
            style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 20),
        ]),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.video_call_outlined, color: Colors.white, size: 26),
            onPressed: () {}),
          IconButton(
            icon: Icon(Icons.edit_outlined, color: Colors.white, size: 22),
            onPressed: () {}),
        ],
      ),
      body: Column(children: [

        // Search bar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.surface2,
              borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              Icon(Icons.search, color: AppColors.textSecondary, size: 18),
              const SizedBox(width: 8),
              Text('Search', style: TextStyle(
                color: AppColors.textSecondary, fontSize: 15)),
            ]),
          ),
        ),

        // Tabs
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surface2,
            borderRadius: BorderRadius.circular(10)),
          child: TabBar(
            controller: _tabs,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.all(3),
            labelColor: Colors.black,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(text: 'Messages'),
              Tab(text: 'Requests'),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Active now row
        SizedBox(height: 86,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _chats.where((c) => c['online'] == true).length,
            itemBuilder: (_, i) {
              final online = _chats.where((c) => c['online'] == true).toList();
              final c = online[i];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(children: [
                  Stack(children: [
                    ClipOval(child: Image.network(c['av'],
                      width: 56, height: 56, fit: BoxFit.cover)),
                    Positioned(bottom: 2, right: 2,
                      child: Container(width: 13, height: 13,
                        decoration: BoxDecoration(
                          color: const Color(0xFF31D95A),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2)))),
                  ]),
                  const SizedBox(height: 4),
                  SizedBox(width: 56,
                    child: Text(c['name'], textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 11))),
                ]),
              );
            },
          ),
        ),

        Divider(color: AppColors.border, height: 0.5),

        // Chat list
        Expanded(
          child: TabBarView(
            controller: _tabs,
            children: [
              _chatList(_chats),
              _requestsEmpty(),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _chatList(List<Map<String, dynamic>> chats) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 4),
      itemCount: chats.length,
      itemBuilder: (_, i) {
        final c = chats[i];
        final hasUnread = (c['unread'] as int) > 0;
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Stack(children: [
            ClipOval(child: Image.network(c['av'],
              width: 56, height: 56, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                Container(width: 56, height: 56, color: AppColors.surface2))),
            if (c['online'] == true)
              Positioned(bottom: 2, right: 2,
                child: Container(width: 13, height: 13,
                  decoration: BoxDecoration(
                    color: const Color(0xFF31D95A),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2)))),
          ]),
          title: Text(c['name'],
            style: TextStyle(
              color: Colors.white,
              fontWeight: hasUnread ? FontWeight.w700 : FontWeight.w500,
              fontSize: 14.5)),
          subtitle: Text(c['msg'],
            maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: hasUnread ? Colors.white : AppColors.textSecondary,
              fontWeight: hasUnread ? FontWeight.w600 : FontWeight.normal,
              fontSize: 13)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(c['time'],
                style: TextStyle(
                  color: hasUnread ? AppColors.blue : AppColors.textSecondary,
                  fontSize: 12)),
              const SizedBox(height: 4),
              if (hasUnread)
                Container(
                  width: 20, height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.blue, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text('${c['unread']}',
                    style: const TextStyle(color: Colors.white,
                      fontSize: 11, fontWeight: FontWeight.w700))),
            ],
          ),
          onTap: () => _openChat(context, c),
        );
      },
    );
  }

  Widget _requestsEmpty() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.mail_outline_rounded, color: AppColors.textSecondary, size: 60),
        const SizedBox(height: 16),
        Text('No message requests', style: TextStyle(
          color: AppColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 16)),
        const SizedBox(height: 8),
        Text('Message requests from people you\ndon\'t follow will appear here.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
      ]),
    );
  }

  void _openChat(BuildContext context, Map<String, dynamic> c) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => _ChatScreen(chat: c)));
  }
}

// ── Individual Chat Screen ──────────────────────────────────

class _ChatScreen extends StatefulWidget {
  final Map<String, dynamic> chat;
  const _ChatScreen({required this.chat});
  @override
  State<_ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<_ChatScreen> {
  final _ctrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  final List<Map<String, dynamic>> _msgs = [
    {'text': 'Yaar kia scene hai! 😂',          'me': false, 'time': '10:30 AM'},
    {'text': 'Haha sab theek hai bhai 😄',       'me': true,  'time': '10:31 AM'},
    {'text': 'Kal milte hain?',                  'me': false, 'time': '10:32 AM'},
    {'text': 'Haan bilkul! Kahan?',              'me': true,  'time': '10:33 AM'},
    {'text': 'Cantt wala cafe?',                 'me': false, 'time': '10:35 AM'},
    {'text': 'Perfect! 7 baje theek rahega? 🙌', 'me': true,  'time': '10:36 AM'},
    {'text': 'Done! 👍',                         'me': false, 'time': '10:37 AM'},
  ];

  void _send() {
    if (_ctrl.text.trim().isEmpty) return;
    setState(() {
      _msgs.add({'text': _ctrl.text.trim(), 'me': true, 'time': 'Now'});
      _ctrl.clear();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.chat;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.black, elevation: 0,
        leadingWidth: 30,
        title: Row(children: [
          Stack(children: [
            ClipOval(child: Image.network(c['av'],
              width: 36, height: 36, fit: BoxFit.cover)),
            if (c['online'] == true)
              Positioned(bottom: 1, right: 1,
                child: Container(width: 11, height: 11,
                  decoration: BoxDecoration(
                    color: const Color(0xFF31D95A), shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1.5)))),
          ]),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(c['name'], style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
            Text(c['online'] == true ? 'Active now' : 'Offline',
              style: TextStyle(
                color: c['online'] == true
                  ? const Color(0xFF31D95A)
                  : AppColors.textSecondary,
                fontSize: 12)),
          ]),
        ]),
        actions: [
          IconButton(icon: Icon(Icons.call_outlined, color: Colors.white), onPressed: () {}),
          IconButton(icon: Icon(Icons.videocam_outlined, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollCtrl,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            itemCount: _msgs.length,
            itemBuilder: (_, i) {
              final m = _msgs[i];
              final isMe = m['me'] as bool;
              return Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.72),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.blue : AppColors.surface2,
                    borderRadius: BorderRadius.only(
                      topLeft:     const Radius.circular(18),
                      topRight:    const Radius.circular(18),
                      bottomLeft:  Radius.circular(isMe ? 18 : 4),
                      bottomRight: Radius.circular(isMe ? 4  : 18),
                    )),
                  child: Text(m['text'],
                    style: const TextStyle(color: Colors.white, fontSize: 14.5)),
                ),
              );
            },
          ),
        ),

        // Input bar
        Container(
          padding: EdgeInsets.only(
            left: 12, right: 8, top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom + 12),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border(top: BorderSide(color: AppColors.border, width: 0.3))),
          child: Row(children: [
            ClipOval(child: Image.network(
              'https://i.pravatar.cc/36?img=3',
              width: 32, height: 32, fit: BoxFit.cover)),
            const SizedBox(width: 8),
            Expanded(child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.surface2,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.border, width: 0.5)),
              child: TextField(
                controller: _ctrl,
                style: const TextStyle(color: Colors.white, fontSize: 14.5),
                decoration: InputDecoration(
                  hintText: 'Message...',
                  hintStyle: TextStyle(color: AppColors.textSecondary),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10)),
                onSubmitted: (_) => _send(),
              ),
            )),
            const SizedBox(width: 6),
            // Send / mic icons
            ValueListenableBuilder(
              valueListenable: _ctrl,
              builder: (_, value, __) => GestureDetector(
                onTap: _ctrl.text.isNotEmpty ? _send : null,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: _ctrl.text.isNotEmpty
                    ? Icon(Icons.send_rounded, color: AppColors.blue, size: 26,
                        key: const ValueKey('send'))
                    : Icon(Icons.mic_none_rounded, color: Colors.white, size: 26,
                        key: const ValueKey('mic')),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.image_outlined, color: Colors.white, size: 26),
          ]),
        ),
      ]),
    );
  }
}