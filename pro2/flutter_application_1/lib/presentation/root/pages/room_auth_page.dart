import 'package:flutter/material.dart';
import 'root.dart';
import 'room_management_page.dart';

class RoomAuthPage extends StatefulWidget {
  const RoomAuthPage({super.key});

  @override
  _RoomAuthPageState createState() => _RoomAuthPageState();
}

class _RoomAuthPageState extends State<RoomAuthPage> {
  final TextEditingController _codeController = TextEditingController();
  bool _isAuthenticated = false;

  void _authenticate() {
    if (_codeController.text == 'HCMUT2025') {
      setState(() {
        _isAuthenticated = true;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RoomManagementPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mã xác nhận không đúng')),
      );
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
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
          child: Image.asset(
            'assets/images/logo.png',
            height: 40,
          ),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/zalo.png',
                height: 150,
                width: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                'Quét mã QR để đăng nhập\nmục Quản lý phòng',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: 'Nhập mã xác nhận:',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _authenticate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  'Xác nhận',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              if (_isAuthenticated)
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Card(
                    color: Colors.blue,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Xác nhận thành công\nvào quản lí phòng để\ntiến hành sử dụng',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Colors.blue,
  selectedItemColor: Colors.white,
  unselectedItemColor: Colors.white70,
  // currentIndex: -1, // Trick để không làm nổi bật item nào
  // onTap: (index) {},
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: ''),
    BottomNavigationBarItem(
      icon: Icon(Icons.home, size:  40), // <-- Tăng kích thước ở đây
      label: '',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.star), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
  ],
  type: BottomNavigationBarType.fixed, // Đảm bảo các icon hiển thị đầy đủ
),
    );
  }
}