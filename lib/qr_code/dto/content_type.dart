/// Enum representing different types of QR code content
enum ContentType {
  url('URL', 'Web Link'),
  email('Email', 'Email Address'),
  phone('Phone', 'Phone Number'),
  sms('SMS', 'Text Message'),
  wifi('Wi-Fi', 'WiFi Network'),
  vcard('vCard', 'Contact'),
  geo('Geo', 'Location'),
  calendar('Calendar', 'Event'),
  text('Text', 'Plain Text');

  final String code;
  final String displayName;

  const ContentType(this.code, this.displayName);

  /// Get ContentType from string code
  static ContentType fromCode(String code) {
    return ContentType.values.firstWhere(
      (type) => type.code == code,
      orElse: () => ContentType.text,
    );
  }
}
