import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:secure_chat/models/translate/translation.dart';

import '../constants/languages.dart';

class TranslationService {
  static const String _url = 'https://translate.google.com/translate_a/single';
  static final Logger _log = Logger('TranslationService');

  final Dio _dioClient = GetIt.I<Dio>();

  /// Translates the [text] and returns a [Translation] object or a
  /// [Future.error] if it failed.
  Future<Translation> translate({
    String text,
    String from = 'auto',
    String to = 'en',
  }) async {
    _log.fine('translating from $from to $to');

    final params = <String, String>{
      'client': 'gtx',
      'sl': from,
      'tl': to,
      'dt': 't',
      'q': Uri.encodeComponent(text),
      'ie': 'UTF-8',
      'oe': 'UTF-8',
    };

    final response = await _dioClient.get(_url, queryParameters: params);

    if (response.statusCode != HttpStatus.ok) {
      return Future.error(response.statusCode);
    }

    try {
      // try to parse translation from response
      final List jsonList = jsonDecode(response.data);

      final StringBuffer originalStringBuffer = StringBuffer();
      final StringBuffer translatedStringBuffer = StringBuffer();

      for (List translationText in jsonList[0]) {
        originalStringBuffer.write(translationText[1]);
        translatedStringBuffer.write(translationText[0]);
      }

      return Translation(
        originalStringBuffer.toString(), // original
        translatedStringBuffer.toString(), // translated text
        jsonList.last[0][0], // language code
        languages[jsonList.last[0][0]], // language
      );
    } on Exception {
      return Future.error(response.statusCode);
    }
  }
}
