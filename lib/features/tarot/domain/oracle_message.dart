class OracleMessage {
  final String role; // 'user' | 'model'
  final String content;
  final DateTime timestamp;

  const OracleMessage({
    required this.role,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'role': role,
        'content': content,
        'timestamp': timestamp.toIso8601String(),
      };

  factory OracleMessage.fromJson(Map<String, dynamic> json) => OracleMessage(
        role: json['role'] as String? ?? 'user',
        content: json['content'] as String? ?? '',
        timestamp: json['timestamp'] != null
            ? DateTime.parse(json['timestamp'] as String)
            : DateTime.now(),
      );
}
