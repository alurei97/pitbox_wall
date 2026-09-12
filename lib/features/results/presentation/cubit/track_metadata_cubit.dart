import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/models/track_metadata.dart';
import 'track_metadata_state.dart';

class TrackMetadataCubit extends Cubit<TrackMetadataState> {
  TrackMetadataCubit(this.circuitId) : super(const TrackMetadataState.initial());

  final String circuitId;

  Future<void> load() async {
    emit(const TrackMetadataState.loading());
    try {
      final metadata = await loadTrackMetadata(circuitId);
      emit(TrackMetadataState.loaded(metadata: metadata));
    } catch (error) {
      emit(TrackMetadataState.error(message: error.toString()));
    }
  }
}
