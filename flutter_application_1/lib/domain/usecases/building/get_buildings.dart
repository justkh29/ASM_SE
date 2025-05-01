import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/data/models/building/building.dart';
import 'package:flutter_application_1/domain/repository/building/building.dart';
import 'package:flutter_application_1/service_locator.dart';

class GetBuildingsUseCase implements UseCase<Either<String, List<Building>>, void> {
  @override
  Future<Either<String, List<Building>>> call(void params) async {
    return await sl<BuildingRepository>().getBuildings();
  }
}