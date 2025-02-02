import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final graphqlClientProvider = Provider<GraphQLClient>((ref) {
  final HttpLink httpLink = HttpLink("http://localhost:5000/graphql");

  final AuthLink authLink = AuthLink(getToken: () async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  });

  final Link link = authLink.concat(httpLink);
  return GraphQLClient(
    cache: GraphQLCache(),
    link: link,
  );
});
