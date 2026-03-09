// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:mta_codex_hr/Features/ezen/domain/use_cases/ezen_use_case.dart';

part 'add_ezen_state.dart';

class AddEzenCubit extends Cubit<AddEzenState> {
  EzenUseCase ezenUseCase;

  AddEzenCubit(this.ezenUseCase) : super(AddEzenInitial());
  Future<void> addEzen(String empId, String typeId, String fromTime,
      String toTime, String reason) async {
    emit(const AddEzenLoading());
    final result =
        await ezenUseCase.addEzen(empId, typeId, fromTime, toTime, reason);

    emit(
      result.fold(
        AddEzenFailed.new,
        AddEzenSuccessful.new,
      ),
    );
  }

  Future<void> editEzen(String ezenId, String empId, String typeId,
      String fromTime, String toTime, String reason) async {
    emit(const AddEzenLoading());
    final result = await ezenUseCase.editEzen(
        ezenId, empId, typeId, fromTime, toTime, reason);

    emit(
      result.fold(
        AddEzenFailed.new,
        AddEzenSuccessful.new,
      ),
    );
  }
}
