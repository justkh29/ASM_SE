
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/core/configs/theme/app_colors.dart';
// import 'package:flutter_application_1/data/models/building/building.dart';
// import 'package:flutter_application_1/data/models/room/room.dart';
// import 'package:flutter_application_1/domain/repository/room/room.dart';
// import 'package:flutter_application_1/domain/usecases/building/get_building_by_code.dart';
// import 'package:flutter_application_1/presentation/booking/pages/floor_room_pages.dart';
// import 'package:flutter_application_1/service_locator.dart';
// import 'package:flutter_application_1/domain/repository/booking/booking.dart';
// import 'package:intl/intl.dart';

// class BuildingDetailPage extends StatefulWidget {
//   final String buildingCode;
//   final DateTime selectedDate;
//   final TimeOfDay selectedTime;
//   final int numberOfPeople;
//   final int duration;
  
//   BuildingDetailPage({
//     Key? key,
//     required this.buildingCode,
//     DateTime? selectedDate,
//     required this.selectedTime,
//     required this.numberOfPeople,
//     this.duration = 1,
//   })  : selectedDate = selectedDate ?? DateTime.now(),
//         super(key: key);

//   @override
//   State<BuildingDetailPage> createState() => _BuildingDetailPageState();
// }

// class _BuildingDetailPageState extends State<BuildingDetailPage> {
//   late Building _building;
//   late List<Map<String, dynamic>> _floors;
//   bool _isLoading = true;
//   String _errorMessage = '';
//   List<Room> _allRooms = [];
//   Map<int, int> _availableRoomsByFloor = {};

//   @override
//   void initState() {
//     super.initState();
//     _loadBuildingData();
//   }

//   Future<void> _loadBuildingData() async {
//     try {
//       setState(() {
//         _isLoading = true;
//       });

//       final buildingResult = await sl<GetBuildingByCodeUseCase>().call(widget.buildingCode);
      
//       await buildingResult.fold(
//         (error) {
//           setState(() {
//             _errorMessage = error;
//             _isLoading = false;
//           });
//         },
//         (building) async {
//           _building = building;
          
//           _floors = List.generate(building.floors, (index) {
//             return {
//               'number': building.floors - index,
//               'available': 0,
//               'isHighlighted': index == 0,
//             };
//           });
          
//           sl<RoomRepository>().streamRoomsByBuilding(widget.buildingCode).listen((rooms) async {
//             if (!mounted) return;

//             _allRooms = rooms.where((room) => room.capacity >= widget.numberOfPeople).toList();
            
//             _availableRoomsByFloor.clear();
            
//             for (var room in _allRooms) {
//               if (room.status != 'available') continue;

//               final bookingRepo = sl<BookingRepository>();
//               final availabilityResult = await bookingRepo.checkRoomAvailability(
//                 widget.buildingCode,
//                 room.roomNumber,
//                 widget.selectedDate,
//                 widget.selectedTime,
//                 widget.duration,
//                 widget.numberOfPeople,
//               );

//               bool isAvailable = false;
//               availabilityResult.fold(
//                 (error) => print('Lỗi kiểm tra phòng ${room.roomNumber}: $error'),
//                 (available) => isAvailable = available,
//               );

//               if (isAvailable) {
//                 _availableRoomsByFloor.update(
//                   room.floor,
//                   (value) => value + 1,
//                   ifAbsent: () => 1,
//                 );
//               }
//             }

//             if (mounted) {
//               setState(() {
//                 for (var floor in _floors) {
//                   final floorNumber = floor['number'] as int;
//                   floor['available'] = _availableRoomsByFloor[floorNumber] ?? 0;
//                 }
                
