import 'dart:io';

void main() {
  final file = File('lib/widgets/textfield/neumorphic_textfield.dart');
  String content = file.readAsStringSync();
  
  final regex = RegExp(r'// Invisible child to give Stack a size.*?Opacity\(\s*opacity: 0,\s*child: TextField\(.*?\),\s*\),', dotAll: true);
  content = content.replaceAll(regex, '');
  
  file.writeAsStringSync(content);
}
