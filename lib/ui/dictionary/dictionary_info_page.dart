import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatisthis/state/species_detail_state.dart';
import 'package:whatisthis/theme/app_theme.dart';
import 'package:whatisthis/viewmodel/species_detail_view_model.dart';

class DictionaryInfoPage extends ConsumerStatefulWidget {
  final String speciesId;
  const DictionaryInfoPage({super.key, required this.speciesId});

  @override
  ConsumerState<DictionaryInfoPage> createState() => _DictionaryInfoPageState();
}

class _DictionaryInfoPageState extends ConsumerState<DictionaryInfoPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref
        .read(speciesDetailViewModelProvider.notifier)
        .loadSpeciesDetail(widget.speciesId));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(speciesDetailViewModelProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        elevation: 0,
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
      body: SafeArea(
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
          data: (speciesState) {
            if (speciesState is SpeciesDetailSuccess) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: MediaQuery.of(context).size.height * 0.3,
                    floating: false,
                    pinned: true,
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () => Navigator.pop(context)),
                    flexibleSpace: FlexibleSpaceBar(
                      background: CachedNetworkImage(
                        imageUrl: speciesState.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            speciesState.name,
                            style: AppTheme.lightTheme.textTheme.headlineSmall,
                          ),
                          SizedBox(height: 12),
                          Text(
                            '소개',
                            style: AppTheme.lightTheme.textTheme.titleLarge,
                          ),
                          Divider(thickness: 1),
                          Text(
                            speciesState.description,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
