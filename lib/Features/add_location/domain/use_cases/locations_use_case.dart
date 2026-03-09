import 'package:mta_codex_hr/Features/table/domain/entities/table_entity.dart';

import '../../data/data_sources/remote_data_source/all_locations_remote_data_source.dart';
import '../repositories/locations_repo.dart';

abstract class UseCase<type, Param> {
  Future<AllLocationsResponse> callAllLocations();
  Future<AddLocationtResponse> callAddLocations(
      String empId, dynamic image, String lat, String long);

  Future<DeleteLocationtResponse> callDeleteLocations(String id);
}

class LocationsUseCase extends UseCase<TableEntity, void> {
  final LocationsRepo ta3memRepository;
  LocationsUseCase(this.ta3memRepository);

  @override
  Future<AllLocationsResponse> callAllLocations() async {
    return await ta3memRepository.fetchAllLocations();
  }

  @override
  Future<AddLocationtResponse> callAddLocations(
      String empId, image, String lat, String long) async {
    return await ta3memRepository.addLocations(empId, image, lat, long);
  }

  @override
  Future<DeleteLocationtResponse> callDeleteLocations(String id) {
    return ta3memRepository.deleteLocations(id);
  }
}
