import 'package:secure_qr_scanner/qr_code/dto/content_type.dart';
import 'package:secure_qr_scanner/qr_code/dto/detected_content.dart';

/// Service for detecting and parsing QR code content types
class ContentDetectorService {
  /// Detect content type and parse relevant data
  static DetectedContent detect(String rawData) {
    final trimmed = rawData.trim();

    // Wi-Fi network (WIFI:T:WPA;S:MyNetwork;P:password;;)
    if (_isWifi(trimmed)) {
      return DetectedContent(
        rawData: rawData,
        type: ContentType.wifi,
        parsedData: _parseWifi(trimmed),
      );
    }

    // vCard contact (BEGIN:VCARD...END:VCARD)
    if (_isVCard(trimmed)) {
      return DetectedContent(
        rawData: rawData,
        type: ContentType.vcard,
        parsedData: _parseVCard(trimmed),
      );
    }

    // Calendar event (BEGIN:VEVENT...END:VEVENT)
    if (_isCalendar(trimmed)) {
      return DetectedContent(
        rawData: rawData,
        type: ContentType.calendar,
        parsedData: _parseCalendar(trimmed),
      );
    }

    // Geographic coordinates (geo:lat,lon or geo:lat,lon,alt)
    if (_isGeo(trimmed)) {
      return DetectedContent(
        rawData: rawData,
        type: ContentType.geo,
        parsedData: _parseGeo(trimmed),
      );
    }

    // Email (mailto:email@example.com or MATMSG:TO:email;;)
    if (_isEmail(trimmed)) {
      return DetectedContent(
        rawData: rawData,
        type: ContentType.email,
        parsedData: _parseEmail(trimmed),
      );
    }

    // Phone number (tel:+1234567890)
    if (_isPhone(trimmed)) {
      return DetectedContent(
        rawData: rawData,
        type: ContentType.phone,
        parsedData: _parsePhone(trimmed),
      );
    }

    // SMS (sms:+1234567890 or SMSTO:+1234567890:message)
    if (_isSms(trimmed)) {
      return DetectedContent(
        rawData: rawData,
        type: ContentType.sms,
        parsedData: _parseSms(trimmed),
      );
    }

    // URL (http://, https://, www.)
    if (_isUrl(trimmed)) {
      return DetectedContent(
        rawData: rawData,
        type: ContentType.url,
        parsedData: _parseUrl(trimmed),
      );
    }

    // Default to plain text
    return DetectedContent(rawData: rawData, type: ContentType.text);
  }

  // ===== Type Detection Methods =====

  static bool _isUrl(String data) {
    return data.startsWith(RegExp(r'https?://')) ||
        data.startsWith('www.') ||
        RegExp(r'^[a-zA-Z0-9-]+\.[a-zA-Z]{2,}').hasMatch(data);
  }

  static bool _isEmail(String data) {
    return data.startsWith('mailto:') ||
        data.startsWith('MATMSG:TO:') ||
        RegExp(
          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        ).hasMatch(data);
  }

  static bool _isPhone(String data) {
    return data.startsWith('tel:') ||
        RegExp(r'^\+?[0-9\s\-\(\)]{10,}$').hasMatch(data);
  }

  static bool _isSms(String data) {
    return data.startsWith(RegExp(r'sms:|SMSTO:'));
  }

  static bool _isWifi(String data) {
    return data.startsWith('WIFI:');
  }

  static bool _isVCard(String data) {
    return data.contains('BEGIN:VCARD') && data.contains('END:VCARD');
  }

  static bool _isGeo(String data) {
    return data.startsWith('geo:');
  }

  static bool _isCalendar(String data) {
    return data.contains('BEGIN:VEVENT') && data.contains('END:VEVENT');
  }

  // ===== Parsing Methods =====

  static Map<String, String> _parseUrl(String data) {
    String url = data;
    if (data.startsWith('www.')) {
      url = 'https://$data';
    }
    try {
      final uri = Uri.parse(url);
      return {
        'url': url,
        'scheme': uri.scheme,
        'host': uri.host,
        'path': uri.path,
      };
    } catch (e) {
      return {'url': url};
    }
  }

