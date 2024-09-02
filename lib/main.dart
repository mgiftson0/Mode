import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Enable Material3 for better animations and components
      ),
      home: const MyHomePage(title: 'Flutter Task Manager Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 200,
        backgroundColor: Colors.amber,
        leading: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.amber, // Background color
            elevation: 5, // Elevation
            shape: const CircleBorder(),
          ),
          child: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Open the drawer
          },
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.amber, // Background color
              elevation: 5, // Elevation
              shape: const CircleBorder(),
            ),
            child: const Icon(Icons.search),
            onPressed: () {
              // Add your search logic here
            },
          ),
        ],
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Colorful Ring Around the Profile Avatar
            AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const SweepGradient(
                      colors: [
                        Colors.red,
                        Colors.orange,
                        Colors.yellow,
                        Colors.green,
                        Colors.blue,
                        Colors.indigo,
                        Colors.red,
                      ],
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            const Text(
              "Jade Khan",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              "Software Engineer",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Jade Khan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Software Engineer",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            // Add your drawer items here
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Handle Home tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle Settings tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Handle Logout tap
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.orange.shade50, // Set background color
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "My Tasks",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lime, // Background color
                      elevation: 5, // Elevation
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: () {
                      // Add your calendar logic here
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    // Task Categories
                    TaskCategoryTile(
                      icon: Icons.flag,
                      color: Colors.green,
                      title: "To Do",
                      subtitle: "5 tasks",
                    ),
                    TaskCategoryTile(
                      icon: Icons.timer,
                      color: Colors.blue,
                      title: "In Progress",
                      subtitle: "3 tasks",
                    ),
                    TaskCategoryTile(
                      icon: Icons.done,
                      color: Colors.amber,
                      title: "Done",
                      subtitle: "2 tasks",
                    ),
                    TaskCategoryTile(
                      icon: Icons.play_arrow,
                      color: Colors.brown,
                      title: "Started",
                      subtitle: "1 task",
                    ),
                    // Active Projects Section
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Active Projects",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 30.0, // Wider gap between adjacent cards
                            runSpacing: 30.0, // Wider gap between lines of cards
                            children: [
                              // Project Cards
                              _buildProjectCard(
                                "Project Alpha",
                                "Deadline: 10th Sept",
                                0.7,
                                Colors.lightBlueAccent,
                                Colors.blue,
                              ),
                              _buildProjectCard(
                                "Project Beta",
                                "Deadline: 15th Sept",
                                0.4,
                                Colors.orangeAccent,
                                Colors.orange,
                              ),
                              _buildProjectCard(
                                "Project Gamma",
                                "Deadline: 20th Sept",
                                0.5,
                                Colors.pinkAccent,
                                Colors.pink,
                              ),
                              _buildProjectCard(
                                "Project Delta",
                                "Deadline: 25th Sept",
                                0.9,
                                Colors.purpleAccent,
                                Colors.purple,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    String title,
    String subtitle,
    double progress,
    Color bgColor,
    Color progressColor,
  ) {
    return Container(
      width: 150, // Reduced width
      height: 200, // Increased height
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(25), // Increased border radius
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 15),
            LinearProgressIndicator(
              value: progress,
              color: progressColor,
              backgroundColor: progressColor.withOpacity(0.2),
            ),
            const SizedBox(height: 10),
            Text(
              "${(progress * 100).toInt()}% completed",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Widget for Task Categories
class TaskCategoryTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const TaskCategoryTile({
    Key? key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
    );
  }
}
