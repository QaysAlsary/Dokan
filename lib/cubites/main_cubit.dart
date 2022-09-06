import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/cache_helper.dart';
import '../states/main_states.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialStates());
  static MainCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppModeStates());
    } else {
      isDark = !isDark;

      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeAppModeStates());
      });
    }
  }
}
