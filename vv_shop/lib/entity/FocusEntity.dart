// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

FocusEntity welcomeFromJson(String str) => FocusEntity.fromJson(json.decode(str));

String welcomeToJson(FocusEntity data) => json.encode(data.toJson());

class FocusEntity {
  List<FocusItem> result;

  FocusEntity({
    required this.result,
  });

  factory FocusEntity.fromJson(Map<String, dynamic> json) => FocusEntity(
    result: List<FocusItem>.from(json["result"].map((x) => FocusItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class FocusItem {
  String id;
  String title;
  String status;
  String pic;
  String? url;

  FocusItem({
    required this.id,
    required this.title,
    required this.status,
    required this.pic,
    this.url,
  });

  factory FocusItem.fromJson(Map<String, dynamic> json) => FocusItem(
    id: json["_id"],
    title: json["title"],
    status: json["status"],
    pic: json["pic"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "status": status,
    "pic": pic,
    "url": url,
  };
}
