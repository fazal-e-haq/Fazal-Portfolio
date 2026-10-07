import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));

  for (final file in files) {
    String content = file.readAsStringSync();
    
    // Replace all white variants with black text variants
    content = content.replaceAll('Colors.white10', 'AppColors.textMain.withValues(alpha: 0.10)');
    content = content.replaceAll('Colors.white24', 'AppColors.textMain.withValues(alpha: 0.24)');
    content = content.replaceAll('Colors.white54', 'AppColors.textMain.withValues(alpha: 0.54)');
    content = content.replaceAll('Colors.white60', 'AppColors.textMain.withValues(alpha: 0.60)');
    content = content.replaceAll('Colors.white70', 'AppColors.textMain.withValues(alpha: 0.70)');
    content = content.replaceAll('Colors.white', 'AppColors.textMain');

    file.writeAsStringSync(content);
  }
  print('Done replacing colors.');
}