//                 _isLoading = false;
//               });
//             }
//           }, onError: (error) {
//             if (mounted) {
//               setState(() {
//                 _errorMessage = 'Lỗi khi lấy dữ liệu phòng: $error';
//                 _isLoading = false;
//               });
//             }
//           });
//         },
//       );
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _errorMessage = 'Lỗi: ${e.toString()}';
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         elevation: 0,
//         title: Text('Chi tiết tòa ${widget.buildingCode}', style: TextStyle(color: Colors.white)),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//               ? Center(child: Text(_errorMessage))
//               : Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Card(
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.all(12),
//                                     decoration: BoxDecoration(
//                                       color: Colors.amber,
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: Text(
//                                       widget.buildingCode,
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 12),
//                                   Expanded(
//                                     child: Text(
//                                       _building.name,
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 12),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Số tầng: ${_building.floors}',
//                                     style: const TextStyle(fontWeight: FontWeight.w500),
//                                   ),
//                                   RichText(
//                                     text: TextSpan(
//                                       style: TextStyle(color: Colors.black),
//                                       children: [
//                                         TextSpan(
//                                           text: 'Đặt phòng: ',
//                                           style: TextStyle(fontWeight: FontWeight.w500),
//                                         ),
//                                         TextSpan(
//                                           text: DateFormat('dd/MM/yyyy').format(widget.selectedDate),
//                                           style: TextStyle(
//                                             color: AppColors.primary,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 4),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   RichText(
//                                     text: TextSpan(
//                                       style: TextStyle(color: Colors.black),
//                                       children: [
//                                         TextSpan(
//                                           text: 'Phòng trống: ',
//                                           style: TextStyle(fontWeight: FontWeight.w500),
//                                         ),
//                                         TextSpan(
//                                           text: '${_availableRoomsByFloor.values.fold(0, (sum, count) => sum + count)}',
//                                           style: TextStyle(
//                                             color: Colors.green,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         TextSpan(
//                                           text: '/${_building.totalRooms}',
//                                           style: TextStyle(fontWeight: FontWeight.w500),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   RichText(
//                                     text: TextSpan(
//                                       style: TextStyle(color: Colors.black),
//                                       children: [
//                                         TextSpan(
//                                           text: 'Thời gian: ',
//                                           style: TextStyle(fontWeight: FontWeight.w500),
//                                         ),
//                                         TextSpan(
//                                           text: widget.selectedTime.format(context),
//                                           style: TextStyle(
//                                             color: AppColors.primary,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 4),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   RichText(
//                                     text: TextSpan(
//                                       style: TextStyle(color: Colors.black),
//                                       children: [
//                                         TextSpan(
//                                           text: 'Số người: ',
//                                           style: TextStyle(fontWeight: FontWeight.w500),
//                                         ),
//                                         TextSpan(
//                                           text: '${widget.numberOfPeople}',
//                                           style: TextStyle(
//                                             color: AppColors.primary,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   RichText(
//                                     text: TextSpan(
//                                       style: TextStyle(color: Colors.black),
//                                       children: [
//                                         TextSpan(
//                                           text: 'Thời lượng: ',
//                                           style: TextStyle(fontWeight: FontWeight.w500),
//                                         ),
//                                         TextSpan(
//                                           text: '${widget.duration} giờ',
//                                           style: TextStyle(
//                                             color: AppColors.primary,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
                    
//                     const SizedBox(height: 20),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Text(
//                         'Chọn tầng',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
                    
//                     Expanded(
//                       child: ListView.builder(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         itemCount: _floors.length,
//                         itemBuilder: (context, index) {
//                           final floor = _floors[index];
//                           final bool isHighlighted = floor['isHighlighted'];
//                           final int floorNumber = floor['number'];
//                           final int availableRooms = floor['available'];
                          
