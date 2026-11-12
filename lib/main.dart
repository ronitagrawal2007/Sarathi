import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const navy = Color(0xFF16213E);
const navySoft = Color(0xFF2A3A63);
const marigold = Color(0xFFF2A93B);
const marigoldDeep = Color(0xFFD98C1A);
const teal = Color(0xFF1E5F5B);
const ivory = Color(0xFFFBF3E6);
const paper = Colors.white;
const ink = Color(0xFF22262F);
const muted = Color(0xFF767C8C);
const line = Color(0xFFE9E1D2);

void main() => runApp(const MyApp());

ButtonStyle appButton(Color bg, {Color fg = Colors.white}) =>
    FilledButton.styleFrom(
      backgroundColor: bg,
      foregroundColor: fg,
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(useMaterial3: true, scaffoldBackgroundColor: ivory);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sarathi',
      theme: base.copyWith(
        colorScheme: base.colorScheme.copyWith(
          primary: navy,
          secondary: marigold,
        ),
        textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
          headlineMedium: GoogleFonts.baloo2(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: navy,
          ),
          titleLarge: GoogleFonts.baloo2(
            fontSize: 23,
            fontWeight: FontWeight.w700,
            color: navy,
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

// ---------------- WELCOME ----------------

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, .62, .63, 1],
            colors: [navy, navySoft, ivory, ivory],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 42, 28, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const Center(
                  child: Icon(
                    Icons.explore_outlined,
                    size: 112,
                    color: marigold,
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  "Namaste! I'm Sarathi.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.baloo2(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Your guide for figuring out what's next - no forms, just a conversation.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BasicInfoScreen()),
                  ),
                  style: appButton(marigold, fg: navy),
                  child: const Text("Let's begin"),
                ),
                TextButton(
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    backgroundColor: ivory,
                    builder: (_) => const Padding(
                      padding: EdgeInsets.all(28),
                      child: Text(
                        'Sarathi asks a few simple questions, spots what feels right for you, '
                        'and turns that direction into a plan you can follow.',
                      ),
                    ),
                  ),
                  child: const Text(
                    'How Sarathi works',
                    style: TextStyle(color: navy),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- BASIC INFO ----------------

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  State<BasicInfoScreen> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfoScreen> {
  String? grade;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Kicker("LET'S START SIMPLE"),
              const SizedBox(height: 10),
              Text(
                'A little about you',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 36),
              Text(
                'What grade are you in?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: ['9th', '10th', '11th', '12th']
                    .map(
                      (value) => ChipButton(
                        label: value,
                        selected: grade == value,
                        onTap: () => setState(() => grade = value),
                      ),
                    )
                    .toList(),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: grade == null
                      ? null
                      : () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ConversationScreen(),
                          ),
                        ),
                  style: appButton(navy),
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChipButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const ChipButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? marigold : paper,
          border: Border.all(
            color: selected ? marigold : marigoldDeep,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, color: navy),
        ),
      ),
    );
  }
}

class Kicker extends StatelessWidget {
  final String text;
  const Kicker(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: teal,
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.3,
      ),
    );
  }
}

// ---------------- CONVERSATION ----------------

class _QA {
  final String question;
  String? answer;
  _QA(this.question);
}

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationState();
}

class _ConversationState extends State<ConversationScreen> {
  int index = 0;

  final List<(String, List<String>)> questions = const [
    (
      'Which subjects pull you in?',
      ['Biology', 'Maths', 'People and stories', 'Making things'],
    ),
    (
      'How do you like solving problems?',
      ['Try it out', 'Think it through', 'Talk it out', 'A bit of everything'],
    ),
    (
      'What sounds exciting outside class?',
      ['Experiments', 'Helping people', 'Building things', 'Running a project'],
    ),
    (
      'How do you feel about exams and pressure?',
      [
        'I enjoy it',
        'It stresses me out',
        'Depends on the subject',
        'Not sure yet',
      ],
    ),
    (
      'Would you rather work with…',
      ['People', 'Ideas and data', 'Tools and machines', 'A mix of all three'],
    ),
    (
      'Pick what matters most to you long-term',
      ['Stability', 'Creativity', 'Helping others', 'Discovery'],
    ),
  ];

  final List<_QA> history = [];
  final ScrollController scrollController = ScrollController();

