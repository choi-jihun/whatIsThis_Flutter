import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/ui/home/near_park_list.dart';
import 'package:whatisthis/ui/home/popular_park_list.dart';
import 'package:whatisthis/ui/home/season_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.2,
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      imageUrl:
                          'https://i.namu.wiki/i/TYxKQDnuwFOcxdSaPR-L81SPQGf5aPEz13tINJ-Z508LKNtGmRmkZTKKEN82SrIZAYoLL8WSbXGzv2PiLgpRSg.webp',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Collapsing 영역',
                        style: AppTheme.lightTheme.textTheme.headlineMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: PopularParkList(),
                  ),
                  SizedBox(
                    height: 8,
                    width: MediaQuery.of(context).size.width,
                    child: ColoredBox(color: Colors.grey.shade300),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: NearParkList(),
                  ),
                  SizedBox(
                    height: 8,
                    width: MediaQuery.of(context).size.width,
                    child: ColoredBox(color: Colors.grey.shade300),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: SeasonList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
