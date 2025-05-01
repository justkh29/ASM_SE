import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/data/models/booking/booking_request.dart';
import 'package:flutter_application_1/domain/repository/booking/booking.dart';
import 'package:flutter_application_1/service_locator.dart';

class GetBookingsUseCase implements UseCase<Either<String, List<BookingRequest>>, void> {
  @override
  Future<Either<String, List<BookingRequest>>> call(void params) async {
    return await sl<BookingRepository>().getBookings();
  }
}