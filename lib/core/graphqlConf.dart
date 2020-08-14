import 'package:graphql/client.dart';


final isAuthenticated = false;
final HttpLink _httpLink = HttpLink(
    uri: 'http://localhost:8000/graphql/',
);

AuthLink returnAuthLink (token){
  
    return  AuthLink(
      getToken: () async => 'Bearer $token',
  );
}

GraphQLClient _client;

GraphQLClient getGraphQLClient() {
  final Link _link =  isAuthenticated? returnAuthLink(getToken()).concat(_httpLink): _httpLink;
  _client ??= GraphQLClient(
    link: _link,
    cache: InMemoryCache(),
  );

  return _client;
}
String  getToken(){
  return 'YourToken';
}