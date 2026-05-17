import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surf_mad_teacher_training/assets/images/app_svg_icons.dart';
import 'package:surf_mad_teacher_training/navigation/router.dart';

@RoutePage()
class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        PlacesRouteBuilder(),
        FavoritesRouteBuilder(),
        SettingsRouteBuilder(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppSvgIcons.icList,
                width: 24,
                height: 24,
              ),
              label: '',
              activeIcon: SvgPicture.asset(
                AppSvgIcons.icListFull,
                width: 24,
                height: 24,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppSvgIcons.icHeart,
                width: 24,
                height: 24,
              ),
              label: '',
              activeIcon: SvgPicture.asset(
                AppSvgIcons.icHeartFull,
                width: 24,
                height: 24,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppSvgIcons.icSettings,
                width: 24,
                height: 24,
              ),
              label: '',
              activeIcon: SvgPicture.asset(
                AppSvgIcons.icSettingsFull,
                width: 24,
                height: 24,
              ),
            ),
          ],
          onTap: tabsRouter.setActiveIndex,
          currentIndex: tabsRouter.activeIndex,
        );
      },
    );
  }
}
