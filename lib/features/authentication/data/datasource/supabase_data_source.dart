import 'dart:io';

import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/cloudinary.dart';

abstract class SupabaseDataSource {
  Future<bool> signIn(String phoneNumber);
  Future<bool> verifyOTP(String phoneNumber, String otp);
  Future<bool> signUp(String fullName, String? bio, File? profile,String? profileUrl);
  Future<bool> isFirstTime();
  Future<bool> providerSignIn(String provider);
}

class SupabaseDataSourceImpl implements SupabaseDataSource {
  final SupabaseClient supabaseClient;

  SupabaseDataSourceImpl(this.supabaseClient);

  @override
  Future<bool> signIn(String phoneNumber) async {
    final response = await supabaseClient.auth
        .signInWithOtp(phone: phoneNumber)
        .then((value) {
      return true;
    }).catchError((error) {
      print("Error sending OTP: $error");
      return false;
    });

    return response;
  }

  @override
  Future<bool> verifyOTP(String phoneNumber, String otp) async {
    final response = await supabaseClient.auth
        .verifyOTP(phone: phoneNumber, token: otp, type: OtpType.sms)
        .then((value) {
      return true;
    }).catchError((error) {
      return false;
    });

    return response;
  }

  @override
  Future<bool> signUp(String fullName, String? bio, File? profile,String? profileUrl) async {
    final supabaseUser = supabaseClient.auth.currentSession!.user;
    final profilePictureUrl = profile != null
        ? await cloudinaryUpload(
            profile,
            "$fullName.${supabaseClient.auth.currentSession!.user.id}",
            "profile-picture")
        : profileUrl;

    final insertResult = await supabaseClient.from('user_profile').insert({
      'user_id': supabaseUser.id,
      'bio': bio ?? '',
      'profile_picture': profilePictureUrl,
      'full_name': fullName,
    });
    if (insertResult != null) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> isFirstTime() async {
    final response = await supabaseClient
        .from('user_profiles')
        .select()
        .eq('user_id', supabaseClient.auth.currentSession!.user.id);

    final userProfiles = response.data;

    if (userProfiles.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<bool> providerSignIn(String provider) async {
    // Perform the sign-in operation using the specified provider
    var response = await supabaseClient.auth.signInWithOAuth(
        provider == "Google" ? Provider.google : Provider.facebook,
        authScreenLaunchMode: LaunchMode.inAppWebView);
    
    return response;
  }
}
