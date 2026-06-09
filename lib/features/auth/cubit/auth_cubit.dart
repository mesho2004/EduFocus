import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:edufocus/core/network/api_services.dart';
import 'package:edufocus/features/auth/models/parent_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ApiServices _apiServices;
  final FlutterSecureStorage _secureStorage;

  AuthCubit({
    required ApiServices apiServices,
    FlutterSecureStorage secureStorage = const FlutterSecureStorage(),
  })  : _apiServices = apiServices,
        _secureStorage = secureStorage,
        super(AuthInitial());

  Future<void> checkAuthStatus() async {
    try {
      final token = await _secureStorage.read(key: 'auth_token');
      final id = await _secureStorage.read(key: 'parent_id');
      final email = await _secureStorage.read(key: 'parent_email');

      if (token != null && id != null && email != null) {
        bool hasChild = false;
        try {
          final children = await _apiServices.getChildren(token);
          hasChild = children.isNotEmpty;
          await _secureStorage.write(key: 'has_child', value: hasChild ? 'true' : 'false');
        } catch (_) {
          hasChild = (await _secureStorage.read(key: 'has_child')) == 'true';
        }

        emit(AuthSuccess(
          parent: Parent(id: id, email: email, authProvider: 'email'),
          token: token,
          hasChild: hasChild,
        ));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final parentModel = await _apiServices.login(email, password);
      
      if (parentModel.accessToken != null && parentModel.parent != null) {
        await _secureStorage.write(key: 'auth_token', value: parentModel.accessToken);
        await _secureStorage.write(key: 'parent_id', value: parentModel.parent!.id);
        await _secureStorage.write(key: 'parent_email', value: parentModel.parent!.email);
        
        bool hasChild = false;
        try {
          final children = await _apiServices.getChildren(parentModel.accessToken!);
          hasChild = children.isNotEmpty;
          await _secureStorage.write(key: 'has_child', value: hasChild ? 'true' : 'false');
        } catch (_) {}

        emit(AuthSuccess(
          parent: parentModel.parent!,
          token: parentModel.accessToken!,
          hasChild: hasChild,
        ));
      } else {
        emit(const AuthFailure('Invalid response structure from server'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> register(String email, String password, String confirmPassword) async {
    emit(AuthLoading());
    try {
      final parentModel = await _apiServices.registerUser({
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      });

      if (parentModel.accessToken != null && parentModel.parent != null) {
        await _secureStorage.write(key: 'auth_token', value: parentModel.accessToken);
        await _secureStorage.write(key: 'parent_id', value: parentModel.parent!.id);
        await _secureStorage.write(key: 'parent_email', value: parentModel.parent!.email);

        bool hasChild = false;
        try {
          final children = await _apiServices.getChildren(parentModel.accessToken!);
          hasChild = children.isNotEmpty;
          await _secureStorage.write(key: 'has_child', value: hasChild ? 'true' : 'false');
        } catch (_) {}

        emit(AuthSuccess(
          parent: parentModel.parent!,
          token: parentModel.accessToken!,
          hasChild: hasChild,
        ));
      } else {
        emit(const AuthFailure('Invalid response structure from server'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await _secureStorage.delete(key: 'auth_token');
      await _secureStorage.delete(key: 'parent_id');
      await _secureStorage.delete(key: 'parent_email');
      await _secureStorage.delete(key: 'has_child');
      await _secureStorage.delete(key: 'completed_lessons');
    } catch (_) {}
    emit(Unauthenticated());
  }

  Future<void> addChildProfile({
    required String name,
    required int age,
  }) async {
    emit(ChildCreateLoading());
    try {
      final token = await _secureStorage.read(key: 'auth_token');
      if (token == null) {
        emit(const ChildCreateFailure('Session expired. Please log in again.'));
        return;
      }
      final child = await _apiServices.addChild({
        'name': name,
        'age': age,
      }, token);
      await _secureStorage.write(key: 'has_child', value: 'true');
      emit(ChildCreateSuccess(child));
    } catch (e) {
      emit(ChildCreateFailure(e.toString()));
    }
  }
}
