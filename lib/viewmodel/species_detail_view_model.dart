import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatisthis/di/providers.dart';
import 'package:whatisthis/state/species_detail_state.dart';

part 'species_detail_view_model.g.dart';

@riverpod
class SpeciesDetailViewModel
    extends AutoDisposeAsyncNotifier<SpeciesDetailState> {
  @override
  Future<SpeciesDetailState> build() async {
    return SpeciesDetailInitial();
  }

  Future<void> loadSpeciesDetail(String speciesId) async {
    state = const AsyncValue.loading();
    try {
      final species =
          await ref.read(speciesRepositoryProvider).getSpeciesDetail(speciesId);
      state = AsyncValue.data(SpeciesDetailSuccess(
        id: species.id,
        name: species.name,
        description: species.description ?? '설명이 없습니다.',
        imageUrl: species.imageUrl ?? '이미지가 없습니다.',
      ));
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
