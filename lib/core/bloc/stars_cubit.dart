import 'package:flutter_bloc/flutter_bloc.dart';

class StarsCubit extends Cubit<int> {
  StarsCubit() : super(0);

  void addStars(int count) {
    emit(state + count);
  }

  void setStars(int count) {
    emit(count);
  }
}
