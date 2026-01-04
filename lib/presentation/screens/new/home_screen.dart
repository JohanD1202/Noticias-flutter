import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const _HomeView();
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Hola mundo", style: TextStyle(color: Colors.black, fontSize: 50)));
  }
}