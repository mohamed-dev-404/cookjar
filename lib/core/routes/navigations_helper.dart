import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A helper methods for navigation using GoRouter.

//* Pushes a new screen onto the navigation stack
Future<T?> push<T extends Object?>(BuildContext context, String routeName, {Object? extra}) {
  return context.push<T>(routeName, extra: extra);
}

//* Pushes a new screen onto the navigation stack, replacing the current one.
void pushReplacement(BuildContext context, String routeName, {Object? extra}) {
  context.pushReplacement(routeName, extra: extra);
}

//* Pushes a new screen and removes all previous screens from the stack.
void pushToBase(BuildContext context, String routeName, {Object? extra}) {
  context.go(routeName);
}

//* Pops the current screen off the navigation stack, returning to the previous screen.
void pop(BuildContext context) {
  context.pop();
}
