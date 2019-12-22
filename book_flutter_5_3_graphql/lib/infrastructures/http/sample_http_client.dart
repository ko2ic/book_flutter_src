import 'dart:async';

import 'package:book_flutter_5_3_graphql/domains/models/dto/sample_result_dto.dart';
import 'package:graphql/client.dart';

class SampleHttpClient {
  // 次のページで作成したトークンを設定する [https://github.com/settings/tokens/]
  static const _yourPersonalAccessToken = 'TODO 自分で設定してください';

  static const _search = r'''
query ($freeWord: String!) {
  search(query: $freeWord, type:REPOSITORY, first:10) { 
    codeCount
    edges {
      node {
      	... on Repository{
      	  name
        	nameWithOwner          
          stargazers {
            totalCount
          }
      	} 
      }      
    }
  	pageInfo{
      hasNextPage
    }
  }
}
''';

  final HttpLink _httpLink = HttpLink(
    uri: 'https://api.github.com/graphql',
  );

  final AuthLink _authLink = AuthLink(
    getToken: () async => 'Bearer $_yourPersonalAccessToken',
  );

  Future<SampleResultDto> fetch(String freeWord) async {
    final _link = _authLink.concat(_httpLink);

    final _client = GraphQLClient(
      cache: InMemoryCache(),
      link: _link,
    );

    final options = QueryOptions(
      document: _search,
      variables: <String, dynamic>{
        'freeWord': freeWord,
      },
    );

    final result = await _client.query(options);

    if (result.hasErrors) {
      print(result.errors);
      return Future.error(result.errors);
    }

    return SampleResultDto.fromJson(result.data['search']);
  }
}
