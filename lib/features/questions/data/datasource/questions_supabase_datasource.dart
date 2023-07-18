import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:supabase/supabase.dart';

import '../../../../core/utils/cloudinary.dart';

abstract class SupabaseQuestionsDataSource {
  Future<bool> postQuestion({
    required String title,
    required String description,
    File? image,
    required List<String> categories,
    required bool isAnonymous,
  });
}

class SupabaseQuestionsDataSourceImpl implements SupabaseQuestionsDataSource {
  final SupabaseClient supabaseClient;
  SupabaseQuestionsDataSourceImpl(this.supabaseClient);

  @override
  Future<bool> postQuestion({
    required String title,
    required String description,
    File? image,
    required List<String> categories,
    required bool isAnonymous,
  }) async {
    try {
      // Upload the file to Cloudinary
      String? imageUrl = image != null
          ? await cloudinaryUpload(image, title, 'question-images')
          : null;

      // Prepare the data to be inserted into the questions table
      final data = {
        'title': title,
        'description': description,
        'image_url': imageUrl,
        'categories': categories,
        'is_anonymous': isAnonymous,
      };

      // Perform the insert operation in the questions table
      final response = await supabaseClient.from('questions').insert(data);

      // Check if the insert operation was successful and return the appropriate result
      return response == null;
    } catch (e) {
      return false;
    }
  }
}
