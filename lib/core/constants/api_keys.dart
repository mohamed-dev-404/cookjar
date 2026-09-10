//! --- JSON KEYS (The names that Dio sends and receives) ---

class ApiKeys {
  ApiKeys._();

  //? --- Common Response & General Keys ---
  static const String data = 'data';
  static const String errors = 'errors';
  static const String error = 'error';
  static const String message = 'message';
  static const String id = 'id';
  static const String status = 'status';
  static const String name = 'name';
  static const String fullName = 'fullName';
  static const String description = 'description';
  static const String slug = 'slug';
  static const String iconKey = 'iconKey';
  static const String subSkills = 'subSkills';
  static const String profileCompleted = 'profileCompleted';
  static const String requesterId = 'requesterId';
  static const String requesterName = 'requesterName';
  static const String helperId = 'helperId';
  static const String helperName = 'helperName';
  static const String mainSkillId = 'mainSkillId';
  static const String mainSkillName = 'mainSkillName';
  static const String topic = 'topic';
  static const String problemDescription = 'problemDescription';
  static const String durationMinutes = 'durationMinutes';
  static const String creditCost = 'creditCost';
  static const String scheduledAt = 'scheduledAt';
  static const String acceptedAt = 'acceptedAt';
  static const String completedAt = 'completedAt';
  static const String createdAt = 'createdAt';
  static const String zegoRoomId = 'zegoRoomId';
  static const String newScheduledAt = 'newScheduledAt';
  static const String comment = 'comment';
  static const String userRated = 'userRated';
  static const String userCanRate = 'userCanRate';
  static const String userRatingScore = 'userRatingScore';
  static const String pendingRescheduleByUser = 'pendingRescheduleByUser';

  //? User Model Keys
  static const String email = 'email';
  static const String password = 'password';
  static const String passwordComfirmation = 'password_confirmation';
  static const String profilePic = 'profilePic';
  static const String role = 'role';
  static const String address = 'address';
  static const String city = 'city';
  static const String phone = 'phone';
  static const String image = 'image';

  //? Pagination Keys
  static const String pagination = 'pagination';
  static const String totalElements = 'totalElements';
  static const String currentPage = 'currentPage';
  static const String size = 'size';
  static const String totalPages = 'totalPages';
  static const String hasNextPage = 'hasNextPage';
  static const String hasPrevPage = 'hasPrevPage';

  //? Fetch Users Params Keys
  static const String page = 'page';
  static const String sortBy = 'sortBy';
  static const String sortOrder = 'sortOrder';
  static const String search = 'search';

  //? Auth Keys
  static const String authorization = 'Authorization';
  static const String user = 'user';
  static const String token = 'token';
  static const String expiresIn = 'expiresIn';
  static const String refreshToken = 'refreshToken';
  static const String accessToken = 'accessToken';
  static const String resetToken = 'resetToken';
  static const String accessTokenExpiresInSeconds =
      'accessTokenExpiresInSeconds';
  static const String accessTokenExpiresAt = 'accessTokenExpiresAt';
  static const String refreshTokenExpiresAt = 'refreshTokenExpiresAt';
  static const String code = 'code';
  static const String action = 'action';
  static const String newPassword = 'newPassword';
  static const String confirmNewPassword = 'confirmNewPassword';
  static const String roles = 'roles';
  static const String student = 'student';
  static const String confirmPassword = 'confirmPassword';

  //? Notification Keys
  static const String title = 'title';
  static const String isRead = 'isRead';
  static const String count = 'count';

  //? Complete Profile keys
  static const String bio = 'bio';
  static const String jobTitle = 'jobTitle';
  static const String offeredMainSkill = 'offeredMainSkill';
  static const String offeredSubSkills = 'offeredSubSkills';
  static const String offeredDescription = 'offeredDescription';
  static const String neededSkills = 'neededSkills';
  static const String languageIds = 'languageIds';
  static const String subSkillIds = 'subSkillIds';
  static const String profilePicture = 'profilePicture';
}

//! --- API VALUES (Fixed values that the server expects inside the fields) ---

class ApiValues {
  ApiValues._();

  static const String bearer = 'Bearer';
}
