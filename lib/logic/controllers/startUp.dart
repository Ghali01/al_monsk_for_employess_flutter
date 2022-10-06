import 'package:bloc/bloc.dart';
import 'package:employee/utils/server.dart';

class StartUpCubit extends Cubit<bool?> {
  StartUpCubit() : super(null) {
    scan().then((value) => null);
  }

  Future<void> scan() async {
    emit(null);
    bool r = await Server.scan();
    emit(r);
  }
}
