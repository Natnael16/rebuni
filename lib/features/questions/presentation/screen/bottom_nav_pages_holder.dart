import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../widget/bottom_navbar_item.dart';
import 'ask_question.dart';
import 'bookmark.dart';
import 'homepage.dart';
import 'search_page.dart';

class PagesHolder extends StatefulWidget {
  const PagesHolder({super.key});

  @override
  State<PagesHolder> createState() => _PagesHolderState();
}

class _PagesHolderState extends State<PagesHolder> {
  int _currentIndex = 0;
  List pages = [HomePage(), SearchPage(),BookMark(),SizedBox()];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(backgroundColor: white, actions: [
        InkWell(
          onTap: () {
            showDialog(
                context: context, builder: (context) => const AskQuestion());
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Text("Ask", style: textTheme.bodySmall!.copyWith(color: white)),
                SizedBox(width: 1.w),
                const Icon(Icons.add_sharp, color: white),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 2.w,
        )
      ]),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          buildBottomNavigationBarItem(
              Icons.home, 'Home', homeIcon, primaryColor),
          buildBottomNavigationBarItem(
              Icons.search, 'Search', searchIcon, primaryColor),
          buildBottomNavigationBarItem(
              Icons.bookmark, 'Bookmark', bookmarkIcon, primaryColor),
          buildBottomNavigationBarItem(
              Icons.person, 'Profile', profileIcon, primaryColor),
        ],
      ),
    );
  }
}
