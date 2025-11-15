import 'package:flutter/material.dart';
import 'package:secure_qr_scanner/qr_code/dto/content_type.dart';
import 'package:secure_qr_scanner/qr_code/dto/detected_content.dart';
import 'package:url_launcher/url_launcher.dart';

/// Service for handling actions based on content type
class ContentActionService {
  /// Get icon for content type
  static IconData getIcon(ContentType type) {
    switch (type) {
      case ContentType.url:
        return Icons.link;
      case ContentType.email:
        return Icons.email;
      case ContentType.phone:
        return Icons.phone;
      case ContentType.sms:
        return Icons.message;
      case ContentType.wifi:
        return Icons.wifi;
      case ContentType.vcard:
        return Icons.contact_page;
      case ContentType.geo:
        return Icons.location_on;
      case ContentType.calendar:
        return Icons.event;
      case ContentType.text:
        return Icons.text_fields;
    }
  }

  /// Get primary action for content type
  static ContentAction? getPrimaryAction(DetectedContent content) {
    switch (content.type) {
      case ContentType.url:
        return ContentAction(
          icon: Icons.open_in_browser,
          label: 'Open in Browser',
          handler: () => _openUrl(content),
        );
      case ContentType.email:
        return ContentAction(
          icon: Icons.email,
          label: 'Send Email',
          handler: () => _sendEmail(content),
        );
      case ContentType.phone:
        return ContentAction(
          icon: Icons.call,
          label: 'Call Number',
          handler: () => _callNumber(content),
        );
      case ContentType.sms:
        return ContentAction(
          icon: Icons.message,
          label: 'Send SMS',
          handler: () => _sendSms(content),
        );
      case ContentType.wifi:
        return ContentAction(
          icon: Icons.wifi,
          label: 'View Wi-Fi Details',
          handler: null, // Will show dialog in UI
        );
      case ContentType.vcard:
        return ContentAction(
          icon: Icons.person_add,
          label: 'Add Contact',
          handler: null, // Will show dialog in UI
        );
      case ContentType.geo:
        return ContentAction(
          icon: Icons.map,
          label: 'Open in Maps',
          handler: () => _openInMaps(content),
        );
      case ContentType.calendar:
        return ContentAction(
          icon: Icons.event,
          label: 'View Event Details',
          handler: null, // Will show dialog in UI
        );
      case ContentType.text:
        return null; // Copy is default
    }
  }

  /// Get secondary actions for content type
  static List<ContentAction> getSecondaryActions(DetectedContent content) {
    final actions = <ContentAction>[];

    // Add type-specific secondary actions
    switch (content.type) {
      case ContentType.phone:
        actions.add(
          ContentAction(
            icon: Icons.message,
            label: 'Send SMS',
            handler: () => _sendSmsToNumber(content.getField('number') ?? ''),
          ),
        );
        break;
      case ContentType.email:
        // Email already has primary action
        break;
      case ContentType.geo:
        actions.add(
          ContentAction(
            icon: Icons.share_location,
            label: 'Share Location',
            handler: () async {}, // Will use share in UI
          ),
        );
        break;
      case ContentType.vcard:
        if (content.hasField('phone')) {
          actions.add(
            ContentAction(
              icon: Icons.call,
              label: 'Call',
              handler: () => _callNumber(
                DetectedContent(
                  rawData: content.getField('phone') ?? '',
                  type: ContentType.phone,
                  parsedData: {'number': content.getField('phone') ?? ''},
                ),
              ),
            ),
          );
        }
        if (content.hasField('email')) {
          actions.add(
            ContentAction(
              icon: Icons.email,
              label: 'Email',
              handler: () => _sendEmail(
                DetectedContent(
                  rawData: content.getField('email') ?? '',
                  type: ContentType.email,
                  parsedData: {'email': content.getField('email') ?? ''},
                ),
              ),
            ),
          );
        }
        break;
      default:
        break;
    }

    return actions;
  }

  // ===== Action Handlers =====

  static Future<void> _openUrl(DetectedContent content) async {
    final url = content.getField('url') ?? content.rawData;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not open URL');
    }
  }

  static Future<void> _sendEmail(DetectedContent content) async {
    final email = content.getField('email') ?? '';
    final subject = content.getField('subject') ?? '';
    final body = content.getField('body') ?? '';

    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject.isNotEmpty) 'subject': subject,
        if (body.isNotEmpty) 'body': body,
      },
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('Could not open email app');
    }
  }

  static Future<void> _callNumber(DetectedContent content) async {
    final number = content.getField('number') ?? content.rawData;
    final uri = Uri(scheme: 'tel', path: number);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('Could not make phone call');
    }
  }

  static Future<void> _sendSms(DetectedContent content) async {
    final number = content.getField('number') ?? '';
    final message = content.getField('message') ?? '';

    final uri = Uri(
      scheme: 'sms',
      path: number,
      queryParameters: message.isNotEmpty ? {'body': message} : null,
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('Could not open SMS app');
    }
  }

  static Future<void> _sendSmsToNumber(String number) async {
    final uri = Uri(scheme: 'sms', path: number);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('Could not open SMS app');
    }
  }

  static Future<void> _openInMaps(DetectedContent content) async {
    final lat = content.getField('latitude') ?? '';
    final lon = content.getField('longitude') ?? '';

    if (lat.isEmpty || lon.isEmpty) {
      throw Exception('Invalid coordinates');
    }

    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lon',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not open maps');
    }
  }
}

/// Model representing a content action
class ContentAction {
  final IconData icon;
  final String label;
  final Future<void> Function()? handler;

  const ContentAction({
    required this.icon,
    required this.label,
    required this.handler,
  });
}
