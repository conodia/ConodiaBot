class EmbedEntityMessage {
  final String title;
  final String description;
  final String? footer;
  final String? button;

  EmbedEntityMessage({required this.title, required this.description, this.footer, this.button});

  factory EmbedEntityMessage.from({ required dynamic payload }) {
    return EmbedEntityMessage(
      title: payload['title'],
      description: payload['description'],
      footer: payload['footer'],
      button: payload['button'],
    );
  }
}