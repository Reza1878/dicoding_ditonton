import 'package:flutter/material.dart';
import 'package:dicoding_ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:dicoding_ditonton/presentation/pages/about_page.dart';

class MyDrawer extends StatelessWidget {
  final String activeRoute;
  const MyDrawer({super.key, required this.activeRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: () {
              if (activeRoute == 'Movies') {
                Navigator.pop(context);
                return;
              }
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
            onTap: () {
              if (activeRoute == 'Watchlist') {
                Navigator.pop(context);
                return;
              }
              Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              if (activeRoute == 'About') {
                Navigator.pop(context);
                return;
              }
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
