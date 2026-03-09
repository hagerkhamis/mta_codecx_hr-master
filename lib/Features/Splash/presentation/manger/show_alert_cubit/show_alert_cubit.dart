// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:mta_codex_hr/Features/Splash/domain/entities/show_alert_entity.dart';
import 'package:mta_codex_hr/Features/Splash/domain/use_case/alert_use_case.dart';

part 'show_alert_state.dart';

class ShowAlertCubit extends Cubit<ShowAlertState> {
  AlertUseCase alertUseCase;

  ShowAlertCubit(this.alertUseCase) : super(ShowAlertInitial());
  Future<void> showAlert(String empId) async {
    emit(const ShowAlertLoading());
    final result = await alertUseCase.getShowAlert(empId);

    emit(
      result.fold(
        ShowAlertFailed.new,
        ShowAlertSuccessful.new,
      ),
    );
  }
}
