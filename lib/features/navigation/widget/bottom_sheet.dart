import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartograph/assets/colors/colors.dart';
import 'package:kartograph/assets/res/project_icons.dart';
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
            icon: _BottomIcons(
              iconAddress: ProjectIcons.list,
            ),
            activeIcon: _BottomIcons(
              iconAddress: ProjectIcons.listFull,
            ),
            label: ProjectStrings.placesBottom,
          ),
          BottomNavigationBarItem(
            icon: _BottomIcons(
              iconAddress: ProjectIcons.map,
            ),
            activeIcon: _BottomIcons(
              iconAddress: ProjectIcons.mapFull,
            ),
            label: ProjectStrings.mapBottom,
          ),
          BottomNavigationBarItem(
            icon: _BottomIcons(
              iconAddress: ProjectIcons.settings,
            ),
            activeIcon: _BottomIcons(
              iconAddress: ProjectIcons.settingsFull,
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

class _BottomIcons extends StatelessWidget {
  final String iconAddress;

  const _BottomIcons({required this.iconAddress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconAddress,
      color: ProjectColors.mainLightTheme,
    );
  }
}
