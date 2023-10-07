import 'package:graphql/client.dart';

class GraphConfig {
  static GraphQLClient getClient() {
    HttpLink httpLink = HttpLink(
      'https://carpal-winter-tile.glitch.me/graphql',
    );
    // HttpLink httpLink = HttpLink(
    //   'http://192.168.2.11:4000/graphql',
    // );
    return GraphQLClient(cache: GraphQLCache(), link: httpLink);
  }
}
