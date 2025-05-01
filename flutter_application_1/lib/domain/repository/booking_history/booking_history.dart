// lib/domain/repository/booking/booking_history.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/models/booking_history/booking_history_model.dart';

abstract class BookingHistoryRepository {
  /// Get all booking history for the current user
  Future<Either<String, List<BookingHistoryModel>>> getBookingHistory();
  
  /// Cancel a booking with the given ID
  Future<Either<String, bool>> cancelBooking(String bookingId);
  
  /// Filter bookings by status
  Future<Either<String, List<BookingHistoryModel>>> getBookingsByStatus(String status);
}