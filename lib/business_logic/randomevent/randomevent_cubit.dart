import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Data/models/eventModel.dart';
import '../../Data/repositories/randomeventrepo.dart';

part 'randomevent_state.dart';

class RandomeventCubit extends Cubit<RandomeventState> {
  final RandomEventRepository randomEventRepository;
  RandomeventCubit(this.randomEventRepository) : super(RandomeventInitial());

  void fetchRandomEvent() {
    try {
      emit(RandomeventLoading());
      randomEventRepository.getRandomEvent().then((value) {
        print(value.activity);
        emit(RandomeventSuccess(value));
      });
    } catch (e) {
      emit(RandomeventFailure(e.toString()));
    }
  }

  void fetchEventbytype(String type) {
    try {
      emit(RandomeventLoading());
      randomEventRepository.getEventByType(type).then((value) {
        print(value.activity);
        emit(RandomeventSuccess(value));
      });
    } catch (e) {
      emit(RandomeventFailure(e.toString()));
    }
  }

  void fetchEventbyprice(num price) {
    try {
      emit(RandomeventLoading());
      randomEventRepository.getEventByPrice(price).then((value) {
        print(value.activity);
        emit(RandomeventSuccess(value));
      });
    } catch (e) {
      print('e ============$e');
      emit(RandomeventFailure(e.toString()));
    }
  }
}
