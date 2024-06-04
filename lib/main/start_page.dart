import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:segno/Style/style.dart';
import 'package:segno/genarator/text_input_page.dart';
import 'package:segno/main/file_manager.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: AppTheme.mainColor,
            centerTitle: true,
            title: Text(
              'Segno',
              textAlign: TextAlign.center,
              style: AppTheme.textTheme.displaySmall,
            ),
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.person),
                onSelected: (value) {
                  if (value == 'logout') {
                    FirebaseAuth.instance.signOut();
                  }
                },
                itemBuilder: (BuildContext context) {
                  final user = FirebaseAuth.instance.currentUser;
                  final email = user?.email;

                  return [
                    PopupMenuItem<String>(
                      value: 'email',
                      child: SizedBox(
                          width: 200,
                          child: Text(
                            '이메일: $email',
                            style: AppTheme.textTheme.labelMedium,
                          )),
                    ),
                    PopupMenuItem<String>(
                      value: 'logout',
                      child: SizedBox(
                          width: 200,
                          child: Text(
                            '로그아웃',
                            style: AppTheme.textTheme.labelMedium,
                          )),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            tabBarTheme: const TabBarTheme(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.amberAccent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
                color: AppTheme.mainColor,
              ),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: '문제 만들기',
              ),
              Tab(
                text: '문제 저장소',
              ),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppTheme.mainColor,
            ),
            labelStyle: AppTheme.textTheme.labelLarge,
            unselectedLabelStyle: AppTheme.textTheme.labelLarge,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(150.0),
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: IconButton(
                  icon: Image.asset(
                    'assets/images/add_color.png',
                    width: 300,
                    height: 300,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TextInputPage()),
                    );
                  },
                ),
              ),
            ),
            const LayoutBuilderWidget(),
          ],
        ),
      ),
    );
  }
}
