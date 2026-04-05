import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class ExcelHelper<T> {
  static Future<File> createExcelFile<T>({
    required String fileName,
    required List<String> columnTitles,
    required List<T> data,
    required List<dynamic> Function(T row) rowMapper,
    String? savePath,
    bool openAfterCreated = true,
  }) async {
    final excel = Excel.createExcel();
    final Sheet sheet = excel['Sheet1'];

    // إضافة العناوين
    sheet.appendRow(_toCellValueList(columnTitles));

    // إضافة البيانات
    for (var row in data) {
      sheet.appendRow(_toCellValueList(rowMapper(row)));
    }

    final directory = savePath != null
        ? Directory(savePath)
        : await getDownloadsDirectory() ??
            await getApplicationDocumentsDirectory();

    String fullPath = '${directory.path}/$fileName.xlsx';
    int counter = 1;

    while (File(fullPath).existsSync()) {
      fullPath = '${directory.path}/$fileName $counter.xlsx';
      counter++;
    }

    final fileBytes = excel.encode();
    final file = File(fullPath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    if (openAfterCreated) {
      await OpenFile.open(file.path);
    }

    return file;
  }

  // تحويل القيم إلى CellValue
  static List<CellValue?> _toCellValueList(List<dynamic> values) {
    return values.map(_toCellValue).toList();
  }

  static CellValue? _toCellValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return IntCellValue(value);
    if (value is double) return DoubleCellValue(value);
    if (value is String) return TextCellValue(value);
    if (value is bool) return BoolCellValue(value);
    return TextCellValue(value.toString()); // fallback
  }
}
