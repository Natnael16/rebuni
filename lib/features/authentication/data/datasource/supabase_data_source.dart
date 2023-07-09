import 'package:supabase/supabase.dart';

import '../model/user_model.dart';
abstract class SupabaseDataSource{
    Future<UserModel?> signIn(String phoneNumber);
}

class SupabaseDataSourceImpl implements SupabaseDataSource{
  final SupabaseClient supabaseClient;

  SupabaseDataSourceImpl(this.supabaseClient);

  Future<UserModel?> signIn(String phoneNumber) async {
    final response = await supabaseClient
        .from('users')
        .select()
        .eq('phoneNumber', phoneNumber)
        .single()
        ;

    if (response.error == null && response.data != null) {
      return UserModel.fromJson(response.data);
    } else {
      return null;
    }
  }

}