  void answer(String value) {
    setState(() {
      history.add(_QA(questions[index].$1)..answer = value);
      index++;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    if (index == questions.length) {
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const RecommendationScreen()),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = questions.length;
    final currentQuestion = index < total ? questions[index] : null;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: navy,
                        child: Text('S', style: TextStyle(color: marigold)),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Sarathi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: navy,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Question ${index.clamp(0, total)} of $total',
                        style: const TextStyle(fontSize: 11, color: muted),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: index / total,
                    color: marigold,
                    backgroundColor: line,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(20),
                children: [
                  const Bubble(
                    text:
                        "Hey! I'm here to help you figure out what might fit. There are no wrong answers.",
                  ),
                  const SizedBox(height: 22),
                  for (final qa in history) ...[
                    Bubble(text: qa.question),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Bubble(text: qa.answer!, user: true),
                    ),
                    const SizedBox(height: 22),
                  ],
                  if (currentQuestion != null) ...[
                    Bubble(text: currentQuestion.$1),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 10,
                      children: currentQuestion.$2
                          .map(
                            (value) => ChipButton(
                              label: value,
                              selected: false,
                              onTap: () => answer(value),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type or tap an option...',
                        filled: true,
                        fillColor: paper,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: navy,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.mic_none, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  final String text;
  final bool user;
  const Bubble({super.key, required this.text, this.user = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: user ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 330),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: user ? teal : paper,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(text, style: TextStyle(color: user ? Colors.white : ink)),
      ),
    );
  }
}

// ---------------- RECOMMENDATION ----------------

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Kicker('BASED ON YOUR ANSWERS'),
              const SizedBox(height: 8),
              Text(
                "Here's what fits you",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              const RecommendationCard(
                tag: 'STRONG FIT',
                title: 'Biotechnology and Research',
                description:
                    'You seem curious about how life works and enjoy finding answers by trying things out.',
                accent: marigold,
              ),
              const SizedBox(height: 14),
              const RecommendationCard(
                tag: 'WORTH EXPLORING',
                title: 'Healthcare and Public Health',
                description:
                    'Your interest in people could turn into work that helps communities.',
                accent: teal,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeShell(initialTab: 3),
                    ),
                  ),
                  style: appButton(navy),
                  child: const Text('See my full plan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecommendationCard extends StatelessWidget {
  final String tag, title, description;
  final Color accent;

  const RecommendationCard({
    super.key,
    required this.tag,
    required this.title,
    required this.description,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: paper,
        borderRadius: BorderRadius.circular(18),
        border: Border(left: BorderSide(color: accent, width: 5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tag,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 8),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 5),
          Text(description, style: const TextStyle(color: muted, height: 1.4)),
        ],
      ),
    );
  }
}

// ---------------- HOME SHELL ----------------

class HomeShell extends StatefulWidget {
  final int initialTab;
  const HomeShell({super.key, this.initialTab = 0});

  @override
  State<HomeShell> createState() => _HomeState();
}

class _HomeState extends State<HomeShell> {
  late int tab;

  @override
  void initState() {
    super.initState();
    tab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    final pages = const [PathTab(), LearnTab(), PracticeTab(), PlanTab()];
    final titles = ['My path', 'Learn', 'Practice', 'My plan'];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[tab]),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: IndexedStack(index: tab, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (value) => setState(() => tab = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            label: 'Path',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Learn',
          ),
          NavigationDestination(
            icon: Icon(Icons.bolt_outlined),
            label: 'Practice',
          ),
          NavigationDestination(
            icon: Icon(Icons.checklist_outlined),
            label: 'Plan',
          ),
        ],
      ),
    );
  }
}

// ---------------- PATH TAB ----------------

class PathTab extends StatelessWidget {
  const PathTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        FilledButton.icon(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ConversationScreen()),
          ),
          style: appButton(navy),
          icon: const Icon(Icons.forum_outlined),
          label: const Text('Talk to Sarathi'),
        ),
        const SizedBox(height: 24),
        Text(
          'Your two best directions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        const RecommendationCard(
          tag: 'STRONG FIT',
          title: 'Biotechnology and Research',
          description: 'Curiosity, experiments, and patient problem-solving.',
          accent: marigold,
        ),
        const SizedBox(height: 14),
        const RecommendationCard(
          tag: 'WORTH EXPLORING',
          title: 'Healthcare and Public Health',
          description: 'A people-first path where science makes a difference.',
          accent: teal,
        ),
      ],
    );
  }
}

// ---------------- LEARN TAB ----------------

class LearnTab extends StatelessWidget {
  const LearnTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Small lessons, real progress.',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 18),
        const TopicCard(
          title: 'Cell Biology',
          subtitle: 'See how tiny cells keep us alive.',
        ),
        const TopicCard(
          title: 'Human Health',
          subtitle: 'Connect science to everyday life.',
        ),
        const TopicCard(
          title: 'Genetics and You',
          subtitle: 'Understand what makes each person unique.',
        ),
      ],
    );
  }
}

class TopicCard extends StatelessWidget {
  final String title, subtitle;
  const TopicCard({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: paper,
      elevation: 0,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: navy),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TopicDetailScreen(title: title, subtitle: subtitle),
          ),
        ),
      ),
    );
  }
}

