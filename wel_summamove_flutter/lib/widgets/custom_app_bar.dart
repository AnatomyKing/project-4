import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize {
    final win = WidgetsBinding.instance.window;
    return Size.fromHeight(win.padding.top / win.devicePixelRatio + 80);
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.grey,
        statusBarIconBrightness: Brightness.light,
      ),
      child: AppBar(
        backgroundColor: const Color(0xFF707070),
        elevation: 0,
        automaticallyImplyLeading: Navigator.canPop(context),
        iconTheme: const IconThemeData(color: Colors.white),
        titleSpacing: 10,
        toolbarHeight: 80,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.grey[800],
          statusBarIconBrightness: Brightness.light,
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Text(title,
              style: const TextStyle(
                  color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        actions: [
          GestureDetector(
            onTap: lang.toggle,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Text(lang.flag, style: const TextStyle(fontSize: 20)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
