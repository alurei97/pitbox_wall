import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/models/track_metadata.dart';

part 'track_metadata_state.freezed.dart';

@freezed
abstract class TrackMetadataState with _$TrackMetadataState {
  const factory TrackMetadataState.initial() = _Initial;
  const factory TrackMetadataState.loading() = _Loading;
  const factory TrackMetadataState.loaded({required TrackMetadata? metadata}) = _Loaded;
  const factory TrackMetadataState.error({required String message}) = _Error;
}
