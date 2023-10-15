
class TicketDto {
  final String id;
  final String title;
  final int num;
  final String status;
  final String request;
  final int predictionTime;



  const TicketDto({
    required this.id,
    required this.title,
    required this.num,
    required this.status,
    required this.request,
    required this.predictionTime,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is TicketDto &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              title == other.title &&
              num == other.num &&
              status == other.status &&
              request == other.request &&
              predictionTime == other.predictionTime
          );


  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      num.hashCode ^
      status.hashCode ^
      request.hashCode ^
      predictionTime.hashCode;


  @override
  String toString() {
    return 'TicketDto{ id: $id, title: $title, num: $num, status: $status, request: $request, predictionTime: $predictionTime,}';
  }


  TicketDto copyWith({
    String? id,
    String? title,
    int? num,
    String? status,
    String? request,
    int? predictionTime,
  }) {
    return TicketDto(
      id: id ?? this.id,
      title: title ?? this.title,
      num: num ?? this.num,
      status: status ?? this.status,
      request: request ?? this.request,
      predictionTime: predictionTime ?? this.predictionTime,
    );
  }

  factory TicketDto.fromMap(Map<String, dynamic> map) {
    return TicketDto(
      id: map['id'] as String,
      title: map['title'] as String,
      num: map['num'] as int,
      status: map['status'] as String,
      request: map['request'] as String,
      predictionTime: map['predictionTime'] as int,
    );
  }
}