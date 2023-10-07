import 'package:graphql/client.dart';

class GraphConfig {
  // Static method to get the GraphQL client
  static GraphQLClient getClient() {
    // Create an HttpLink to the GraphQL server from hosted server
    HttpLink httpLink = HttpLink(
      'https://carpal-winter-tile.glitch.me/graphql',
    );
    // Create an HttpLink to the GraphQL server from local ip please change accordingly
    // HttpLink httpLink = HttpLink(
    //   'http://192.168.2.11:4000/graphql',
    // );
    // Create a GraphQLClient with the HttpLink and a GraphQLCache
    return GraphQLClient(cache: GraphQLCache(), link: httpLink);
  }
}
