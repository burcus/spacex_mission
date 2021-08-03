import 'package:space_api/models/models.dart';

abstract class SpaceXState {}

class InitialState extends SpaceXState{}

class Failure extends SpaceXState{}

class Fetched extends SpaceXState{
  ApiResponse info;
  Fetched(this.info);
}
