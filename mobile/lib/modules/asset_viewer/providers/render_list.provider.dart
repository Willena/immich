import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/modules/home/ui/asset_grid/asset_grid_data_structure.dart';
import 'package:immich_mobile/modules/settings/providers/app_settings.provider.dart';
import 'package:immich_mobile/modules/settings/services/app_settings.service.dart';
import 'package:immich_mobile/shared/models/asset.dart';
import 'package:immich_mobile/utils/renderlist_generator.dart';
import 'package:isar/isar.dart';

final renderListProvider =
    FutureProvider.family<RenderList, List<Asset>>((ref, assets) {
  final settings = ref.watch(appSettingsServiceProvider);

  return RenderList.fromAssets(
    assets,
    GroupAssetsBy.values[settings.getSetting(AppSettingsEnum.groupAssetsBy)],
  );
});

final renderListQueryProvider = StreamProvider.family<RenderList,
    QueryBuilder<Asset, Asset, QAfterSortBy>?>(
  (ref, query) =>
      query == null ? const Stream.empty() : renderListGenerator(query, ref),
);
