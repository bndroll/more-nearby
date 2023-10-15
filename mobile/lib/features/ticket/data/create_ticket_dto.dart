

class CreateTicketDto {
  final String request;
  final String status;
  final String userId;
  final String tagId;
  final DateTime visitDate;
  final String departmentQueueId;

  const CreateTicketDto({
    required this.request,
    required this.status,
    required this.userId,
    required this.tagId,
    required this.visitDate,
    required this.departmentQueueId,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is CreateTicketDto &&
              runtimeType == other.runtimeType &&
              request == other.request &&
              status == other.status &&
              userId == other.userId &&
              tagId == other.tagId &&
              visitDate == other.visitDate &&
              departmentQueueId == other.departmentQueueId
          );


  @override
  int get hashCode =>
      request.hashCode ^
      status.hashCode ^
      userId.hashCode ^
      tagId.hashCode ^
      visitDate.hashCode ^
      departmentQueueId.hashCode;


  @override
  String toString() {
    return 'TicketDto{ request: $request, status: $status, userId: $userId, tagId: $tagId, visitDate: $visitDate, departmentQueueId: $departmentQueueId,}';
  }


  CreateTicketDto copyWith({
    String? request,
    String? status,
    String? userId,
    String? tagId,
    DateTime? visitDate,
    String? departmentQueueId,
  }) {
    return CreateTicketDto(
      request: request ?? this.request,
      status: status ?? this.status,
      userId: userId ?? this.userId,
      tagId: tagId ?? this.tagId,
      visitDate: visitDate ?? this.visitDate,
      departmentQueueId: departmentQueueId ?? this.departmentQueueId,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'request': request,
      'status': status,
      'userId': userId,
      'tagId': tagId,
      'visitDate': visitDate.toString(),
      'departmentQueueId': departmentQueueId,
    };
  }
}