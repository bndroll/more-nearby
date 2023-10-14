import 'dart:convert';

class Tag {
  final String id;
  final String title;
  final String prefix;
  final String type;
  final int time;

  const Tag({
    required this.id,
    required this.title,
    required this.prefix,
    required this.type,
    required this.time,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          prefix == other.prefix &&
          type == other.type &&
          time == other.time);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      prefix.hashCode ^
      type.hashCode ^
      time.hashCode;

  @override
  String toString() {
    return 'Tag{ id: $id, title: $title, prefix: $prefix, type: $type, time: $time,}';
  }

  Tag copyWith({
    String? id,
    String? title,
    String? prefix,
    String? type,
    int? time,
  }) {
    return Tag(
      id: id ?? this.id,
      title: title ?? this.title,
      prefix: prefix ?? this.prefix,
      type: type ?? this.type,
      time: time ?? this.time,
    );
  }


  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'] as String,
      title: map['title'] as String,
      prefix: map['prefix'] as String,
      type: map['type'] as String,
      time: map['time'] as int,
    );
  }

  static List<Tag> listFromJson(String json) =>  List<Tag>.from(
  jsonDecode(json).map((x) => Tag.fromMap(x)));

}