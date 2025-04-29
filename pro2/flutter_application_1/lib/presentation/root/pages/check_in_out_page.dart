import 'package:flutter/material.dart';
import 'root.dart';

class CheckInOutPage extends StatefulWidget {
  const CheckInOutPage({super.key});

  @override
  _CheckInOutPageState createState() => _CheckInOutPageState();
}

class _CheckInOutPageState extends State<CheckInOutPage> {
  final TextEditingController _roomCodeController = TextEditingController();
  List<Map<String, String>> bookings = [
    {
      'room': 'BK.B1',
      'date': '29/04/2025',
      'time': '14:00 - 16:00',
      'status': 'Chưa nhận',
    },
  ];

  void _checkInOut(String action) {
    setState(() {
      bookings[0]['status'] = action == 'checkIn' ? 'Đã nhận' : 'Đã trả';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(action == 'checkIn' ? 'Nhận phòng thành công' : 'Trả phòng thành công')),
    );
  }

  @override
  void dispose() {
    _roomCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const RootPage()),
              (route) => false,
            );
          },
          child: const Text('Nhận/Trả Phòng'),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _roomCodeController,
              decoration: InputDecoration(
                labelText: 'Mã phòng',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            bookings.isNotEmpty
                ? Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phòng: ${bookings[0]['room']}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ngày: ${bookings[0]['date']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Giờ: ${bookings[0]['time']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: bookings[0]['status'] == 'Chưa nhận'
                                    ? () => _checkInOut('checkIn')
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text('Nhận Phòng'),
                              ),
                              ElevatedButton(
                                onPressed: bookings[0]['status'] == 'Đã nhận'
                                    ? () => _checkInOut('checkOut')
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text('Trả Phòng'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: bookings[0]['status'] == 'Chưa nhận'
                                  ? Colors.orange
                                  : bookings[0]['status'] == 'Đã nhận'
                                      ? Colors.green
                                      : Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Trạng thái: ${bookings[0]['status']}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const Text('Không tìm thấy phòng'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}