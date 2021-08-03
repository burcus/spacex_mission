import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_api/blocs/blocs.dart';
import 'package:space_api/repositories/spacex_repo.dart';

class SpaceXBloc extends Bloc<SpaceXEvent, SpaceXState> {
  SpaceXBloc(): super(InitialState());

  @override
  Stream<SpaceXState> mapEventToState(SpaceXEvent event) async*{
    if (event is FetchLatestMission) {
      final response = await SpaceXRepo.fetchLatest();
      if (response != null) {
        yield Fetched(response);
      } else {
        yield Failure();
      }
    }
  }
}