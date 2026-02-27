import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../upload/upload_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;

  final _highlights = [
    {'name': 'Travel', 'img': 'https://picsum.photos/66?random=10'},
    {'name': 'Food',   'img': 'https://picsum.photos/66?random=20'},
    {'name': 'Life',   'img': 'https://picsum.photos/66?random=30'},
    {'name': 'Work',   'img': 'https://picsum.photos/66?random=40'},
    {'name': 'Trips',  'img': 'https://picsum.photos/66?random=55'},
  ];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() { _tabs.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.black, elevation: 0,
        // 2025: + top left on profile too
        leading: GestureDetector(
          onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const UploadScreen())),
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border, width: 1.5),
                borderRadius: BorderRadius.circular(7)),
              child: const Icon(Icons.add, color: Colors.white, size: 17)),
          ),
        ),
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          Text('your_username',
            style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.w800, fontSize: 17)),
          const SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down_rounded,
            color: Colors.white, size: 20),
        ]),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.menu_rounded, color: Colors.white),
            onPressed: () => _menu(context)),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (_, __) =>
          [SliverToBoxAdapter(child: _header())],
        body: Column(children: [
          // Tabs
          TabBar(
            controller: _tabs,
            indicatorColor: Colors.white,
            indicatorWeight: 1,
            labelColor: Colors.white,
            unselectedLabelColor: AppColors.textSecondary,
            dividerColor: AppColors.border,
            tabs: const [
              Tab(icon: Icon(Icons.grid_on_rounded,         size: 24)),
              Tab(icon: Icon(Icons.play_circle_outline,      size: 24)),
              Tab(icon: Icon(Icons.person_pin_outlined,      size: 24)),
            ],
          ),
          Expanded(child: TabBarView(controller: _tabs, children: [
            // 2025: 3-col vertical grid
            _verticalGrid(12, 50),
            _verticalGrid(6,  80, reel: true),
            _verticalGrid(4,  90),
          ])),
        ]),
      ),
    );
  }

  Widget _header() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      // Top row: avatar + stats
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          // Avatar with gradient ring
          Container(
            padding: const EdgeInsets.all(2.5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle, gradient: AppColors.storyGradient),
            child: Container(
              padding: const EdgeInsets.all(2.5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.black),
              child: ClipOval(child: Image.network(
                'https://i.pravatar.cc/90?img=3',
                width: 80, height: 80, fit: BoxFit.cover)),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _stat('48',   'Posts'),
              _divider(),
              _stat('1.2K', 'Followers'),
              _divider(),
              _stat('384',  'Following'),
            ],
          )),
        ]),
      ),

      // Name + bio
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text('Your Name', style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700, fontSize: 14.5)),
            const SizedBox(width: 6),
            // Verified badge
            Icon(Icons.verified_rounded, color: AppColors.blue, size: 16),
          ]),
          const SizedBox(height: 4),
          Text('📍 Lahore, Pakistan',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 2),
          Text('Photography | Travel | Life ✨',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 13.5)),
          const SizedBox(height: 2),
          Text('🔗 yourwebsite.com',
            style: TextStyle(color: const Color(0xFF4CB5F9), fontSize: 13.5)),
        ]),
      ),

      // Action buttons
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
        child: Row(children: [
          Expanded(child: _actionBtn('Edit Profile',   filled: false)),
          const SizedBox(width: 8),
          Expanded(child: _actionBtn('Share Profile',  filled: false)),
          const SizedBox(width: 8),
          _iconBtn(Icons.person_add_outlined),
        ]),
      ),

      // Highlights
      SizedBox(height: 106,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
          children: [
            _hlNew(),
            ..._highlights.map((h) => _hlItem(h['name']!, h['img']!)),
          ],
        ),
      ),

      const SizedBox(height: 4),
    ]);
  }

  Widget _stat(String n, String l) {
    return Column(children: [
      Text(n, style: TextStyle(color: AppColors.textPrimary,
        fontWeight: FontWeight.w800, fontSize: 18)),
      const SizedBox(height: 2),
      Text(l, style: TextStyle(color: AppColors.textSecondary, fontSize: 12.5)),
    ]);
  }

  Widget _divider() => Container(
    width: 0.5, height: 28, color: AppColors.border);

  Widget _actionBtn(String label, {required bool filled}) => Container(
    height: 34,
    decoration: BoxDecoration(
      color: filled ? AppColors.blue : AppColors.surface2,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.border, width: 0.5)),
    alignment: Alignment.center,
    child: Text(label, style: TextStyle(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600, fontSize: 13.5)));

  Widget _iconBtn(IconData icon) => Container(
    width: 38, height: 34,
    decoration: BoxDecoration(
      color: AppColors.surface2, borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.border, width: 0.5)),
    alignment: Alignment.center,
    child: Icon(icon, color: AppColors.textPrimary, size: 17));

  Widget _hlNew() => Padding(
    padding: const EdgeInsets.only(right: 18),
    child: Column(children: [
      Container(width: 64, height: 64,
        decoration: BoxDecoration(shape: BoxShape.circle,
          border: Border.all(color: AppColors.border, width: 1.5)),
        child: Icon(Icons.add, color: AppColors.textSecondary, size: 26)),
      const SizedBox(height: 5),
      Text('New', style: TextStyle(color: AppColors.textPrimary, fontSize: 11)),
    ]),
  );

  Widget _hlItem(String name, String img) => Padding(
    padding: const EdgeInsets.only(right: 18),
    child: Column(children: [
      Container(width: 64, height: 64,
        decoration: BoxDecoration(shape: BoxShape.circle,
          border: Border.all(color: AppColors.border, width: 1.5)),
        child: ClipOval(child: Image.network(img, fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
            Container(color: AppColors.surface2)))),
      const SizedBox(height: 5),
      Text(name, style: TextStyle(color: AppColors.textPrimary, fontSize: 11)),
    ]),
  );

  // 2025: Vertical/rectangular grid (3:4 ratio)
  Widget _verticalGrid(int count, int seed, {bool reel = false}) {
    return GridView.builder(
      padding: const EdgeInsets.all(1),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        childAspectRatio: 0.75, // vertical/portrait ratio
      ),
      itemCount: count,
      itemBuilder: (_, i) => Stack(fit: StackFit.expand, children: [
        Image.network(
          'https://picsum.photos/200/267?random=${i + seed}',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
            Container(color: AppColors.surface2)),
        if (reel) Positioned(top: 6, right: 6,
          child: Icon(Icons.play_arrow_rounded,
            color: Colors.white, size: 20,
            shadows: const [Shadow(blurRadius: 8, color: Colors.black)])),
      ]),
    );
  }

  void _menu(BuildContext ctx) => showModalBottomSheet(
    context: ctx,
    backgroundColor: const Color(0xFF1A1A1A),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (_) => Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 36, height: 4,
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: AppColors.border,
          borderRadius: BorderRadius.circular(2))),
      _menuItem(Icons.settings_outlined,      'Settings and activity',  ctx),
      _menuItem(Icons.archive_outlined,        'Archive',                ctx),
      _menuItem(Icons.qr_code_rounded,         'QR Code',                ctx),
      _menuItem(Icons.bookmark_border_rounded, 'Saved',                  ctx),
      Divider(color: AppColors.border, height: 1),
      _menuItem(Icons.logout_rounded, 'Log Out', ctx, color: AppColors.red),
      const SizedBox(height: 20),
    ]),
  );

  Widget _menuItem(IconData icon, String label, BuildContext ctx,
      {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.textPrimary, size: 22),
      title: Text(label, style: TextStyle(
        color: color ?? AppColors.textPrimary, fontSize: 15)),
      onTap: () => Navigator.pop(ctx),
    );
  }
}