import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});
  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  int _tab = 0, _filter = 0;
  final _tabs    = ['POST', 'REEL', 'STORY'];
  final _filters = ['Normal', 'Clarendon', 'Gingham', 'Lark', 'Reyes'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.black, elevation: 0,
        leading: Icon(Icons.close, color: AppColors.textPrimary),
        title: Text('New Post', style: TextStyle(
          color: AppColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: const Text('✅ Post shared!'),
                backgroundColor: AppColors.surface2,
                behavior: SnackBarBehavior.floating)),
            child: Text('Share', style: TextStyle(
              color: AppColors.blue, fontWeight: FontWeight.w700, fontSize: 15))),
        ],
      ),
      body: SingleChildScrollView(child: Column(children: [

        // Tabs
        Row(children: List.generate(_tabs.length, (i) => Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _tab = i),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(
                color: _tab == i ? Colors.white : Colors.transparent,
                width: 1.5))),
              alignment: Alignment.center,
              child: Text(_tabs[i], style: TextStyle(
                color: _tab == i ? AppColors.textPrimary : AppColors.textSecondary,
                fontWeight: FontWeight.w700, fontSize: 13, letterSpacing: 0.5)),
            ),
          ),
        ))),

        // Preview image
        AspectRatio(aspectRatio: 1,
          child: Image.network('https://picsum.photos/480/480?random=99',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: AppColors.surface2))),

        // Filters
        SizedBox(height: 104,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            itemCount: _filters.length,
            itemBuilder: (_, i) => GestureDetector(
              onTap: () => setState(() => _filter = i),
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                child: Column(children: [
                  Container(width: 66, height: 66,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: _filter == i ? AppColors.blue : Colors.transparent,
                        width: 2)),
                    child: ClipRRect(borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        'https://picsum.photos/66/66?random=${i + 200}',
                        fit: BoxFit.cover))),
                  const SizedBox(height: 4),
                  Text(_filters[i], style: TextStyle(
                    color: _filter == i ? AppColors.blue : AppColors.textSecondary,
                    fontSize: 10)),
                ]),
              ),
            ),
          ),
        ),

        Divider(color: AppColors.border, height: 1),

        // Caption input
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipOval(child: Image.network('https://i.pravatar.cc/36?img=3',
              width: 36, height: 36, fit: BoxFit.cover)),
            const SizedBox(width: 12),
            Expanded(child: TextField(
              maxLines: 4,
              style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Write a caption...',
                hintStyle: TextStyle(color: AppColors.textSecondary),
                border: InputBorder.none),
            )),
          ]),
        ),

        Divider(color: AppColors.border, height: 1),
        _option('Tag People'),
        _option('Add Location'),
        _option('Also post to Facebook'),
        _option('Advanced Settings'),
        const SizedBox(height: 40),
      ])),
    );
  }

  Widget _option(String label) => Column(children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(children: [
        Text(label, style: TextStyle(color: AppColors.textPrimary, fontSize: 14)),
        const Spacer(),
        Icon(Icons.chevron_right, color: AppColors.textSecondary),
      ])),
    Divider(color: AppColors.border, height: 1),
  ]);
}