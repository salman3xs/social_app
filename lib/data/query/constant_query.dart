import 'package:social_app/model/post_model.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/src/utils/extensions.dart';

class ConstantQueries {
  static const String post = """
  query {
  user(id: "U2") {
    name
    posts {
      content
      mentionedUsers {
        name
        posts {
          content
          author {
            name
          }
        }
      }
    }
  }
}
""";
  static String getUser(String userId) => """
query {
  user(id:"$userId"){
    id
    name
    phone
    following{
      id
    }
  }
}
""";
  static const String getAllUser = """
query{
  allUser{
    id
    name
  }
}
""";
  static String addUser(UserModal userModal) => """
  mutation{
  addUser(id:"${userModal.id}",phone:"${userModal.phone}",name:"${userModal.name}"){
    id
    phone
    name
  }
}
""";
  static String getPosts(String userId) => """
{
  newsfeed(userId:"$userId"){
    content
    author{
      name
    }
    mentionedUsers{
      name
    }
    img
  }
}
""";
  static String createPost(PostModel postModel) => """
mutation {
  addPost(id: "${postModel.id}", author: "${postModel.author}", content: "${postModel.content}", mentionedUsers: ${postModel.mentionedUsers.toQuery()}, img: "${postModel.img}") {
    content
  }
}
""";
  static String followUser(String usedId, String otherUserID) => """
mutation {
  follow(userId:"$usedId",otherUserId:"$otherUserID"){
    following{
      id
    }
  }
}
""";
}
