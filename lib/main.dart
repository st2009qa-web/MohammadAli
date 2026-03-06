import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "زور الأردن",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF4F6F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2E8B83),
          centerTitle: true,
        ),
      ),
      home: const MainPage(),
    );
  }
}

////////////////////////////////////////////////////////////
/// الصفحة الرئيسية
////////////////////////////////////////////////////////////

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int rating = 0;
  final TextEditingController commentController = TextEditingController();
  final AudioPlayer ratingPlayer = AudioPlayer();

  Future<void> playClap() async {
    await ratingPlayer.play(AssetSource('sounds/clapp.mp3'));
  }

  final TouristSite petra = const TouristSite(
    name: "البتراء",
    image: "images/petra.png",
    fullDescription:
        "البتراء هي عاصمة الأنباط القديمة وتقع في محافظة معان جنوب الأردن.",
    location: "محافظة معان - جنوب الأردن",
    year: "312 قبل الميلاد",
    visitingHours: "6:00 صباحاً - 6:00 مساءً",
    ticketPrice: "50 دينار أردني",
  );

  final TouristSite roman = const TouristSite(
    name: "المدرج الروماني",
    image: "images/roman_theater.png",
    fullDescription:
        "بُني في القرن الثاني الميلادي ويتسع لحوالي 6000 متفرج.",
    location: "وسط البلد - عمّان",
    year: "138 ميلادي",
    visitingHours: "8:00 صباحاً - 7:00 مساءً",
    ticketPrice: "2 دينار أردني",
  );

  final TouristSite citadel = const TouristSite(
    name: "جبل القلعة",
    image: "images/citadel.png",
    fullDescription:
        "من أقدم المواقع التاريخية في عمّان ويضم آثاراً رومانية وأموية.",
    location: "وسط عمّان",
    year: "العصر البرونزي",
    visitingHours: "8:00 صباحاً - 6:00 مساءً",
    ticketPrice: "3 دينار أردني",
  );

  Widget buildStar(int index) {
    return IconButton(
      icon: Icon(
        index <= rating ? Icons.star : Icons.star_border,
        color: const Color(0xFF2F5D8C),
      ),
      onPressed: () {
        setState(() {
          rating = index;
        });
        if (index >= 4) {
          playClap();
        }
      },
    );
  }

  @override
  void dispose() {
    ratingPlayer.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("دليل المواقع الأثرية")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const VideoPlayerWidget(),
            buildCard(context, petra),
            const SizedBox(height: 15),
            buildCard(context, roman),
            const SizedBox(height: 15),
            buildCard(context, citadel),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const QuizPage()),
                );
              },
              child: const Text("اختبر معلوماتك"),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const Text("قيّم التطبيق"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(5, (index) => buildStar(index + 1)),
            ),
            const SizedBox(height: 15),
            rating == 0
                ? const Text("لم يتم التقييم بعد")
                : TextField(
                    controller: commentController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText:
                          "⭐" * rating + " اكتب وصف تقييمك هنا...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, TouristSite site) {
    return Card(
      child: ListTile(
        title: Text(site.name),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailsPage(site: site)),
          );
        },
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// صفحة التفاصيل
////////////////////////////////////////////////////////////

class DetailsPage extends StatelessWidget {
  final TouristSite site;

  const DetailsPage({super.key, required this.site});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(site.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              site.image,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            InfoRow(icon: Icons.location_on, text: site.location),
            InfoRow(icon: Icons.history, text: site.year),
            InfoRow(icon: Icons.access_time, text: site.visitingHours),
            InfoRow(icon: Icons.attach_money, text: site.ticketPrice),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(site.fullDescription),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
    );
  }
}

////////////////////////////////////////////////////////////
/// صفحة الأسئلة
////////////////////////////////////////////////////////////

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int score = 0;
  String resultText = "";
  final AudioPlayer quizPlayer = AudioPlayer();

  Future<void> playCorrect() async {
    await quizPlayer.play(AssetSource('sounds/cheers.mp3'));
  }

  Future<void> playWrong() async {
    await quizPlayer.play(AssetSource('sounds/wrong.mp3'));
  }

  void checkAnswer(bool correct) {
    setState(() {
      if (correct) {
        score++;
        resultText = "إجابة صحيحة ✅";
        playCorrect();
      } else {
        resultText = "إجابة خاطئة ❌";
        playWrong();
      }
    });
  }

  @override
  void dispose() {
    quizPlayer.dispose();
    super.dispose();
  }

  String finalResult() {
    if (score == 3) {
      return "ممتاز 👏";
    } else if (score == 2) {
      return "جيد جداً 👍";
    } else if (score == 1) {
      return "مقبول 🙂";
    } else {
      return "حاول مجدداً ❌";
    }
  }

  Widget answerButton(String text, bool correct) {
    return ElevatedButton(
      onPressed: () => checkAnswer(correct),
      child: Text(text),
    );
  }

  Widget questionCard(String question, List<Widget> answers) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(question),
            const SizedBox(height: 10),
            ...answers,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("أسئلة سياحية")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            questionCard("1️⃣ ما اسم الحضارة التي بنت البتراء؟", [
              answerButton("الأنباط", true),
              answerButton("الرومان", false),
              answerButton("الفرس", false),
            ]),
            questionCard("2️⃣ في أي قرن بُني المدرج الروماني؟", [
              answerButton("القرن الثاني الميلادي", true),
              answerButton("القرن العاشر", false),
              answerButton("القرن الخامس قبل الميلاد", false),
            ]),
            questionCard("3️⃣ ماذا يضم جبل القلعة؟", [
              answerButton("آثار رومانية وأموية", true),
              answerButton("منتجع سياحي حديث", false),
              answerButton("مطار قديم", false),
            ]),
            const SizedBox(height: 20),
            Text(resultText),
            const SizedBox(height: 10),
            Text("نتيجتك: $score من 3"),
            const SizedBox(height: 10),
            Text(finalResult()),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// مشغل الفيديو
////////////////////////////////////////////////////////////

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  State<VideoPlayerWidget> createState() =>
      _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller =
        VideoPlayerController.asset("assets/videos/jordan.mp4")
          ..initialize().then((_) {
            setState(() {});
          });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              )
            : const Text("جاري تحميل الفيديو..."),
        IconButton(
          iconSize: 50,
          icon: Icon(controller.value.isPlaying
              ? Icons.pause_circle
              : Icons.play_circle),
          onPressed: () async {
            if (controller.value.isPlaying) {
              await controller.pause();
            } else {
              await controller.play();
            }
            setState(() {});
          },
        ),
      ],
    );
  }
}