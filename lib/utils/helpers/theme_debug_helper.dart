import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:brothers_creative/utils/helpers/system_ui_helper.dart';

/// مساعد لتشخيص النمط وSystemUI في أي شاشة
class TThemeDebugHelper {
  TThemeDebugHelper._();

  /// إضافة زر تشخيص للنمط (يظهر فقط في وضع التطوير)
  static Widget debugButton(BuildContext context) {
    if (!kDebugMode) return const SizedBox.shrink();

    return Positioned(
      top: 100,
      right: 20,
      child: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        onPressed: () {
          TSystemUIHelper.debugCurrentMode(context);
          _showDebugDialog(context);
        },
        child: const Icon(Icons.bug_report),
      ),
    );
  }

  /// إضافة معلومات التشخيص في أعلى الشاشة
  static Widget debugInfo(BuildContext context) {
    if (!kDebugMode) return const SizedBox.shrink();

    return Positioned(
      top: 50,
      left: 20,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Theme Debug',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Theme: ${Theme.of(context).brightness}',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
            Text(
              'Platform: ${MediaQuery.of(context).platformBrightness}',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
            Text(
              'Is Dark: ${_isDarkMode(context)}',
              style: TextStyle(
                color: _isDarkMode(context) ? Colors.green : Colors.orange,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// إضافة شريط تشخيص في أسفل الشاشة
  static Widget debugBar(BuildContext context) {
    if (!kDebugMode) return const SizedBox.shrink();

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 30,
        color: Colors.black87,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDebugItem(
              context,
              'Theme',
              Theme.of(context).brightness.toString(),
            ),
            _buildDebugItem(
              context,
              'Platform',
              MediaQuery.of(context).platformBrightness.toString(),
            ),
            _buildDebugItem(
              context,
              'SystemUI',
              _isDarkMode(context) ? 'WHITE Icons' : 'BLACK Icons',
            ),
          ],
        ),
      ),
    );
  }

  /// بناء عنصر تشخيص
  static Widget _buildDebugItem(
    BuildContext context,
    String label,
    String value,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: TextStyle(color: Colors.grey, fontSize: 8)),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// فحص ما إذا كان النمط مظلم
  static bool _isDarkMode(BuildContext context) {
    final themeBrightness = Theme.of(context).brightness;
    final mediaQueryBrightness = MediaQuery.of(context).platformBrightness;
    return mediaQueryBrightness == Brightness.dark ||
        themeBrightness == Brightness.dark;
  }

  /// إظهار نافذة تشخيص
  static void _showDebugDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('🔍 Theme Debug Info'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDebugRow(
                  'Theme Brightness',
                  Theme.of(context).brightness.toString(),
                ),
                _buildDebugRow(
                  'Platform Brightness',
                  MediaQuery.of(context).platformBrightness.toString(),
                ),
                _buildDebugRow('Is Dark Mode', _isDarkMode(context).toString()),
                _buildDebugRow(
                  'Status Bar Icons',
                  _isDarkMode(context) ? 'WHITE (Light)' : 'BLACK (Dark)',
                ),
                _buildDebugRow(
                  'Navigation Icons',
                  _isDarkMode(context) ? 'WHITE (Light)' : 'BLACK (Dark)',
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('إغلاق'),
              ),
              ElevatedButton(
                onPressed: () {
                  TSystemUIHelper.forceDarkMode();
                  Navigator.pop(context);
                },
                child: const Text('إجبار النمط المظلم'),
              ),
              ElevatedButton(
                onPressed: () {
                  TSystemUIHelper.forceLightMode();
                  Navigator.pop(context);
                },
                child: const Text('إجبار النمط الفاتح'),
              ),
            ],
          ),
    );
  }

  /// بناء صف تشخيص
  static Widget _buildDebugRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontFamily: 'monospace')),
        ],
      ),
    );
  }
}
