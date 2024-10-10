class Notification {
  String id; // Identifiant unique de la notification
  String title; // Titre de la notification
  String content; // Contenu de la notification
  String recipientId; // ID du destinataire (agriculteur)
  bool isRead; // Statut de lecture
  DateTime createdAt; // Date de création de la notification

  Notification({
    required this.id,
    required this.title,
    required this.content,
    required this.recipientId,
    this.isRead = false,
    required this.createdAt,
  });

  // Méthode pour convertir une notification en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'recipientId': recipientId,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Méthode pour créer une notification à partir de JSON
  static Notification fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      recipientId: json['recipientId'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
