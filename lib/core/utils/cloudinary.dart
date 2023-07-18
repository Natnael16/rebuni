import 'dart:io';
import 'package:cloudinary/cloudinary.dart';

import '../../main.dart';

Future<String?> cloudinaryUpload(File file, fileName, folder) async {
  const apiKey = "935925156256877";
  const secret = "0p2086y4v1UGju29GhXJlDTQgQ0";
  final cloudinary = Cloudinary.signedConfig(
    apiKey: apiKey,
    apiSecret: secret,
    cloudName: "rebuni",
  );

  final response = await cloudinary.upload(
      file: file.path,
      fileBytes: file.readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      folder: folder,
      fileName: fileName,
      progressCallback: (count, total) {
        print('Uploading image from file with progress: $count/$total');
      });

  if (response.isSuccessful) {
    return response.secureUrl;
  }
  throw Exception("not a valid image");
}

Future<String?> supabaseUpload(File file, fileName, bucket) async {
  final filePath =
      'images/$fileName.${DateTime.now().millisecondsSinceEpoch}.jpg';
  final fileBytes = await file.readAsBytes();

  await supabase.storage
      .from(bucket)
      .uploadBinary(filePath, fileBytes)
      .onError((error, stackTrace) {
    throw Exception("upload failed: $error");
  });

  // Image uploaded successfully
  final publicURL = supabase.storage.from(bucket).getPublicUrl(filePath);
  return publicURL;
}