//                           return Card(
//                             elevation: 2,
//                             margin: const EdgeInsets.only(bottom: 10),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: ListTile(
//                               onTap: availableRooms > 0 
//                                   ? () => _onFloorTap(context, floorNumber) 
//                                   : null,
//                               contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                               tileColor: isHighlighted ? AppColors.primary.withOpacity(0.1) : null,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 side: BorderSide(
//                                   color: isHighlighted ? AppColors.primary : Colors.transparent,
//                                   width: 1,
//                                 ),
//                               ),
//                               leading: CircleAvatar(
//                                 backgroundColor: isHighlighted ? AppColors.primary : AppColors.lightBlue,
//                                 child: Text(
//                                   '$floorNumber',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               title: Text(
//                                 'Tầng $floorNumber',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               subtitle: RichText(
//                                 text: TextSpan(
//                                   style: TextStyle(
//                                     color: Colors.black87,
//                                     fontSize: 14,
//                                   ),
//                                   children: [
//                                     TextSpan(text: 'Còn '),
//                                     TextSpan(
//                                       text: '$availableRooms',
//                                       style: TextStyle(
//                                         color: availableRooms > 0 ? Colors.green : Colors.red,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     TextSpan(text: ' phòng trống'),
//                                   ],
//                                 ),
//                               ),
//                               trailing: availableRooms > 0
//                                   ? Icon(Icons.arrow_forward_ios, color: AppColors.primary)
//                                   : null,
//                               enabled: availableRooms > 0,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//     );
//   }

//   void _onFloorTap(BuildContext context, int floorNumber) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FloorRoomsPage(
//           buildingCode: widget.buildingCode,
//           floorNumber: floorNumber,
//           selectedDate: widget.selectedDate,
//           selectedTime: widget.selectedTime,
//           numberOfPeople: widget.numberOfPeople,
//           duration: widget.duration, // Truyền duration
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/configs/theme/app_colors.dart';
import 'package:flutter_application_1/data/models/building/building.dart';
import 'package:flutter_application_1/data/models/room/room.dart';
import 'package:flutter_application_1/domain/repository/room/room.dart';
import 'package:flutter_application_1/domain/usecases/building/get_building_by_code.dart';
import 'package:flutter_application_1/presentation/booking/pages/floor_room_pages.dart';
import 'package:flutter_application_1/service_locator.dart';
import 'package:flutter_application_1/domain/repository/booking/booking.dart';
import 'package:intl/intl.dart';

class BuildingDetailPage extends StatefulWidget {
  final String buildingCode;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final int numberOfPeople;
  final int duration;
  
  BuildingDetailPage({
    Key? key,
    required this.buildingCode,
    DateTime? selectedDate,
    required this.selectedTime,
    required this.numberOfPeople,
    this.duration = 1,
  })  : selectedDate = selectedDate ?? DateTime.now(),
        super(key: key);

  @override
  State<BuildingDetailPage> createState() => _BuildingDetailPageState();
}

class _BuildingDetailPageState extends State<BuildingDetailPage> {
  late Building _building;
  late List<Map<String, dynamic>> _floors;
  bool _isLoading = true;
  String _errorMessage = '';
  List<Room> _allRooms = [];
  Map<int, int> _availableRoomsByFloor = {};

  @override
  void initState() {
    super.initState();
    _loadBuildingData();
  }

  Future<void> _loadBuildingData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final buildingResult = await sl<GetBuildingByCodeUseCase>().call(widget.buildingCode);
      
