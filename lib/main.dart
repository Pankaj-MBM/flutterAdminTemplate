import 'package:flutter/material.dart';
import 'package:flutteradmin/pages/home.dart';
import 'package:flutteradmin/pages/profile-Setting.dart';
import 'package:flutteradmin/pages/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isDrawerOpen = true;
  Widget _currentPage = const HomePage();

  Future<void> _toggleDrawer() async {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  void _updatePage(Widget page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard /',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF263238),
        leading: IconButton(
          icon: Icon(_isDrawerOpen ? Icons.arrow_back : Icons.menu),
          color: Colors.white,
          onPressed: _toggleDrawer,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            color: Colors.white,
            onPressed: () {
              // Handle notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.mail_outline_outlined),
            color: Colors.white,
            onPressed: () {
              // Handle mail options
            },
          ),
          IconButton(
            icon: const Icon(Icons.verified_user_outlined),
            color: Colors.green,
            onPressed: () {
              // Handle user verification
            },
          ),
          Center(
            child: Container(
              color: Colors.orange,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 15),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 20, // Set the size of the avatar
                        backgroundImage: AssetImage('assets/images/user_img.jpg'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    const Text(
                      'John Deo',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                    PopupMenuButton<int>(
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.white70,
                      ),
                      onSelected: (value) {
                        switch (value) {
                          case 1:
                            _updatePage(const ProfilePage());
                            break;
                          case 2:
                            _updatePage(ProfileSetting());
                            break;
                          case 3:
                            print("Logout selected");
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          value: 1,
                          child: Text("Profile"),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text("Settings"),
                        ),
                        const PopupMenuItem(
                          value: 3,
                          child: Text("Logout"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          CustomDrawer(
            isOpen: _isDrawerOpen,
            toggleDrawer: _toggleDrawer,
            onPageSelected: _updatePage,
          ),
          Expanded(
            child: _currentPage,
          ),
        ],
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final bool isOpen;
  final VoidCallback toggleDrawer;
  final void Function(Widget) onPageSelected; // Callback for page selection

  const CustomDrawer({
    super.key,
    required this.isOpen,
    required this.toggleDrawer,
    required this.onPageSelected, // Initialize the callback
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isOpen ? 225 : 80, // Expanded and collapsed widths
      color: const Color(0xFF263238),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
            // Set the height of the DrawerHeader
            child: DrawerHeader(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 30, // Set the size of the avatar
                      backgroundImage: AssetImage('assets/images/user_img.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  if (isOpen) ...[
                    const SizedBox(width: 8),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'John Deo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          'Online',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF263238),
              ),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 15),
          _buildListTile(Icons.dashboard, 'Dashboard', context, Colors.purple, HomePage()),
          _buildListTile(Icons.widgets_outlined, 'Widgets', context, Colors.greenAccent, HomePage()),
          _buildListTile(Icons.apps_outage_sharp, 'Apps', context, Colors.cyan, HomePage()),
          _buildListTile(Icons.table_chart_outlined, 'Table', context, Colors.orange, HomePage()),
          _buildListTile(Icons.diamond_outlined, 'Elements', context, Colors.purpleAccent, HomePage()),
          _buildListTile(Icons.map_sharp, 'Maps', context, Colors.red, HomePage()),
          _buildListTile(Icons.contact_mail_rounded, 'Contact', context, Colors.blue, HomePage()),
          _buildListTile(Icons.settings, 'Settings', context, Colors.green, HomePage()),
        ],
      ),
    );
  }

  Widget _buildListTile(
      IconData icon, String text, BuildContext context, Color color, Widget page) {
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: isOpen
          ? Text(text, style: const TextStyle(color: Colors.white))
          : null,
      onTap: () {
        onPageSelected(page);
      },
    );
  }
}
