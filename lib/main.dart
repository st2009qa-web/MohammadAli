import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const JordanTourismApp());
}

// ================= الموديل (Model) =================
class TouristSite {
  final String name;
  final String image;
  final String fullDescription;
  final String location;
  final String year;
  final String visitingHours;
  final String ticketPrice;

  const TouristSite({
    required this.name,
    required this.image,
    required this.fullDescription,
    required this.location,
    required this.year,
    required this.visitingHours,
    required this.ticketPrice,
  });
}

// ================= التطبيق الرئيسي =================
class JordanTourismApp extends StatelessWidget {
  const JordanTourismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "زور الأردن",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

// ================= نظام التنقل الرئيسي =================
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeTab(),
    const ExploreTab(),
    const QuizTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "استكشف"),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: "الاختبار"),
        ],
      ),
    );
  }
}

// ================= تبويب الرئيسية (Home Tab) =================
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _rating = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _handleRating(int stars) {
    setState(() => _rating = stars);
    if (stars >= 4) {
      _audioPlayer.play(AssetSource('sounds/clapp.mp3'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("زور الأردن"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF2E8B83), Color(0xFF2F5D8C)]),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const VideoPlayerWidget(),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "مرحباً بك في الأردن!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("قيم تجربتك معنا", style: TextStyle(fontSize: 18)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 40,
                  ),
                  onPressed: () => _handleRating(index + 1),
                );
              }),
            ),
            if (_rating > 0)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text("لقد قيمت التطبيق بـ $_rating نجوم، شكراً لك!"),
              ),
          ],
        ),
      ),
    );
  }
}

// ================= تبويب الاستكشاف (Explore Tab) =================
class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  static const List<TouristSite> sites = [
    TouristSite(
      name: "البتراء",
      image: "images/petra.png",
      fullDescription: "البتراء هي عاصمة الأنباط القديمة وتقع في محافظة معان جنوب الأردن.",
      location: "محافظة معان",
      year: "312 قبل الميلاد",
      visitingHours: "6:00 ص - 6:00 م",
      ticketPrice: "50 دينار أردني",
    ),
    TouristSite(
      name: "المدرج الروماني",
      image: "images/roman_theater.png",
      fullDescription: "بُني في القرن الثاني الميلادي ويتسع لحوالي 6000 متفرج.",
      location: "وسط البلد - عمّان",
      year: "138 ميلادي",
      visitingHours: "8:00 ص - 7:00 م",
      ticketPrice: "2 دينار أردني",
    ),
    TouristSite(
      name: "جبل القلعة",
      image: "images/citadel.png",
      fullDescription: "من أقدم المواقع التاريخية في عمّان ويضم آثاراً رومانية وأموية.",
      location: "وسط عمّان",
      year: "العصر البرونزي",
      visitingHours: "8:00 ص - 6:00 م",
      ticketPrice: "3 دينار أردني",
    ),
    TouristSite(
      name: "قلعة عجلون",
      image: "images/ajloun-castle.jpg",
      fullDescription: "من أقدم المواقع التاريخية في عمّان ويضم آثاراً أيوبية.",
      location: "عجلون",
      year: "العهد الأيوبي",
      visitingHours: "8:00 ص - 6:00 م",
      ticketPrice: "3 دينار أردني",
    ),
    TouristSite(
      name: "جبل نيبو",
      image: "images/nepo.jfif",
      fullDescription: "جبل يقع في الأردن، ويرتفع 817 مترا عن سطح البحر. يعتقد أن على الجبل وجدت مدينة نبو التي تبعد عن عمان 41 كيلومتراً وتبعد 10 كم إلى الغرب من مدينة مادبا",
      location: "مادبا",
      year: "تاريخي قديم",
      visitingHours: "8:00 ص - 6:00 م",
      ticketPrice: "3 دينار أردني",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("المواقع الأثرية"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF2E8B83), Color(0xFF2F5D8C)]),
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: sites.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          final site = sites[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(site.image, width: 80, height: 80, fit: BoxFit.cover, 
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 80),
                ),
              ),
              title: Text(site.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text(site.location),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(site: site))),
            ),
          );
        },
      ),
    );
  }
}