      await buildingResult.fold(
        (error) {
          setState(() {
            _errorMessage = error;
            _isLoading = false;
          });
        },
        (building) async {
          _building = building;
          
          _floors = List.generate(building.floors, (index) {
            return {
              'number': building.floors - index,
              'available': 0,
              'isHighlighted': index == 0,
            };
          });
          
          sl<RoomRepository>().streamRoomsByBuilding(widget.buildingCode).listen((rooms) async {
            if (!mounted) return;

            // Log số lượng phòng nhận được từ Firestore
            print('Total rooms received for ${widget.buildingCode}: ${rooms.length}');
            for (var room in rooms) {
              print('Room: ${room.roomNumber}, Floor: ${room.floor}, Capacity: ${room.capacity}, Status: ${room.status}');
            }

            _allRooms = rooms.where((room) {
              final meetsCapacity = room.capacity >= widget.numberOfPeople;
              print('Room ${room.roomNumber} meets capacity (${widget.numberOfPeople}): $meetsCapacity');
              return meetsCapacity;
            }).toList();
            
            _availableRoomsByFloor.clear();
            
            for (var room in _allRooms) {
              print('Checking room ${room.roomNumber} with status: ${room.status}');
              if (room.status != 'available') {
                print('Room ${room.roomNumber} is not available (status: ${room.status})');
                continue;
              }

              final bookingRepo = sl<BookingRepository>();
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
                (error) {
                  print('Error checking availability for room ${room.roomNumber}: $error');
                },
                (available) {
                  isAvailable = available;
                  print('Room ${room.roomNumber} availability: $isAvailable');
                },
              );

              if (isAvailable) {
                _availableRoomsByFloor.update(
                  room.floor,
                  (value) => value + 1,
                  ifAbsent: () => 1,
                );
              }
            }

            if (mounted) {
              setState(() {
                for (var floor in _floors) {
                  final floorNumber = floor['number'] as int;
                  floor['available'] = _availableRoomsByFloor[floorNumber] ?? 0;
                  print('Floor $floorNumber has ${floor['available']} available rooms');
                }
                
                _isLoading = false;
              });
            }
          }, onError: (error) {
            if (mounted) {
              setState(() {
                _errorMessage = 'Lỗi khi lấy dữ liệu phòng: $error';
                _isLoading = false;
              });
            }
          });
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Lỗi: ${e.toString()}';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text('Chi tiết tòa ${widget.buildingCode}', style: TextStyle(color: Colors.white)),
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
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      widget.buildingCode,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      _building.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Số tầng: ${_building.floors}',
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: 'Đặt phòng: ',
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                        TextSpan(
                                          text: DateFormat('dd/MM/yyyy').format(widget.selectedDate),
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: 'Phòng trống: ',
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                        TextSpan(
                                          text: '${_availableRoomsByFloor.values.fold(0, (sum, count) => sum + count)}',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '/${_building.totalRooms}',
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: 'Thời gian: ',
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                        TextSpan(
                                          text: widget.selectedTime.format(context),
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: 'Số người: ',
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                        TextSpan(
                                          text: '${widget.numberOfPeople}',
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: 'Thời lượng: ',
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                        TextSpan(
                                          text: '${widget.duration} giờ',
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Chọn tầng',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: _floors.length,
                        itemBuilder: (context, index) {
                          final floor = _floors[index];
                          final bool isHighlighted = floor['isHighlighted'];
                          final int floorNumber = floor['number'];
                          final int availableRooms = floor['available'];
                          
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.only(bottom: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              onTap: availableRooms > 0 
                                  ? () => _onFloorTap(context, floorNumber) 
                                  : null,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              tileColor: isHighlighted ? AppColors.primary.withOpacity(0.1) : null,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                  color: isHighlighted ? AppColors.primary : Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: isHighlighted ? AppColors.primary : AppColors.lightBlue,
                                child: Text(
                                  '$floorNumber',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                'Tầng $floorNumber',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(text: 'Còn '),
                                    TextSpan(
                                      text: '$availableRooms',
                                      style: TextStyle(
                                        color: availableRooms > 0 ? Colors.green : Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(text: ' phòng trống'),
                                  ],
                                ),
                              ),
                              trailing: availableRooms > 0
                                  ? Icon(Icons.arrow_forward_ios, color: AppColors.primary)
                                  : null,
                              enabled: availableRooms > 0,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }

  void _onFloorTap(BuildContext context, int floorNumber) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FloorRoomsPage(
          buildingCode: widget.buildingCode,
          floorNumber: floorNumber,
          selectedDate: widget.selectedDate,
          selectedTime: widget.selectedTime,
          numberOfPeople: widget.numberOfPeople,
          duration: widget.duration,
        ),
      ),
    );
  }
}