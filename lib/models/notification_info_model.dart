// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotificationInfo {
  final String senderName;
  final String urlToImage;
  final String content;
  final String value;
  final Function(String payload)? onPressed;
  NotificationInfo({
    required this.senderName,
    required this.urlToImage,
    required this.content,
    required this.value,
    this.onPressed,
  });
  

  NotificationInfo copyWith({
    String? senderName,
    String? urlToImage,
    String? content,
    String? value,
    Function(String payload)? onPressed,
  }) {
    return NotificationInfo(
      senderName: senderName ?? this.senderName,
      urlToImage: urlToImage ?? this.urlToImage,
      content: content ?? this.content,
      value: value ?? this.value,
      onPressed: onPressed ?? this.onPressed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderName': senderName,
      'urlToImage': urlToImage,
      'content': content,
      'value': value,
      // 'onPressed': onPressed.toMap(),
    };
  }

  factory NotificationInfo.fromMap(Map<String, dynamic> map) {
    return NotificationInfo(
      senderName: map['senderName'] as String,
      urlToImage: map['urlToImage'] as String,
      content: map['content'] as String,
      value: map['value'] as String,
      // onPressed: Function(String payload).fromMap(map['onPressed'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationInfo.fromJson(String source) => NotificationInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationInfo(senderName: $senderName, urlToImage: $urlToImage, content: $content, value: $value, onPressed: $onPressed)';
  }

  @override
  bool operator ==(covariant NotificationInfo other) {
    if (identical(this, other)) return true;
  
    return 
      other.senderName == senderName &&
      other.urlToImage == urlToImage &&
      other.content == content &&
      other.value == value &&
      other.onPressed == onPressed;
  }

  @override
  int get hashCode {
    return senderName.hashCode ^
      urlToImage.hashCode ^
      content.hashCode ^
      value.hashCode ^
      onPressed.hashCode;
  }
}
