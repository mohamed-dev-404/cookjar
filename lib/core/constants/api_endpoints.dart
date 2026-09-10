class EndPoints {
  EndPoints._();

  //! EndPoints

  //? --- Auth  --- ;
  static String login = '/Users/login';
  static String register = '/Users/register';
  static String refresh = '/Users/refresh';
  static const String logout = '/Users/logout';

  // //? --- Home  --- ;
  // //* Instructor endpoints
  static const String getSliders = '/sliders';
  static const String getBestSeller = '/products-bestseller';
  // static String unenrollCourse(String courseId) =>
  //     'enrollments/my-courses/$courseId';

  //? --- Profile  --- ;
  static const String getProfile = '/Users/me';
  static const String completeProfile = '/Users/me/profile';
  static const String updateProfilePicture = '/Users/me/profile-picture';

  //? --- Explore  --- ;
  static const String getUsers = '/Users';
  static String getUserById(int id) => '/Users/$id';
  static const String requestSession = '/Sessions/request';
  static const String offerSession = '/Sessions/offer';

  //? --- Lookups  --- ;
  static const String getLanguages = '/Languages';
  static const String getMainSkillsWithSubSkills = '/MainSkills/with-subskills';

  //? --- Wallet  --- ;
  static const String creditTransactionHistory = '/CreditTransactions/history';

  //? --- Notifications  --- ;
  static const String getNotifications = '/Notifications';
  static const String unreadNotificationsCount =
      '/Notifications/unread-count';

  //? --- Sessions --- ;
  static const String getRequestedSessions = '/Sessions/requested';
  static const String getReceivedSessions = '/Sessions/received';
  static String sessionById(int sessionId) => '/Sessions/$sessionId';
  static String zegoToken(int sessionId) => '/Sessions/$sessionId/zego-token';
  static String acceptSession(int sessionId) => '/Sessions/$sessionId/accept';
  static String declineSession(int sessionId) => '/Sessions/$sessionId/decline';
  static String cancelSession(int sessionId) => '/Sessions/$sessionId/cancel';
  static String rescheduleSession(int sessionId) =>
      '/Sessions/$sessionId/reschedule';
}
