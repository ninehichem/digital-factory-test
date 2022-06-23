import 'dart:ffi';

import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  final String activity;
  final String accessibility;
  final String type;
  final String participants;
  final String price;
  final String link;
  final String key;

  EventModel(
      {required this.activity,
      required this.accessibility,
      required this.type,
      required this.participants,
      required this.price,
      required this.link,
      required this.key});

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        activity: json["activity"],
        accessibility: json["accessibility"].toString(),
        type: json["type"],
        participants: json["participants"].toString(),
        price: json["price"].toString(),
        link: json["link"],
        key: json["key"].toString(),
      );

  @override
  // TODO: implement props
  List<Object?> get props => [activity,accessibility,type,participants,price,link,key];
}
