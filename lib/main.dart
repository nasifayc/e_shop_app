// import 'package:e_shop_app/core/graphql.dart';
// import 'package:e_shop_app/core/routes.dart';
import 'package:e_shop_app/core/graphql.dart';
import 'package:e_shop_app/core/routes.dart';
// import 'package:e_shop_app/screens/main/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:graphql_flutter/graphql_flutter.darts';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLService.initializeClient(),
      child: MaterialApp.router(
        title: 'E-Shop App',
        routerConfig: router,
      ),
    );
  }
}
