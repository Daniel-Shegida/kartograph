import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartograph/assets/colors/colors.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:routemaster/routemaster.dart';

/// bottom that navigate main part of project
class BottomNavigator extends StatelessWidget {
  /// constructor of [BottomNavigator]
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabPage = TabPage.of(context);
    final Widget svgIcon = SvgPicture.network(
      'https://site-that-takes-a-while.com/image.svg',
      semanticsLabel: 'A shark?!',
      // placeholderBuilder: (BuildContext context) => Container(
      //     padding: const EdgeInsets.all(30.0),
      //     child: const CircularProgressIndicator()),
    );

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabPage.index,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                "assets/icons/List.svg",
                color: ProjectColors.mainLightTheme,
            ),
            // Icon(Icons.file_copy_outlined),
            activeIcon: SvgPicture.asset(
                "assets/icons/List Full.svg",
                color: ProjectColors.mainLightTheme,
            ),
      // Icon(Icons.file_copy),
            label: ProjectStrings.placesBottom,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                "assets/icons/Map.svg",
                color: ProjectColors.mainLightTheme,
                semanticsLabel: 'A red up arrow'
            ),
            // Icon(Icons.assignment_turned_in_outlined),
            activeIcon: SvgPicture.asset(
                "assets/icons/Map Full.svg",
                color: ProjectColors.mainLightTheme,
            ),
            // Icon(Icons.assignment_turned_in),
            label: ProjectStrings.mapBottom,
          ),
          BottomNavigationBarItem(
            icon:
            // svgIcon,
            SvgPicture.asset(
                  "assets/icons/Settings.svg",
                  color: ProjectColors.mainLightTheme,
              ),
            // Icon(Icons.account_circle_outlined),
            activeIcon: SvgPicture.asset(
                "assets/icons/Settings-fill.svg",
                color: ProjectColors.mainLightTheme,
            ),
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