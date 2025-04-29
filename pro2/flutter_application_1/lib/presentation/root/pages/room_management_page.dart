import 'package:flutter/material.dart';
import 'root.dart';

class RoomManagementPage extends StatelessWidget {
  const RoomManagementPage({super.key});

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
          child: const Text('Quản Lý Phòng'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterButton(icon: Icons.location_city, label: 'Mã tòa'),
                FilterButton(icon: Icons.calendar_today, label: 'Ngày đến'),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.search),
              label: const Text('Tìm kiếm'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  RoomCard(
                    roomCode: 'BK.B1 109',
                    date: '02/04/2025',
                    duration: 180,
                    people: 8,
                    statusColor: Colors.green,
                  ),
                  RoomCard(
                    roomCode: 'BK.B2 102',
                    date: '19/04/2025',
                    duration: 180,
                    people: 8,
                    statusColor: Colors.orange,
                  ),
                  RoomCard(
                    roomCode: 'BK.B3 206',
                    date: '02/04/2025',
                    duration: 180,
                    people: 8,
                    statusColor: Colors.orange,
                  ),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StatusIndicator(color: Colors.green, text: 'Đang trong thời gian nhận phòng'),
                SizedBox(width: 10),
                StatusIndicator(color: Colors.orange, text: 'Chưa đến thời gian nhận phòng'),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const FilterButton({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0A3D91),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final String roomCode;
  final String date;
  final int duration;
  final int people;
  final Color statusColor;

  const RoomCard({
    required this.roomCode,
    required this.date,
    required this.duration,
    required this.people,
    required this.statusColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  padding: const EdgeInsets.all(8),
                  color: const Color(0xFF0A3D91),
                  child: Text(
                    roomCode,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ngày nhận phòng: $date'),
                      Text('Thời gian sử dụng: $duration phút'),
                      Text('Tổng số người: $people'),
                    ],
                  ),
                ),
                CircleAvatar(radius: 8, backgroundColor: statusColor),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Deleted')),
                    );
                  },
                  icon: const Icon(Icons.person_remove, color: Colors.red),
                  label: const Text('Delete', style: TextStyle(color: Colors.red)),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Extended')),
                    );
                  },
                  icon: const Icon(Icons.timer, color: Colors.blue),
                  label: const Text('Extend', style: TextStyle(color: Colors.blue)),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Terminated')),
                    );
                  },
                  icon: const Icon(Icons.exit_to_app, color: Colors.black),
                  label: const Text('Terminate', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatusIndicator extends StatelessWidget {
  final Color color;
  final String text;

  const StatusIndicator({required this.color, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}