// lib/widgets/custom_app_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize {
    final window = WidgetsBinding.instance.window;
    final statusBarHeight = window.padding.top / window.devicePixelRatio;
    return Size.fromHeight(statusBarHeight + 80);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.grey,                 // same grey behind icons
        statusBarIconBrightness: Brightness.light,
      ),
      child: AppBar(
        backgroundColor: const Color(0xFF707070),
        elevation: 0,
        automaticallyImplyLeading: Navigator.canPop(context),
        iconTheme: const IconThemeData(color: Colors.white),
        titleSpacing: 10,                             // shift title further left
        toolbarHeight: 80,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.grey[800],
          statusBarIconBrightness: Brightness.light,
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 50),    // nudge it down
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.transparent,
              child: Text('🇬🇧', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
