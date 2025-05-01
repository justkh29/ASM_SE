// lib/data/repository/booking_history/booking_history_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/models/booking_history/booking_history_model.dart';
import 'package:flutter_application_1/data/sources/booking_history/booking_history_firebase_service.dart';
import 'package:flutter_application_1/domain/repository/booking_history/booking_history.dart';
import 'package:flutter_application_1/service_locator.dart';

class BookingHistoryRepositoryImpl implements BookingHistoryRepository {
  final BookingHistoryFirebaseService _service = sl<BookingHistoryFirebaseService>();

  @override
  Future<Either<String, List<BookingHistoryModel>>> getBookingHistory() async {
    try {
      final bookings = await _service.fetchBookingHistory();
      return Right(bookings);
    } catch (e) {
      return Left('Failed to fetch booking history: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, bool>> cancelBooking(String bookingId) async {
    try {
      final result = await _service.cancelBooking(bookingId);
      return Right(result);
    } catch (e) {
      return Left('Failed to cancel booking: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, List<BookingHistoryModel>>> getBookingsByStatus(String status) async {
    try {
      final bookings = await _service.fetchBookingsByStatus(status);
      return Right(bookings);
    } catch (e) {
      return Left('Failed to fetch bookings by status: ${e.toString()}');
    }
  }
}