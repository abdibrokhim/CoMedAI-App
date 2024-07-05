class ChatMessageModel {
  final String role;
  final String content;

  ChatMessageModel({
    required this.role,
    required this.content,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      role: json['role'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }

  ChatMessageModel copyWith({
    String? role,
    String? content,
  }) {
    return ChatMessageModel(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }
}