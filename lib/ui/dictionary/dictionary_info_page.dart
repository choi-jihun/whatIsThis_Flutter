import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatisthis/cosntants/dummy_dictionary_info.dart';
import 'package:whatisthis/theme/app_theme.dart';

class DictionaryInfoPage extends StatefulWidget {
  final String speciesId;
  const DictionaryInfoPage({super.key, required this.speciesId});

  @override
  State<DictionaryInfoPage> createState() => _DictionaryInfoPageState();
}

class _DictionaryInfoPageState extends State<DictionaryInfoPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final dicInfo =
        dummyDictionaryInfos.firstWhere((dic) => dic.dicId == widget.speciesId);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios)),
        elevation: 8,
      ),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: MediaQuery.of(context).size.height * 0.3,
          automaticallyImplyLeading: false,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
              background: Stack(
            children: [
              PageView.builder(
                  itemCount: dicInfo.imageUrl.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: dicInfo.imageUrl[index],
                      fit: BoxFit.cover,
                    );
                  }),
              Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                          dicInfo.imageUrl.length,
                          (index) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                width: 8,
                                height: 9,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentIndex == index
                                        ? Colors.white
                                        : Colors.white.withAlpha(100)),
                              ))
                    ],
                  ))
            ],
          )),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dicInfo.dicName,
                  style: AppTheme.lightTheme.textTheme.headlineSmall,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  '소개',
                  style: AppTheme.lightTheme.textTheme.titleLarge,
                ),
                Divider(thickness: 1),
                Text(
                  dicInfo.dicDes,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.volume_up_rounded),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20), bottom: Radius.circular(0)),
            ),
          ),
          child: Text(
            '찾으러 가기',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ));
  }
}
