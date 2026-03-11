import 'package:funcio_permuta_1/models/user.dart';

class UserRepository {
  // 🔹 Lista de usuarios en memoria (simula una base de datos)
  static final List<User> _users = [
    User(
      name: 'Admin',
      phone: '600000000',
      email: 'admin@example.com',
      password: 'admin123',
      profileImagePath: '',
    ),
  ];

  // 🔹 Usuario actualmente autenticado
  static User? _currentUser;

  // Getters públicos
  static List<User> get users => List.unmodifiable(_users);
  static User? get currentUser => _currentUser;

  // 🔹 Registro de un nuevo usuario
  static bool register(User user) {
    final exists = _users.any(
          (u) => u.email.toLowerCase() == user.email.toLowerCase(),
    );
    if (exists) return false; // el email ya está registrado

    _users.add(user);
    return true;
  }

  // 🔹 Autenticación (login)
  static User? authenticate(String email, String password) {
    try {
      final user = _users.firstWhere(
            (u) =>
        u.email.toLowerCase() == email.toLowerCase() &&
            u.password == password,
      );
      _currentUser = user;
      return user;
    } catch (_) {
      return null; // no se encontró usuario
    }
  }

  // 🔹 Cerrar sesión
  static void logout() {
    _currentUser = null;
  }

  // 🔹 Actualizar los datos del usuario (nombre, teléfono, imagen, etc.)
  static bool updateUser(User updatedUser) {
    final index = _users.indexWhere(
          (u) => u.email.toLowerCase() == updatedUser.email.toLowerCase(),
    );

    if (index == -1) return false;

    _users[index] = updatedUser;

    if (_currentUser?.email.toLowerCase() == updatedUser.email.toLowerCase()) {
      _currentUser = updatedUser;
    }

    return true;
  }

  static bool updatePassword(String email, String newPassword) {
    final index = _users.indexWhere(
          (u) => u.email.toLowerCase() == email.toLowerCase(),
    );

    if (index == -1) return false;

    final user = _users[index];

    final updatedUser = User(
      name: user.name,
      phone: user.phone,
      email: user.email,
      password: newPassword,
      profileImagePath: user.profileImagePath,
    );

    _users[index] = updatedUser;

    if (_currentUser?.email.toLowerCase() == user.email.toLowerCase()) {
      _currentUser = updatedUser;
    }

    return true;
  }

  static void setCurrentUser(User user) {
    _currentUser = user;
  }
}
