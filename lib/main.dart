
import 'package:flutter/material.dart';

void main() {
  runApp(const VexoApp());
}

const Color bg = Color(0xFF0B0D14);
const Color panel = Color(0xFF171B27);
const Color accent = Color(0xFF735DFF);
const Color muted = Color(0xFF9299AD);

class VexoApp extends StatelessWidget {
  const VexoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VEXO',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTab = 0;

  final List<String> tabs = [
    'المحادثات',
    'الحالات',
    'القنوات',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: bg,
          title: const Text(
            'VEXO',
            style: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [accent, Color(0xFF29205F)],
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white24,
                    child: Icon(
                      Icons.bolt,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'أهلاً بك في ڤيكسو',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text('تواصل بطريقتك الخاصة'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: List.generate(tabs.length, (index) {
                  final active = selectedTab == index;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedTab = index);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          color: active ? accent : panel,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          tabs[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      [
                        Icons.chat_bubble_outline,
                        Icons.auto_awesome,
                        Icons.campaign_outlined,
                      ][selectedTab],
                      size: 64,
                      color: accent,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      [
                        'محادثاتك تبدأ من هنا',
                        'شارك لحظاتك مع الأصدقاء',
                        'اكتشف قنوات ڤيكسو',
                      ][selectedTab],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'VEXO • عالمك، تواصلك',
                      style: TextStyle(color: muted),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: accent,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('راح نضيف المحادثات قريباً'),
              ),
            );
          },
          child: const Icon(Icons.add_comment),
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: panel,
          indicatorColor: accent.withValues(alpha: 0.25),
          selectedIndex: selectedTab,
          onDestinationSelected: (index) {
            setState(() => selectedTab = index);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.chat_bubble_outline),
              label: 'محادثات',
            ),
            NavigationDestination(
              icon: Icon(Icons.circle_outlined),
              label: 'حالات',
            ),
            NavigationDestination(
              icon: Icon(Icons.campaign_outlined),
              label: 'قنوات',
            ),
          ],
        ),
      ),
    );
  }
}
