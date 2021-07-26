LisanceData lisance(List<String> lines, String projectName,
    {String? name, String? email, String? title, String? developerNote}) {
  var _title = title ?? 'Developer';
  var today = DateTime.now();
  var text = '${today.day}-${today.month}-${today.year}';
  var editedLine = '''
\/\/! @Lisanced
\/\/! ************************************
\/\/! Project Name : $projectName
\/\/! ${_title} : Abdus İnanç 
\/\/! Email : abdusinanc@gmail.com ${developerNote != null && developerNote.isNotEmpty ? "\n\/\/! $_title Note: $developerNote" : ""}
\/\/! Lisance At $text
\/\/! ************************************
''';
  var editedLines = [editedLine.trimRight()];
  if (lines.first.contains('@Lisanced')) {
    var kIndex = lines.length >= 8 ? 8 : lines.length;
    for (var i = 0; i < kIndex; i++) {
      if (!lines[i].contains('\/\/!')) {
        editedLines.add(lines[i]);
      }
    }
    for (var i = kIndex; i < lines.length; i++) {
      editedLines.add(lines[i]);
    }
  } else {
    editedLines.addAll(lines);
  }
  var editedFile = editedLines.join('\n');
  return LisanceData(editedFile, true);
}

/// Data to return from a sort
class LisanceData {
  final String lisancedFile;
  final bool updated;

  const LisanceData(this.lisancedFile, this.updated);
}
