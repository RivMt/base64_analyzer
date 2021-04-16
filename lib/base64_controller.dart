import 'dart:convert';

class Base64Controller {
  static Codec<String, String> _converter = utf8.fuse(base64);

  static String encodeBase64(String input) {
    return _converter.encode(input);
  }

  static String decodeBase64(String input) {
    return _converter.decode(input);
  }
}