import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// Backend URL
const String graphqlEndpoint = "http://localhost:5000/graphql";

class GraphQLService {
  static HttpLink httpLink = HttpLink(graphqlEndpoint);

  static ValueNotifier<GraphQLClient> initializeClient() {
    return ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      ),
    );
  }
}
