import 'dart:convert';

List<NoteModel> noteModelFromJson(String str) =>
    List<NoteModel>.from(json.decode(str).map((x) => NoteModel.fromJson(x)));

String noteModelToJson(List<NoteModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NoteModel {
  final String title;
  final String text;
  final String dateTime;
  final String updateTime;
  final String id;

  NoteModel({
    required this.title,
    required this.text,
    required this.dateTime,
    required this.updateTime,
    required this.id,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        title: json["title"],
        text: json["text"],
        dateTime: json["dateTime"],
        updateTime: json["updateTime"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
        "dateTime": dateTime,
        "updateTime": updateTime,
        "id": id,
      };
}
