class MessagesModel {
  final String message;
  final String id;
  MessagesModel(this.message, this.id);

  factory MessagesModel.fromJson(JsonData) {
    return MessagesModel(JsonData['message'], JsonData['id']);
  }
}
