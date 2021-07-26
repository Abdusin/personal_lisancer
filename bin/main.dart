// 🎯 Dart imports:
import 'dart:io';

import 'package:tint/tint.dart';
import 'package:yaml/yaml.dart';
import 'package:personal_lisancer/files.dart' as files;
import 'package:personal_lisancer/lisance.dart' as sort;

void main(List<String> args) {
  final currentPath = Directory.current.path;
  final pubspecYamlFile = File('${currentPath}/pubspec.yaml');
  final pubspecYaml = loadYaml(pubspecYamlFile.readAsStringSync());

  final packageName = pubspecYaml['name'];
  final dependencies = [];

  final stopwatch = Stopwatch();
  stopwatch.start();

  final pubspecLockFile = File('${currentPath}/pubspec.lock');
  final pubspecLock = loadYaml(pubspecLockFile.readAsStringSync());
  dependencies.addAll(pubspecLock['packages'].keys);

  var userName = '';
  var contactInfo = '';
  var developerNote = '';
  String? title = null;
  final ignored_files = [];

  if (pubspecYaml.containsKey('personal_lisancer')) {
    final config = pubspecYaml['personal_lisancer'];
    if (config.containsKey('name')) userName = config['name'];
    if (config.containsKey('email')) contactInfo = config['email'];
    if (config.containsKey('note')) developerNote = config['note'];
    if (config.containsKey('title')) title = config['title'];
  }

  final dartFiles = files.dartFiles(currentPath, args);
  final containsFlutter = dependencies.contains('flutter');
  final containsRegistrant = dartFiles.containsKey('${currentPath}/lib/generated_plugin_registrant.dart');

  stdout.writeln('contains flutter: ${containsFlutter}');
  stdout.writeln('contains registrant: ${containsRegistrant}');

  if (containsFlutter && containsRegistrant) {
    dartFiles.remove('${currentPath}/lib/generated_plugin_registrant.dart');
  }

  for (final pattern in ignored_files) {
    dartFiles.removeWhere((key, _) => RegExp(pattern).hasMatch(key.replaceFirst(currentPath, '')));
  }

  stdout.write('┏━━ Lisancing ${dartFiles.length} dart files');

  final sortedFiles = [];
  final success = '✔'.green();

  for (final filePath in dartFiles.keys) {
    final file = dartFiles[filePath];
    if (file == null) {
      continue;
    }

    final liscanedFile = sort.lisance(file.readAsLinesSync(), packageName,
        name: userName, developerNote: developerNote, email: contactInfo, title: title);
    if (!liscanedFile.updated) {
      continue;
    }
    dartFiles[filePath]?.writeAsStringSync(liscanedFile.lisancedFile);
    sortedFiles.add(filePath);
  }

  stopwatch.stop();

  if (sortedFiles.length > 1) {
    stdout.write("\n");
  }
  for (int i = 0; i < sortedFiles.length; i++) {
    final file = dartFiles[sortedFiles[i]];
    stdout.write(
        '${sortedFiles.length == 1 ? '\n' : ''}┃  ${i == sortedFiles.length - 1 ? '┗' : '┣'}━━ ${success} Lisanced for ${file?.path.replaceFirst(currentPath, '')}/');
    String filename = file!.path.split(Platform.pathSeparator).last;
    stdout.write(filename + "\n");
  }

  if (sortedFiles.length == 0) {
    stdout.write("\n");
  }
  stdout.write(
      '┗━━ ${success} Lisanced ${sortedFiles.length} files in ${stopwatch.elapsed.inSeconds}.${stopwatch.elapsedMilliseconds} seconds\n');
}
