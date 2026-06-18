/// En web no se puede "hacer ping" a un dominio externo (lo bloquea CORS),
/// así que confiamos en lo que ya reportó connectivity_plus / el navegador.
Future<bool> hasInternet() async => true;
