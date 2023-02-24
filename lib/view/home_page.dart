import 'package:curiosity_app/components/list_view.dart';
import 'package:curiosity_app/controller/sign_user_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

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
