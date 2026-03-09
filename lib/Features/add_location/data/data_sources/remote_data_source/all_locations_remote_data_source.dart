import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:mta_codex_hr/Features/auth/login/domain/entities/employee_entity.dart';
import 'package:mta_codex_hr/core/utils/constants.dart';
import 'package:mta_codex_hr/core/utils/functions/setup_service_locator.dart';

import '../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';
import '../../models/locations.dart';
import '../../models/locations_model.dart';

typedef AllLocationsResponse = Either<String, AllLocationsList>;
typedef AddLocationtResponse = Either<String, String>;

typedef DeleteLocationtResponse = Either<String, String>;

abstract class AllLocationsRemoteDataSource {
  Future<AllLocationsResponse> fetchAllLocations();
  Future<AddLocationtResponse> addLocations(
      String empId, dynamic image, String lat, String long);

  Future<DeleteLocationtResponse> deleteLocations(String id);
}

class AllLocationsRemoteDataSourceImpl extends AllLocationsRemoteDataSource {
  @override
  Future<AllLocationsResponse> fetchAllLocations() async {
    AllLocationsResponse allTa3memResponse = left("");
    var box = Hive.box<EmployeeEntity>(kEmployeeDataBox);
    var body = {
      "page": "1",
      "per_page": "100",
      "emp_id": box.get(kEmployeeDataBox)!.employeeId!
    };
    await getIt<NetworkRequest>().requestFutureData<LocationsModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerGetLocationList,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200 && data.data != null) {
          allTa3memResponse = right(data.data!);
        } else if (data.status == 200 && data.data == null) {
          allTa3memResponse = left(data.message!);
        } else {
          allTa3memResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        allTa3memResponse = left(code.toString());
      },
    );
    return allTa3memResponse;
  }

  @override
  Future<AddLocationtResponse> addLocations(
      String empId, dynamic image, String lat, String long) async {
    AddLocationtResponse fingerPrintResponse = left("");

    var formData = FormData();
    formData.fields.add(MapEntry("emp_id", empId));
    formData.fields.add(MapEntry("lat", lat));
    formData.fields.add(MapEntry("long", long));

    if (image != null) {
      formData.files.add(MapEntry(
        "emp_img",
        await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last),
      ));
    }
    await getIt<NetworkRequest>().requestFutureData<LocationsModel>(
      Method.post,
      formData: formData,
      isFormData: true,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerAddLocation,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200) {
          fingerPrintResponse = right(data.message!);
        } else {
          fingerPrintResponse = left(data.message.toString());
        }
      },
      onError: (code, msg) {
        fingerPrintResponse = left(msg.toString());
      },
    );
    return fingerPrintResponse;
  }

  @override
  Future<DeleteLocationtResponse> deleteLocations(String id) async {
    DeleteLocationtResponse deleteLocationtResponse = left("");
    var body = {"zeyara_id": id};
    await getIt<NetworkRequest>().requestFutureData<LocationsModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerDeleteLocation,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200) {
          deleteLocationtResponse = right(data.message!);
        } else {
          deleteLocationtResponse = left(data.message.toString());
        }
      },
      onError: (code, msg) {
        deleteLocationtResponse = left(msg.toString());
      },
    );

    return deleteLocationtResponse;
  }
}
