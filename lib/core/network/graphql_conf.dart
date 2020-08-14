import 'dart:async';

import 'package:graphql/client.dart';
import 'package:recharge_app/core/errors/exception.dart';

class CustomGraphQLClient {
  static const _url = 'http://localhost:8000/graphql';

  final GraphQLClient _authGraphQLClient;
  final GraphQLClient _unauthGraphQLClient;

  const CustomGraphQLClient._(this._authGraphQLClient, this._unauthGraphQLClient);

  factory CustomGraphQLClient() {
    final Link httpLink = HttpLink(uri: _url);
    //final Link authLink = AuthLink(getToken: 'dsfads');
    //final Link link = authLink.concat(httpLink);
    final Link link = httpLink;

    final authGraphQLClient = GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    );

    final unauthGraphQLClient = GraphQLClient(
      cache: InMemoryCache(),
      link: httpLink,
    );

    return CustomGraphQLClient._(authGraphQLClient, unauthGraphQLClient);
  }

  Future<dynamic> _query(GraphQLClient client, QueryOptions options) async {
    final result = await client.query(options);
    if (result.hasErrors) {
      throw result.errors;
    }
    return result.data;
  }

  Future<dynamic> _mutate(GraphQLClient client, MutationOptions options) async {
    final result = await client.mutate(options);
    if (result.hasErrors) {
      throw ServerException;
    }
    return result.data;
  }

  Future<dynamic> queryAuth(QueryOptions options) {
    return _query(_authGraphQLClient, options);
  }

  Future<dynamic> queryUnauth(QueryOptions options) {
    return _query(_unauthGraphQLClient, options);
  }

  Future<dynamic> mutateAuth(MutationOptions options) {
    return _mutate(_authGraphQLClient, options);
  }

  Future<dynamic> mutateUnauth(MutationOptions options) {
    return _mutate(_unauthGraphQLClient, options);
  }
}