import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'install_banner.dart';

/// Ancho a partir del cual usamos diseño de escritorio/web (barra lateral).
const double _wideBreakpoint = 760;

/// Ancho máximo del contenido en pantallas grandes (para que no se estire).
const double _maxContentWidth = 1200;

/// Destinos de navegación compartidos entre móvil y web.
const _destinations = [
  (icon: Icons.home_outlined, selected: Icons.home, label: 'Inicio'),
  (icon: Icons.search, selected: Icons.search, label: 'Buscar'),
  (icon: Icons.favorite_border, selected: Icons.favorite, label: 'Favoritos'),
  (icon: Icons.style_outlined, selected: Icons.style, label: 'Match'),
  (icon: Icons.person_outline, selected: Icons.person, label: 'Perfil'),
];

/// Shell con navegación adaptativa:
///  - Móvil (angosto): barra inferior (BottomNavigationBar).
///  - Web/escritorio (ancho): barra lateral (NavigationRail) + contenido
///    centrado con ancho máximo.
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= _wideBreakpoint;

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _goBranch,
              labelType: NavigationRailLabelType.all,
              destinations: [
                for (final d in _destinations)
                  NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selected),
                    label: Text(d.label),
                  ),
              ],
            ),
            const VerticalDivider(width: 1),
            // Contenido centrado con ancho máximo, con el banner de instalación
            // (PWA) arriba cuando estamos en web.
            Expanded(
              child: Column(
                children: [
                  if (kIsWeb) const InstallBanner(),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: _maxContentWidth),
                        child: navigationShell,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
        destinations: [
          for (final d in _destinations)
            NavigationDestination(
              icon: Icon(d.icon),
              selectedIcon: Icon(d.selected),
              label: d.label,
            ),
        ],
      ),
    );
  }
}
