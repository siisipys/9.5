import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';
import 'api_service.dart';

class AuthService {
  static User? _currentUser;
  
  static User? get currentUser => _currentUser;
  static bool get isLoggedIn => ApiService.isLoggedIn && _currentUser != null;
  
  static Future<void> init() async {
    await ApiService.init();
    if (ApiService.isLoggedIn) {
      await loadUserFromStorage();
    }
  }
  
  static Future<void> loadUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final userName = prefs.getString('user_name');
    final userEmail = prefs.getString('user_email');
    
    if (userId != null && userName != null && userEmail != null) {
      _currentUser = User(id: userId, name: userName, email: userEmail);
    }
  }
  
  static Future<void> _saveUserToStorage(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', user.id);
    await prefs.setString('user_name', user.name);
    await prefs.setString('user_email', user.email);
  }
  
  static Future<void> _clearUserStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_name');
    await prefs.remove('user_email');
  }
  
  static Future<User> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await ApiService.post('/register', {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });
    
    if (response['success'] == true) {
      final token = response['data']['token'];
      final userData = response['data']['user'];
      
      await ApiService.setToken(token);
      _currentUser = User.fromJson(userData);
      await _saveUserToStorage(_currentUser!);
      
      return _currentUser!;
    }
    
    throw Exception(response['message'] ?? 'Registration failed');
  }
  
  static Future<User> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiService.post('/login', {
      'email': email,
      'password': password,
    });
    
    if (response['success'] == true) {
      final token = response['data']['token'];
      final userData = response['data']['user'];
      
      await ApiService.setToken(token);
      _currentUser = User.fromJson(userData);
      await _saveUserToStorage(_currentUser!);
      
      return _currentUser!;
    }
    
    throw Exception(response['message'] ?? 'Login failed');
  }
  
  static Future<User> getProfile() async {
    final response = await ApiService.get('/profile');
    
    if (response['success'] == true) {
      _currentUser = User.fromJson(response['data']['user']);
      await _saveUserToStorage(_currentUser!);
      return _currentUser!;
    }
    
    throw Exception(response['message'] ?? 'Failed to get profile');
  }
  
  static Future<void> logout() async {
    try {
      await ApiService.post('/logout', {});
    } catch (e) {
      // Ignore logout API errors
    }
    
    await ApiService.clearToken();
    await _clearUserStorage();
    _currentUser = null;
  }
}
