// To parse this JSON data, do
//
//     final catListRes = catListResFromJson(jsonString);

import 'dart:convert';

List<DogListRes> dogListResFromJson(String str) => List<DogListRes>.from(json.decode(str).map((x) => DogListRes.fromJson(x)));

String dogListResToJson(List<DogListRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DogListRes {
  List<dynamic> breeds;
  String id;
  String url;
  int width;
  int height;
  dynamic subId;
  DateTime createdAt;
  String originalFilename;
  dynamic breedIds;

  DogListRes({
    required this.breeds,
    required this.id,
    required this.url,
    required this.width,
    required this.height,
    required this.subId,
    required this.createdAt,
    required this.originalFilename,
    required this.breedIds,
  });

  factory DogListRes.fromJson(Map<String, dynamic> json) => DogListRes(
    breeds: List<dynamic>.from(json["breeds"].map((x) => x)),
    id: json["id"],
    url: json["url"],
    width: json["width"],
    height: json["height"],
    subId: json["sub_id"],
    createdAt: DateTime.parse(json["created_at"]),
    originalFilename: json["original_filename"],
    breedIds: json["breed_ids"],
  );

  Map<String, dynamic> toJson() => {
    "breeds": List<dynamic>.from(breeds.map((x) => x)),
    "id": id,
    "url": url,
    "width": width,
    "height": height,
    "sub_id": subId,
    "created_at": createdAt.toIso8601String(),
    "original_filename": originalFilename,
    "breed_ids": breedIds,
  };
}