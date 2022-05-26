import 'package:flutter/material.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:routemaster/routemaster.dart';

/// bottom that navigate main part of project
class BottomNavigator extends StatelessWidget {
  /// constructor of [BottomNavigator]
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabPage = TabPage.of(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabPage.index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy_outlined),
            activeIcon: Icon(Icons.file_copy),
            label: ProjectStrings.placesBottom,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in_outlined),
            activeIcon: Icon(Icons.assignment_turned_in),
            label: ProjectStrings.mapBottom,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: ProjectStrings.settingBottom,
          ),
        ],
        onTap: (index) {
          tabPage.index = index;
        },
      ),
      body: TabBarView(
        controller: tabPage.controller,
        children: [
          for (final stack in tabPage.stacks) PageStackNavigator(stack: stack),
        ],
      ),
    );
  }
}