class TopicDetailScreen extends StatelessWidget {
  final String title, subtitle;
  const TopicDetailScreen({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'A quick explainer',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(subtitle, style: const TextStyle(color: muted, fontSize: 16)),
            const SizedBox(height: 24),
            const Text(
              'Read one idea, connect it to something you know, then try explaining it in your own words. '
              'That is how learning sticks.',
              style: TextStyle(height: 1.6),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                style: appButton(navy),
                child: const Text('Mark as done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- PRACTICE TAB ----------------

class PracticeTab extends StatelessWidget {
  const PracticeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Practice makes patterns visible.',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 18),
        QuizCard(
          title: 'Cell Biology',
          count: 5,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const QuizScreen()),
          ),
        ),
        QuizCard(
          title: 'Human Health',
          count: 4,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const QuizScreen()),
          ),
        ),
      ],
    );
  }
}

class QuizCard extends StatelessWidget {
  final String title;
  final int count;
  final VoidCallback onTap;

  const QuizCard({
    super.key,
    required this.title,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: paper,
      elevation: 0,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: navy),
        ),
        subtitle: Text('$count questions'),
        trailing: FilledButton(
          onPressed: onTap,
          style: appButton(teal),
          child: const Text('Start'),
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizState();
}

class _QuizState extends State<QuizScreen> {
  int question = 0;
  int score = 0;
  int? picked;

  final List<(String, List<String>, int)> quiz = const [
    (
      'What is the basic unit of life?',
      ['A cell', 'A bone', 'A planet', 'A muscle'],
      0,
    ),
    (
      'Which part controls a cell?',
      ['Cell wall', 'Nucleus', 'Water', 'Sugar'],
      1,
    ),
    (
      'What do plants use to make food?',
      ['Moonlight', 'Sound', 'Sunlight', 'Wind'],
      2,
    ),
  ];

  void choose(int value) {
    if (picked != null) return;
    setState(() {
      picked = value;
      if (value == quiz[question].$3) score++;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      if (question == quiz.length - 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => QuizSummary(score: score, total: quiz.length),
          ),
        );
      } else {
        setState(() {
          question++;
          picked = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = quiz[question];
    return Scaffold(
      appBar: AppBar(title: Text('Question ${question + 1} of ${quiz.length}')),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (question + 1) / quiz.length,
              color: marigold,
            ),
            const SizedBox(height: 32),
            Text(item.$1, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 24),
            ...List.generate(item.$2.length, (i) {
              Color borderColor = line;
              if (picked != null) {
                if (i == item.$3) {
                  borderColor = Colors.green;
                } else if (i == picked) {
                  borderColor = Colors.red;
                }
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: OutlinedButton(
                  onPressed: () => choose(i),
                  style: OutlinedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(17),
                    side: BorderSide(color: borderColor, width: 2),
                  ),
                  child: Text(item.$2[i]),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class QuizSummary extends StatelessWidget {
  final int score, total;
  const QuizSummary({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.stars_rounded, size: 72, color: marigold),
            Text(
              'Nice work!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'You got $score out of $total',
              style: const TextStyle(color: muted, fontSize: 18),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              style: appButton(navy),
              child: const Text('Back to Practice'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- PLAN TAB ----------------

class PlanTab extends StatefulWidget {
  const PlanTab({super.key});

  @override
  State<PlanTab> createState() => _PlanState();
}

class _PlanState extends State<PlanTab> {
  final Set<int> done = {};

  final List<(String, String)> tasks = const [
    ('Read about cell membranes', 'Biology'),
    ('Try 5 practice questions', 'Practice'),
    ('Write one thing you are curious about', 'Reflection'),
    ('Watch a short genetics lesson', 'Biology'),
  ];

  void toggle(int i) {
    setState(() {
      if (done.contains(i)) {
        done.remove(i);
      } else {
        done.add(i);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Your next small steps',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 20),
        const Kicker('TODAY'),
        for (int i = 0; i < 2; i++)
          TaskTile(
            task: tasks[i],
            checked: done.contains(i),
            onTap: () => toggle(i),
          ),
        const SizedBox(height: 20),
        const Kicker('THIS WEEK'),
        for (int i = 2; i < 4; i++)
          TaskTile(
            task: tasks[i],
            checked: done.contains(i),
            onTap: () => toggle(i),
          ),
      ],
    );
  }
}

class TaskTile extends StatelessWidget {
  final (String, String) task;
  final bool checked;
  final VoidCallback onTap;

  const TaskTile({
    super.key,
    required this.task,
    required this.checked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: paper,
      elevation: 0,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          value: checked,
          onChanged: (_) => onTap(),
          activeColor: teal,
        ),
        title: Text(
          task.$1,
          style: TextStyle(
            decoration: checked ? TextDecoration.lineThrough : null,
            color: checked ? muted : ink,
          ),
        ),
        subtitle: Text(task.$2, style: const TextStyle(color: teal)),
      ),
    );
  }
}

// ---------------- SETTINGS ----------------

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            trailing: Text('English'),
          ),
          ListTile(
            leading: Icon(Icons.notifications_none),
            title: Text('Notifications'),
          ),
          ListTile(
            leading: Icon(Icons.lock_outline),
            title: Text('Privacy and Data'),
            subtitle: Text('Your answers are mock data in this demo.'),
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Log out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
