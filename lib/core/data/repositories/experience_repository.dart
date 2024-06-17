import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/event.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';
import 'package:turismo_rural_frontend/core/services/aws/aws.dart';
import 'package:turismo_rural_frontend/features/signup/data/experience_registration.dart';

class ExperienceRepository implements IExperienceRepository {
  AwsS3Service awsS3Service;
  String apiUrl;

  ExperienceRepository({required this.awsS3Service, required this.apiUrl});

  @override
  Future<Set<Experience>> fetchExperiencesFromCategory(
    ExperienceCategory category,
  ) async {
    if (category.name == 'Evento') {
      return fetchEvents();
    } else {
      final response = await http.get(
        Uri.parse(
          '$apiUrl/spot',
        ),
      );

      if (response.statusCode == 200) {
        final categoriesSet = await fetchExperienceCategories();
        final categoriesList = categoriesSet.toList();

        final List<dynamic> spotsJson =
            json.decode(response.body) as List<dynamic>;
        final spots = spotsJson
            .map(
              (json) =>
                  Spot.fromJson(json as Map<String, dynamic>, categoriesList),
            )
            .where(
              (element) => element.category.categoryId == category.categoryId,
            )
            .toSet();

        return spots;
      } else {
        throw Exception('Failed to load ${category.name} experiences.');
      }
    }
  }

  @override
  Future<Set<ExperienceCategory>> fetchExperienceCategories() async {
    final response = await http.get(Uri.parse('$apiUrl/category'));

    if (response.statusCode == 200) {
      final List<dynamic> categoriesJson =
          json.decode(response.body) as List<dynamic>;
      return categoriesJson
          .map(
            (json) => ExperienceCategory.fromJson(json as Map<String, dynamic>),
          )
          .toSet();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Future<Spot> fetchSpotById(int spotId) async {
    final categoriesSet = await fetchExperienceCategories();
    final categoriesList = categoriesSet.toList();
    categoriesList.removeWhere((element) => element.name == 'Evento');
    final response = await http.get(Uri.parse('$apiUrl/spot/$spotId'));

    if (response.statusCode == 200) {
      final List<dynamic> spotsJson =
          json.decode(response.body) as List<dynamic>;
      final spot = spotsJson
          .map(
            (json) =>
                Spot.fromJson(json as Map<String, dynamic>, categoriesList),
          )
          .first;
      return spot;
    } else {
      throw Exception('Failed to load spots');
    }
  }

  @override
  Future<Event> fetchEventById(int eventId) async {
    final categoriesSet = await fetchExperienceCategories();

    final categoriesList = categoriesSet.toList();
    categoriesList.removeWhere((element) => element.name != 'Evento');

    final response = await http.get(Uri.parse('$apiUrl/event/$eventId'));

    if (response.statusCode == 200) {
      final List<dynamic> spotsJson =
          json.decode(response.body) as List<dynamic>;
      final event = spotsJson
          .map(
            (json) =>
                Event.fromJson(json as Map<String, dynamic>, categoriesList),
          )
          .first;
      return event;
    } else {
      throw Exception('Failed to load event');
    }
  }

  @override
  Future<Set<Spot>> fetchSpots() async {
    final categoriesSet = await fetchExperienceCategories();
    final categoriesList = categoriesSet.toList();
    categoriesList.removeWhere((element) => element.name == 'Evento');

    final response = await http.get(
      Uri.parse(
        '$apiUrl/spot',
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> spotsJson =
          json.decode(response.body) as List<dynamic>;
      final spots = spotsJson
          .map(
            (json) =>
                Spot.fromJson(json as Map<String, dynamic>, categoriesList),
          )
          .toSet();

      return spots;
    } else {
      throw Exception('Failed to load spots');
    }
  }

  @override
  Future<Set<Event>> fetchEvents() async {
    final categoriesSet = await fetchExperienceCategories();
    final categoriesList = categoriesSet.toList();
    final response = await http.get(Uri.parse('$apiUrl/event'));

    if (response.statusCode == 200) {
      final List<dynamic> eventsJson =
          json.decode(response.body) as List<dynamic>;
      final events = eventsJson
          .map(
            (json) =>
                Event.fromJson(json as Map<String, dynamic>, categoriesList),
          )
          .toList();

      return events.toSet();
    } else {
      throw Exception('Failed to load events');
    }
  }

  @override
  Future<bool> registerExperience(ExperienceRegistration registration) async {
    if (registration.category == null) {
      return false;
    }
    final requestBody = jsonEncode(registration.toJson());
    final String url = registration.category!.name == 'Evento'
        ? '$apiUrl/event'
        : '$apiUrl/spot';

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: requestBody,
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to register experience');
    }
  }

  @override
  Future<String?> uploadImage(
    XFile file,
    Function(int) onProgress,
  ) {
    final upload = awsS3Service.uploadImageToS3(
      file: file,
      onProgress: onProgress,
    );
    return upload;
  }
}
