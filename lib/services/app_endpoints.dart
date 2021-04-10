class AppEndpoints {
//
  AppEndpoints._();

  static final String baseUrl = 'http://185.87.50.207/api';

  static final String auth = '$baseUrl/auth';
  static final String registration = '$baseUrl/registration';
  static final String verification = '$baseUrl/verification';
  static final String users = '$baseUrl/users';
  static final String refresh = '$baseUrl/refresh';
  static final String resetPassword = '$baseUrl/resetPassword';
  static final String addAvatar = '$baseUrl/dropzone/storage';
  static String getUser(int id) => '$baseUrl/user/$id';
  static final String user = '$baseUrl/user';
  static final String mySubscribers = '$baseUrl/subscribers/my';
  static String subscribeID(int id) => '$baseUrl/subscribe/$id';
  static String unsubscribeID(int id) => '$baseUrl/subscribe/$id';
  static final String bestFeedback = '$baseUrl/feedback/best';
  static String likeFeedback(int id) => '$baseUrl/feedback/$id/like';
  static String fullFeedback(int id) => '$baseUrl/feedback/$id';
  static final String allFeedbacks = '$baseUrl/feedbacks';
  static final String createFeedback = '$baseUrl/feedback';
  static final String updateFeedback = '$baseUrl/feedback';
  static String deleteFeedback(int id) => '$baseUrl/feedback/$id';
  static final String bestComments = '$baseUrl/feedback';

  //
}
