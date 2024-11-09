class Failure {
  int code;
  String message;

  Failure({required this.code, required this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
