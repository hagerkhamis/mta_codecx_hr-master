import 'package:mta_codex_hr/Features/mosalat/data/models/my_messages_model/mosalat.dart';
import 'package:mta_codex_hr/core/utils/functions/base_one_response.dart';

class MyMosalatModel extends BaseOneResponse {
  const MyMosalatModel({
    super.status,
    super.data,
    super.message,
  });

  factory MyMosalatModel.fromJson(Map<String, dynamic> json) {
    return MyMosalatModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Mosalat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
