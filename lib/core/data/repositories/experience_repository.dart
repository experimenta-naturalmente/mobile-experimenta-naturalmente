import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/event.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';
import 'package:turismo_rural_frontend/core/services/aws/aws.dart';

class ExperienceRepository implements IExperienceRepository {
  AwsS3Service awsS3Service;
  String apiUrl;

  ExperienceRepository({required this.awsS3Service, required this.apiUrl});

  @override
  Future<Set<Experience>> fetchExperiencesFromCategory(
    ExperienceCategory category,
  ) async {
    if (category.name == 'Evento') {
      return fetchFeaturedEvents();
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
            .where((element) => element.category.id == category.id)
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
  Future<Spot> fetchFeaturedSpotById(int spotId) async {
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
  Future<Set<Spot>> fetchFeaturedSpots() async {
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
  Future<Set<Event>> fetchFeaturedEvents() async {
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
          .toSet();
      return events;
    } else {
      throw Exception('Failed to load events');
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