// ================= صفحة التفاصيل =================
class DetailsPage extends StatelessWidget {
  final TouristSite site;
  const DetailsPage({super.key, required this.site});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(site.name), backgroundColor: Colors.teal),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(site.image, width: double.infinity, height: 250, fit: BoxFit.cover,
               errorBuilder: (context, error, stackTrace) => Container(height: 250, color: Colors.grey, child: const Icon(Icons.image, size: 100)),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(Icons.location_on, site.location),
                  _buildInfoRow(Icons.history, site.year),
                  _buildInfoRow(Icons.access_time, site.visitingHours),
                  _buildInfoRow(Icons.attach_money, site.ticketPrice),
                  const SizedBox(height: 20),
                  const Text("عن الموقع:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(site.fullDescription, style: const TextStyle(fontSize: 16, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

// ================= تبويب الاختبار (Quiz Tab) =================
class QuizTab extends StatefulWidget {
  const QuizTab({super.key});

  @override
  State<QuizTab> createState() => _QuizTabState();
}

class _QuizTabState extends State<QuizTab> {
  int _score = 0;
  int _currentIdx = 0;
  final AudioPlayer _quizPlayer = AudioPlayer();

  // تم تحديث القائمة لتشمل 5 أسئلة
  final List<Map<String, dynamic>> _questions = [
    {
      'q': "ما اسم الحضارة التي بنت البتراء؟",
      'opts': ["الأنباط", "الرومان", "الفرس"],
      'ans': 0
    },
    {
      'q': "في أي قرن بُني المدرج الروماني؟",
      'opts': ["القرن الثاني الميلادي", "القرن العاشر", "القرن الخامس ق.م"],
      'ans': 0
    },
    {
      'q': "ماذا يضم جبل القلعة؟",
      'opts': ["مطار قديم", "آثار رومانية وأموية", "منتجع حديث"],
      'ans': 1
    },
    {
      'q': "أين تقع قلعة عجلون؟",
      'opts': ["في عجلون", "في إربد", "في جرش"],
      'ans': 0
    },
    {
      'q': "كم يبلغ ارتفاع جبل نيبو عن سطح البحر تقريباً؟",
      'opts': ["500 متر", "1200 متر", "817 متر"],
      'ans': 2
    },
  ];

  void _checkAnswer(int selectedIdx) {
    bool isCorrect = selectedIdx == _questions[_currentIdx]['ans'];
    if (isCorrect) {
      _score++;
      _quizPlayer.play(AssetSource('sounds/cheers.mp3'));
    } else {
      _quizPlayer.play(AssetSource('sounds/wrong.mp3'));
    }

    setState(() {
      _currentIdx++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("اختبار المعلومات"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF2E8B83), Color(0xFF2F5D8C)]),
          ),
        ),
      ),
      body: _currentIdx < _questions.length
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  LinearProgressIndicator(value: (_currentIdx + 1) / _questions.length),
                  const SizedBox(height: 30),
                  Text(_questions[_currentIdx]['q'], 
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 30),
                  ...List.generate(3, (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.teal,
                      ),
                      onPressed: () => _checkAnswer(i),
                      child: Text(_questions[_currentIdx]['opts'][i], style: const TextStyle(fontSize: 18)),
                    ),
                  )),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("انتهى الاختبار! 🎉", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Text("نتيجتك: $_score من ${_questions.length}", style: const TextStyle(fontSize: 22)),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => setState(() { _currentIdx = 0; _score = 0; }),
                    child: const Text("إعادة الاختبار"),
                  )
                ],
              ),
            ),
    );
  }
}

// ================= مشغل الفيديو (Video Player) =================
class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/jordan.mp4")
      ..initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      color: Colors.black,
      child: _controller.value.isInitialized
          ? Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller)),
                IconButton(
                  iconSize: 64,
                  icon: Icon(_controller.value.isPlaying ? Icons.pause_circle : Icons.play_circle, color: Colors.white70),
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying ? _controller.pause() : _controller.play();
                    });
                  },
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}