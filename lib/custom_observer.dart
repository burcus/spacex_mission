import 'package:flutter_bloc/flutter_bloc.dart';

class CustomObserver extends BlocObserver {

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {

    super.onError(bloc, error, stackTrace);
    print('onError $error');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition $transition');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // when cubit is a bloc then we don't want to print the change because onTransition will already print it.
    if (bloc is! Bloc) {
      print('onTransition $change');
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent $event');
  }
}