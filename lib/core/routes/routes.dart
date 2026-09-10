class Routes {
  Routes._();

  //* splash and welcome routes
  static const String splash = '/';

  //* Auth routes
  static const String login = '/login';
  static const String register = '/register';

  //* Complete profile routes
  static const String completeProfile = '/complete-profile';

  //* Main routes
  static const String main = '/main';

  //* Profile routes
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';

  //* Explore routes
  static const String publicProfilePath = '/public-profile/:userId';
  static String publicProfile(int userId) => '/public-profile/$userId';

  //* Notification routes
  static const String notifications = '/notifications';

  //* call view route
  static const String callView = '/call-view';

  //* Session Details route
  static const String sessionDetails = '/session-details';
}
