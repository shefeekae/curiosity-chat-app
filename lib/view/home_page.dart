import 'package:curiosity_app/components/list_view.dart';
import 'package:curiosity_app/controller/auth_controller.dart';
import 'package:curiosity_app/controller/sign_user_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  AuthController authController = AuthController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        authController.setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        authController.setUserState(false);
        break;
    }
  }

  final userId = FirebaseAuth.instance.currentUser;

  UserSigning user = UserSigning();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Curiosity'),
          backgroundColor: Colors.black87,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () => user.signUserOut(),
                icon: const Icon(Icons.logout))
          ],
          bottom: const TabBar(tabs: [
            Tab(text: 'CHATS'),
            Tab(text: 'STATUS'),
            Tab(text: 'CALLS'),
          ]),
        ),
        body: TabBarView(children: [
          ChatListView(),
          const Icon(Icons.abc),
          const Icon(Icons.call)
        ]),
      ),
    );
  }
}
