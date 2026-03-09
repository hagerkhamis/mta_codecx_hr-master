import 'package:mta_codex_hr/Features/new_bsama_add_Fingerprint/data/models/finger_print_model/data.dart';
import 'package:mta_codex_hr/core/utils/functions/base_one_response.dart';

class NewFingerPrintModel extends BaseOneResponse {
  const NewFingerPrintModel({super.status, super.message, super.data});

  factory NewFingerPrintModel.fromJson(Map<String, dynamic> json) =>
      NewFingerPrintModel(
          status: json['status'] as int?,
          message: json['message'] as String?,
          data: json.containsKey('data')
              ? Data.fromJson(json['data'] as Map<String, dynamic>)
              : null);

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}