  static Map<String, String> _parseEmail(String data) {
    if (data.startsWith('mailto:')) {
      final uri = Uri.parse(data);
      return {
        'email': uri.path,
        'subject': uri.queryParameters['subject'] ?? '',
        'body': uri.queryParameters['body'] ?? '',
      };
    } else if (data.startsWith('MATMSG:TO:')) {
      // MATMSG:TO:email;SUB:subject;BODY:body;;
      final parts = data.substring(10).split(';');
      final result = <String, String>{};
      for (final part in parts) {
        if (part.contains(':')) {
          final kv = part.split(':');
          result[kv[0].toLowerCase()] = kv[1];
        }
      }
      return {
        'email': result['to'] ?? '',
        'subject': result['sub'] ?? '',
        'body': result['body'] ?? '',
      };
    } else {
      return {'email': data};
    }
  }

  static Map<String, String> _parsePhone(String data) {
    String number = data;
    if (data.startsWith('tel:')) {
      number = data.substring(4);
    }
    return {'number': number};
  }

  static Map<String, String> _parseSms(String data) {
    if (data.startsWith('sms:')) {
      // sms:+1234567890?body=message
      final uri = Uri.parse(data);
      return {'number': uri.path, 'message': uri.queryParameters['body'] ?? ''};
    } else if (data.startsWith('SMSTO:')) {
      // SMSTO:+1234567890:message
      final parts = data.substring(6).split(':');
      return {
        'number': parts.isNotEmpty ? parts[0] : '',
        'message': parts.length > 1 ? parts[1] : '',
      };
    }
    return {};
  }

  static Map<String, String> _parseWifi(String data) {
    // WIFI:T:WPA;S:NetworkName;P:password;H:true;;
    final result = <String, String>{};
    final content = data.substring(5); // Remove 'WIFI:'
    final parts = content.split(';');

    for (final part in parts) {
      if (part.contains(':')) {
        final kv = part.split(':');
        if (kv.length == 2) {
          final key = kv[0].toUpperCase();
          final value = kv[1];
          switch (key) {
            case 'T':
              result['security'] = value; // WPA, WEP, nopass
              break;
            case 'S':
              result['ssid'] = value;
              break;
            case 'P':
              result['password'] = value;
              break;
            case 'H':
              result['hidden'] = value;
              break;
          }
        }
      }
    }
    return result;
  }

  static Map<String, String> _parseVCard(String data) {
    final result = <String, String>{};
    final lines = data.split('\n');

    for (final line in lines) {
      if (line.startsWith('FN:')) {
        result['name'] = line.substring(3).trim();
      } else if (line.startsWith('TEL:')) {
        result['phone'] = line.substring(4).trim();
      } else if (line.startsWith('EMAIL:')) {
        result['email'] = line.substring(6).trim();
      } else if (line.startsWith('ORG:')) {
        result['organization'] = line.substring(4).trim();
      } else if (line.startsWith('TITLE:')) {
        result['title'] = line.substring(6).trim();
      } else if (line.startsWith('URL:')) {
        result['url'] = line.substring(4).trim();
      } else if (line.startsWith('NOTE:')) {
        result['note'] = line.substring(5).trim();
      }
    }
    return result;
  }

  static Map<String, String> _parseGeo(String data) {
    // geo:lat,lon or geo:lat,lon,alt
    final coords = data.substring(4).split(',');
    return {
      'latitude': coords.isNotEmpty ? coords[0] : '',
      'longitude': coords.length > 1 ? coords[1] : '',
      'altitude': coords.length > 2 ? coords[2] : '',
    };
  }

  static Map<String, String> _parseCalendar(String data) {
    final result = <String, String>{};
    final lines = data.split('\n');

    for (final line in lines) {
      if (line.startsWith('SUMMARY:')) {
        result['summary'] = line.substring(8).trim();
      } else if (line.startsWith('DTSTART:')) {
        result['start'] = line.substring(8).trim();
      } else if (line.startsWith('DTEND:')) {
        result['end'] = line.substring(6).trim();
      } else if (line.startsWith('LOCATION:')) {
        result['location'] = line.substring(9).trim();
      } else if (line.startsWith('DESCRIPTION:')) {
        result['description'] = line.substring(12).trim();
      }
    }
    return result;
  }
}
