import 'dart:async';

import 'package:book_flutter_5_3_graphql/domains/models/dto/sample_result_dto.dart';
import 'package:graphql/client.dart';

class SampleHttpClient {
  // 次のページで作成したトークンを設定する [https://github.com/settings/tokens/] 「Select scopes」は未選択で大丈夫です。
  static const _yourPersonalAccessToken = 'TODO アクセストークンを設定してください。SampleHttpClientソースを確認';

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

    if (result.hasException) {
      print(result.exception);
      return Future.error(result.exception);
    }

    return SampleResultDto.fromJson(result.data['search']);
  }
}
