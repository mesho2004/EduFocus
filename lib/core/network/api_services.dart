import 'package:dio/dio.dart';
import 'package:edufocus/features/auth/models/child_model.dart';
import 'package:edufocus/features/auth/models/parent_model.dart';
import 'package:edufocus/features/subjects/models/complete_lesson_model.dart';
import 'package:edufocus/features/subjects/models/curriculum_model.dart';
import 'package:edufocus/features/subjects/models/progress_model.dart';

class ApiServices {
  final Dio _dio;
  ApiServices(this._dio);

  Future<ParentModel> registerUser(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('auth/register', data: data);
      return ParentModel.fromJson(response.data);
    } on DioException catch (e) {
      String errorMessage = "An error occurred";
      if (e.response != null) {
        if (e.response!.data is Map) {
          final data = e.response!.data as Map;
          if (data['detail'] != null) {
            errorMessage = data['detail'].toString();
          } else {
            errorMessage = e.response!.statusMessage ?? "Server Error";
          }
        } else {
          errorMessage = e.response!.statusMessage ?? "Server Error";
        }
      } else {
        errorMessage = e.message ?? "Connection Error";
      }
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ParentModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'auth/login',
        data: {'email': email, 'password': password},
      );
      return ParentModel.fromJson(response.data);
    } on DioException catch (e) {
      String errorMessage = "An error occurred";
      if (e.response != null) {
        if (e.response!.data is Map) {
          final data = e.response!.data as Map;
          if (data['error'] != null) {
            errorMessage = data['error'].toString();
          } else if (data['message'] != null) {
            errorMessage = data['message'].toString();
          } else {
            errorMessage = e.response!.statusMessage ?? "Server Error";
          }
        } else {
          errorMessage = e.response!.statusMessage ?? "Server Error";
        }
      } else {
        errorMessage = e.message ?? "Connection Error";
      }
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ChildModel> addChild(Map<String, dynamic> data, String token) async {
    try {
      final response = await _dio.post(
        'children',
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return _parseChildModel(response.data);
    } on DioException catch (e) {
      String errorMessage = "An error occurred";
      if (e.response != null) {
        if (e.response!.data is Map) {
          final data = e.response!.data as Map;
          if (data['error'] != null) {
            errorMessage = data['error'].toString();
          } else if (data['message'] != null) {
            errorMessage = data['message'].toString();
          } else {
            errorMessage = e.response!.statusMessage ?? "Server Error";
          }
        } else {
          errorMessage = e.response!.statusMessage ?? "Server Error";
        }
      } else {
        errorMessage = e.message ?? "Connection Error";
      }
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ChildModel>> getChildren(String token) async {
    try {
      final response = await _dio.get(
        'children/me',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.data is List) {
        return (response.data as List)
            .map((json) => ChildModel.fromJson(json))
            .toList();
      } else if (response.data is Map) {
        final dataMap = response.data as Map<String, dynamic>;
        if (dataMap.containsKey('id') || dataMap.containsKey('name')) {
          return [ChildModel.fromJson(dataMap)];
        }
        final list = dataMap['children'] ?? dataMap['data'] ?? [];
        if (list is List) {
          return list.map((json) => ChildModel.fromJson(json)).toList();
        }
      }
      return [];
    } on DioException catch (e) {
      String errorMessage = "An error occurred";
      if (e.response != null) {
        if (e.response!.data is Map) {
          final data = e.response!.data as Map;
          if (data['error'] != null) {
            errorMessage = data['error'].toString();
          } else if (data['message'] != null) {
            errorMessage = data['message'].toString();
          } else {
            errorMessage = e.response!.statusMessage ?? "Server Error";
          }
        } else {
          errorMessage = e.response!.statusMessage ?? "Server Error";
        }
      } else {
        errorMessage = e.message ?? "Connection Error";
      }
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<CurriculumModel> getCurriculum(String subjectType) async {
    try {
      final response = await _dio.get('curriculums/$subjectType');
      return CurriculumModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      String errorMessage = "An error occurred";
      if (e.response != null) {
        if (e.response!.data is Map) {
          final data = e.response!.data as Map;
          if (data['error'] != null) {
            errorMessage = data['error'].toString();
          } else if (data['message'] != null) {
            errorMessage = data['message'].toString();
          } else {
            errorMessage = e.response!.statusMessage ?? "Server Error";
          }
        } else {
          errorMessage = e.response!.statusMessage ?? "Server Error";
        }
      } else {
        errorMessage = e.message ?? "Connection Error";
      }
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<CurriculumModel>> getAllCurriculums() async {
    try {
      final response = await _dio.get('curriculums');
      if (response.data is List) {
        return (response.data as List)
            .map((e) => CurriculumModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (response.data is Map) {
        final list =
            response.data['curriculums'] ?? response.data['data'] ?? [];
        if (list is List) {
          return list
              .map((e) => CurriculumModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }
      return [];
    } on DioException catch (e) {
      String errorMessage = "An error occurred";
      if (e.response != null) {
        if (e.response!.data is Map) {
          final data = e.response!.data as Map;
          if (data['error'] != null) {
            errorMessage = data['error'].toString();
          } else if (data['message'] != null) {
            errorMessage = data['message'].toString();
          } else {
            errorMessage = e.response!.statusMessage ?? "Server Error";
          }
        } else {
          errorMessage = e.response!.statusMessage ?? "Server Error";
        }
      } else {
        errorMessage = e.message ?? "Connection Error";
      }
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<CompleteLessonModel> completeLesson({
    required String subjectType,
    required int unitId,
    required int lessonIndex,
    required int grade,
    required int term,
    required String token,
  }) async {
    try {
      final response = await _dio.post(
        'curriculums/$subjectType/units/$unitId/lessons/$lessonIndex/complete',
        queryParameters: {'grade': grade, 'term': term},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return CompleteLessonModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      String errorMessage = "An error occurred";
      if (e.response != null) {
        if (e.response!.data is Map) {
          final data = e.response!.data as Map;
          if (data['error'] != null) {
            errorMessage = data['error'].toString();
          } else if (data['message'] != null) {
            errorMessage = data['message'].toString();
          } else {
            errorMessage = e.response!.statusMessage ?? "Server Error";
          }
        } else {
          errorMessage = e.response!.statusMessage ?? "Server Error";
        }
      } else {
        errorMessage = e.message ?? "Connection Error";
      }
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<int> getMyCoins(String token) async {
    try {
      final response = await _dio.get(
        'coins/me',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      // handle both { "coins": 50 } and a bare number
      if (response.data is int) return response.data as int;
      if (response.data is Map) {
        return (response.data['coins'] ??
                response.data['total_coins'] ??
                response.data['data'] ??
                0)
            as int;
      }
      return 0;
    } on DioException catch (e) {
      String errorMessage = "An error occurred";
      if (e.response != null) {
        if (e.response!.data is Map) {
          final data = e.response!.data as Map;
          if (data['error'] != null) {
            errorMessage = data['error'].toString();
          } else if (data['message'] != null) {
            errorMessage = data['message'].toString();
          } else {
            errorMessage = e.response!.statusMessage ?? "Server Error";
          }
        } else {
          errorMessage = e.response!.statusMessage ?? "Server Error";
        }
      } else {
        errorMessage = e.message ?? "Connection Error";
      }
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ProgressModel> getMyProgress(String token) async {
    try {
      final response = await _dio.get(
        'progress/me',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print('=== getMyProgress RAW response type: ${response.data.runtimeType} ===');
      print('=== getMyProgress RAW response: ${response.data} ===');

      Map<String, dynamic> jsonData;
      if (response.data is Map<String, dynamic>) {
        jsonData = response.data as Map<String, dynamic>;
      } else if (response.data is Map) {
        jsonData = Map<String, dynamic>.from(response.data as Map);
      } else {
        throw 'Unexpected response type: ${response.data.runtimeType}';
      }

      // Some APIs wrap the progress in a 'data' or 'progress' key
      if (jsonData.containsKey('data') && jsonData['data'] is Map) {
        jsonData = Map<String, dynamic>.from(jsonData['data'] as Map);
      }

      return ProgressModel.fromJson(jsonData);
    } on DioException catch (e) {
      String errorMessage = "An error occurred";
      if (e.response != null) {
        print('=== getMyProgress ERROR status: ${e.response!.statusCode} ===');
        print('=== getMyProgress ERROR body: ${e.response!.data} ===');
        if (e.response!.data is Map) {
          final data = e.response!.data as Map;
          if (data['error'] != null) {
            errorMessage = data['error'].toString();
          } else if (data['message'] != null) {
            errorMessage = data['message'].toString();
          } else {
            errorMessage = e.response!.statusMessage ?? "Server Error";
          }
        } else {
          errorMessage = e.response!.statusMessage ?? "Server Error";
        }
      } else {
        errorMessage = e.message ?? "Connection Error";
      }
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ChildModel> getChildProfile(String token) async {
    try {
      final response = await _dio.get(
        'children/me',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return _parseChildModel(response.data);
    } on DioException catch (e) {
      String errorMessage = "An error occurred";
      if (e.response != null) {
        if (e.response!.data is Map) {
          final data = e.response!.data as Map;
          if (data['error'] != null) {
            errorMessage = data['error'].toString();
          } else if (data['message'] != null) {
            errorMessage = data['message'].toString();
          } else {
            errorMessage = e.response!.statusMessage ?? "Server Error";
          }
        } else {
          errorMessage = e.response!.statusMessage ?? "Server Error";
        }
      } else {
        errorMessage = e.message ?? "Connection Error";
      }
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ChildModel> updateChildProfile({
    required String name,
    required int age,
    required String token,
  }) async {
    try {
      final response = await _dio.put(
        'children/me',
        data: {'name': name, 'age': age},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return _parseChildModel(response.data);
    } on DioException catch (e) {
      String errorMessage = "An error occurred";
      if (e.response != null) {
        if (e.response!.data is Map) {
          final data = e.response!.data as Map;
          if (data['error'] != null) {
            errorMessage = data['error'].toString();
          } else if (data['message'] != null) {
            errorMessage = data['message'].toString();
          } else {
            errorMessage = e.response!.statusMessage ?? "Server Error";
          }
        } else {
          errorMessage = e.response!.statusMessage ?? "Server Error";
        }
      } else {
        errorMessage = e.message ?? "Connection Error";
      }
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  ChildModel _parseChildModel(dynamic data) {
    if (data is Map) {
      final dataMap = Map<String, dynamic>.from(data);
      if (dataMap.containsKey('id') || dataMap.containsKey('name')) {
        return ChildModel.fromJson(dataMap);
      }
      final list = dataMap['children'] ?? dataMap['data'];
      if (list is List && list.isNotEmpty) {
        return ChildModel.fromJson(Map<String, dynamic>.from(list.first));
      }
      final child = dataMap['child'];
      if (child is Map) {
        return ChildModel.fromJson(Map<String, dynamic>.from(child));
      }
    } else if (data is List && data.isNotEmpty) {
      return ChildModel.fromJson(Map<String, dynamic>.from(data.first));
    }
    throw 'No child profile data found or invalid structure';
  }
}

