import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/data/models/booking/booking_request.dart';
import 'package:flutter_application_1/domain/repository/booking/booking.dart';
import 'package:flutter_application_1/service_locator.dart';

class DeleteBookingUseCase implements UseCase<Either<String, void>, BookingRequest> {
  @override
  Future<Either<String, void>> call(BookingRequest params) async {
    return await sl<BookingRepository>().deleteBooking(params);
  }
}