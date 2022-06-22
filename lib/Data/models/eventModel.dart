import 'dart:ffi';

import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  final String activity;
  final num accessibility;
  final String type;
  final num participants;
  final num price;
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
        activity: json["activity"] ,
        accessibility: json["accessibility"],
        type: json["type"],
        participants: json["participants"],
        price: json["price"],
        link: json["link"],
        key: json["key"],
      );

  @override
  // TODO: implement props
  List<Object?> get props => [activity,accessibility,type,participants,price,link,key];
}
