import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:flutter_application_1/data/models/booking/booking_request.dart';
import 'package:flutter_application_1/domain/repository/booking/booking.dart';
import 'package:flutter_application_1/service_locator.dart';

class CreateBookingUseCase implements UseCase<Either<String, String>, BookingRequest> {
  @override
  Future<Either<String, String>> call(BookingRequest? params) async {
    if (params == null) {
      return Left('Yêu cầu đặt phòng không hợp lệ');
    }
    return sl<BookingRepository>().createBooking(params);
  }
}