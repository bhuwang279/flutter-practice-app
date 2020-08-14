import 'package:graphql/client.dart';

class CustomGraphQLClient extends GraphQLClient {
  
  static  HttpLink _httpLink = HttpLink(uri: 'http://localhost:8000/graphql/',);

  CustomGraphQLClient():super(link: _httpLink, cache: InMemoryCache() );
  
  
  

}
