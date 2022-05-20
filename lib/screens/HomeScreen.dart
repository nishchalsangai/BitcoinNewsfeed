import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled/managers/AuthManager.dart';
import 'package:untitled/managers/HomeManager.dart';
import '../core/AppTheme.dart';
import 'Bookmarks.dart';
import 'NewsFeed.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    final authManager = Provider.of<AuthStateManager>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.nearlyGreen,
        centerTitle: true,
        title: Text(
          'News',
          style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(onPressed: authManager.signOut, icon: const Icon(Icons.logout))],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          indicatorPadding: const EdgeInsets.all(0),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(
              text: 'News Feed',
            ),
            Tab(
              text: 'Bookmarks',
            )
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: const [
            newsFeed(),
            BookmarksScreen(),
          ],
        ),
      ),
    );
  }
}
