// To parse this JSON data, do
//
//     final dogUploadRes = dogUploadResFromJson(jsonString);

import 'dart:convert';

DogUploadRes dogUploadResFromJson(String str) => DogUploadRes.fromJson(json.decode(str));

String dogUploadResToJson(DogUploadRes data) => json.encode(data.toJson());

class DogUploadRes {
  String id;
  String url;
  int width;
  int height;
  String originalFilename;
  int pending;
  int approved;

  DogUploadRes({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
    required this.originalFilename,
    required this.pending,
    required this.approved,
  });

  factory DogUploadRes.fromJson(Map<String, dynamic> json) => DogUploadRes(
    id: json["id"],
    url: json["url"],
    width: json["width"],
    height: json["height"],
    originalFilename: json["original_filename"],
    pending: json["pending"],
    approved: json["approved"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "width": width,
    "height": height,
    "original_filename": originalFilename,
    "pending": pending,
    "approved": approved,
  };
}