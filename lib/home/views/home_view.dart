// home_view.dart

import 'package:adecco_ahmad_test/login/viewmodels/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          PopupMenuButton(onSelected: (value) {
            if (value == 0) {
              ref.read(loginViewModelProvider).token = null;
            }
          }, itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: 0,
                child: Text("Logout"),
              ),
            ];
          }),
        ],
      ),
      body: const Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}
