import '../models/eventModel.dart';
import '../webservices/requestRandomEvent.dart';

class RandomEventRepository {
  final RequestService requestService;

  RandomEventRepository({
    required this.requestService,
  });

  Future<EventModel> getRandomEvent() async {
    final event = await requestService.requestRandomEvent();
    return EventModel.fromJson(event);
  }

  Future<EventModel> getEventByType(String type) async {
    final event = await requestService.requestEventbyType(type);
    return EventModel.fromJson(event);
  }

//Future<EventModel>
  getEventByPrice(num price) async {
    final event = await requestService.requestEventbyPrice(price);
    print("event === $event");
    return event; //EventModel.fromJson(event);
  }
}
