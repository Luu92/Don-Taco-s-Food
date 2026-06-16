//import 'package:http/http.dart' as http;

class AuthService {
  Future<bool> login(
    String email,
    String password,
  ) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    
    //Reemplazamos con la llamada del servicio
    // final response = await http.post(
    //       Uri.parse('http://localhost:8080/api/auth/login'),
    //       body: {
    //         'email' : email,
    //         'password':password
    //       }
    // );
    // return response.statusCode == 200;
    
    return email == 'test@gmail.com' && password == '1234';
  }
}
