import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));

  for (final file in files) {
    String content = file.readAsStringSync();
    
    String newContent = content.replaceAll(RegExp(r'boxShadow:\s*\[[^\]]*\],?'), '');
    newContent = newContent.replaceAll(RegExp(r'boxShadow:\s*[^\?]+\?\s*\[[^\]]*\]\s*:\s*(null|\[\]),?'), '');
    newContent = newContent.replaceAll(RegExp(r'boxShadow:\s*AppColors.neumorphicShadows\([^)]*\),?'), '');
    newContent = newContent.replaceAll(RegExp(r'boxShadow:\s*\[(?:\s*BoxShadow\([^)]*\),?)*\s*\],?'), '');

    if (newContent != content) {
      file.writeAsStringSync(newContent);
      print('Removed boxShadow from ' + file.path);
    }
  }
}
