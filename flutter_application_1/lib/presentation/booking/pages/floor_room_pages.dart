
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/configs/theme/app_colors.dart';
import 'package:flutter_application_1/data/models/room/room.dart';
import 'package:flutter_application_1/domain/repository/booking/booking.dart';
import 'package:flutter_application_1/domain/repository/room/room.dart';
import 'package:flutter_application_1/presentation/booking/pages/room_detail_page.dart';
import 'package:flutter_application_1/service_locator.dart';

class FloorRoomsPage extends StatefulWidget {
  final String buildingCode;
  final int floorNumber;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final int numberOfPeople;
  final int duration;
  
  const FloorRoomsPage({
    Key? key,
    required this.buildingCode,
    required this.floorNumber,
    required this.selectedDate,
    required this.selectedTime,
    required this.numberOfPeople,
    this.duration = 1,
  }) : super(key: key);

  @override
  State<FloorRoomsPage> createState() => _FloorRoomsPageState();
}

class _FloorRoomsPageState extends State<FloorRoomsPage> {
  bool _isLoading = true;
  String _errorMessage = '';
  List<Room> _rooms = [];

  @override
  void initState() {
    super.initState();
    _setupRoomStream();
  }

  void _setupRoomStream() {
    sl<RoomRepository>().streamRoomsByBuilding(widget.buildingCode).listen((rooms) async {
      if (!mounted) return;

      var filteredRooms = rooms
          .where((room) =>
              room.floor == widget.floorNumber &&
              room.capacity >= widget.numberOfPeople)
          .toList();

      List<Room> availableRooms = [];
      final bookingRepo = sl<BookingRepository>();
      for (var room in filteredRooms) {
        if (room.status != 'available') continue;

        final availabilityResult = await bookingRepo.checkRoomAvailability(
          widget.buildingCode,
          room.roomNumber,
          widget.selectedDate,
          widget.selectedTime,
          widget.duration,
          widget.numberOfPeople,
        );

        bool isAvailable = false;
        availabilityResult.fold(
          (error) => print('Lỗi kiểm tra phòng ${room.roomNumber}: $error'),
          (available) => isAvailable = available,
        );

        if (isAvailable) {
          availableRooms.add(room);
        }
      }

      if (mounted) {
        setState(() {
          _rooms = availableRooms;
          _isLoading = false;
        });
      }
    }, onError: (error) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Lỗi: $error';
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Tầng ${widget.floorNumber} - ${widget.buildingCode}',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                'Thông tin đặt phòng',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Ngày:'),
                                  Text(
                                    '${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Thời gian:'),
                                  Text(
                                    widget.selectedTime.format(context),
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Số người:'),
                                  Text(
                                    '${widget.numberOfPeople}',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Thời lượng:'),
                                  Text(
                                    '${widget.duration} giờ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Text(
                            'Danh sách phòng',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text('Trống'),
                                SizedBox(width: 12),
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text('Đã đặt'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.3,
                        ),
                        itemCount: _rooms.length,
                        itemBuilder: (context, index) {
                          final room = _rooms[index];
                          final isAvailable = room.status == 'available';
                          
                          return GestureDetector(
                            onTap: isAvailable 
                                ? () => _onRoomSelected(room) 
                                : null,
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: isAvailable ? Colors.green : Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      room.roomNumber,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: isAvailable ? Colors.black : Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: isAvailable ? Colors.green : Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        isAvailable ? 'Trống' : 'Đã đặt',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Sức chứa: ${room.capacity} người',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isAvailable ? Colors.black87 : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }

  void _onRoomSelected(Room room) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoomDetailPage(
          buildingCode: widget.buildingCode,
          roomNumber: room.roomNumber,
          floor: widget.floorNumber,
          selectedDate: widget.selectedDate,
          selectedTime: widget.selectedTime,
          numberOfPeople: widget.numberOfPeople,
          duration: widget.duration,
          room: room,
        ),
      ),
    );
  }
}