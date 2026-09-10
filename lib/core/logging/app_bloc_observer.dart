import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cookjar/core/logging/app_logger.dart';

/// Global Bloc observer used for logging the lifecycle of all Cubits and Blocs.
class AppBlocObserver extends BlocObserver {
  static const String _tag = 'BlocObserver';

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    AppLogger.success('🟢 ${bloc.runtimeType} created', tag: _tag);
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    AppLogger.info('''
📥 ${bloc.runtimeType}

Event:
$event
''', tag: _tag);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    AppLogger.debug('''
🔄 ${bloc.runtimeType}

Current State:
${change.currentState}

Next State:
${change.nextState}
''', tag: _tag);
    super.onChange(bloc, change);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    AppLogger.info('''
🚀 ${bloc.runtimeType}

Event:
${transition.event}

Current State:
${transition.currentState}

Next State:
${transition.nextState}
''', tag: _tag);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    AppLogger.error(
      '❌ ${bloc.runtimeType} threw an exception',
      tag: _tag,
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    AppLogger.info('🔴 ${bloc.runtimeType} closed', tag: _tag);
    super.onClose(bloc);
  }
}
