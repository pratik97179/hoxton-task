import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/di/injection.dart';
import 'package:hoxton_task/features/home/presentation/controllers/home_controller.dart';
import 'package:hoxton_task/features/home/presentation/widgets/home_content.dart';

/// Home dashboard page. Triggers a home API fetch when first shown.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = sl<HomeController>();
    _controller.addListener(_onStateChanged);
    _controller.loadHome();
  }

  @override
  void dispose() {
    _controller.removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyGreenTint2,
      body: SafeArea(
        child: _controller.isLoading && _controller.home == null
            ? const Center(child: CircularProgressIndicator())
            : HomeContent(home: _controller.home),
      ),
    );
  }
}
