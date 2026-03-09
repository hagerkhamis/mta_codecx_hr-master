// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:mta_codex_hr/Features/vacation/domain/use_cases/vacation_use_case.dart';

part 'egraa_vaction_state.dart';

class EgraaVactionCubit extends Cubit<EgraaVactionState> {
  VacationUseCase ozonatUseCase;

  EgraaVactionCubit(this.ozonatUseCase) : super(EgraaInitial());
  Future<void> egraavacation(
      String empId, String eznId, String action, String reason) async {
    emit(const EgraaLoading());
    final result =
        await ozonatUseCase.egraaVacation(empId, eznId, action, reason);

    emit(
      result.fold(
        EgraaFailed.new,
        EgraaSuccessful.new,
      ),
    );
  }
}
