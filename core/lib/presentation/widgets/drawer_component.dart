

import 'package:about/about_page.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:tv_series/presentation/pages/home_tv_page.dart';

import 'tab_bar_watchlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DrawerComponent extends StatelessWidget {
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
              Navigator.pushNamedAndRemoveUntil(context, HomeMoviePage.ROUTE_NAME, (route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('TV Series'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, HomeTvPage.ROUTE_NAME, (route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, TabBarWatchlist.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
          ),
        ],
      ),
    );
  }

}