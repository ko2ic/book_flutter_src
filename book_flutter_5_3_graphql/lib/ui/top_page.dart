import 'dart:collection';

import 'package:book_flutter_5_3_graphql/domains/models/bloc/loading_bloc.dart';
import 'package:book_flutter_5_3_graphql/domains/models/bloc/sample_bloc.dart';
import 'package:book_flutter_5_3_graphql/domains/models/dto/sample_result_dto.dart';
import 'package:book_flutter_5_3_graphql/domains/repositories/sample_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';

import 'widget/loading_widget.dart';

class TopPage extends StatelessWidget {
  final SampleRepository _repository;

  TopPage(this._repository);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoadingBloc>(
          create: (_) => LoadingBloc(),
          dispose: (_, bloc) => bloc.dispose(),
        ),
        Provider<SampleBloc>(
          create: (context) {
            var bloc = Provider.of<LoadingBloc>(context, listen: false);
            return SampleBloc(_repository, bloc);
          },
          dispose: (_, bloc) => bloc.dispose(),
        ),
      ],
      child: Stack(
        children: <Widget>[
          Scaffold(
              appBar: AppBar(
                title: const Text('Githubから取得'),
              ),
              body: _ListPage()),
          const LoadingWidget(),
        ],
      ),
    );
  }
}

class _ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<SampleBloc>(context, listen: false);
    return StreamBuilder<SampleResultDto>(
      initialData: const SampleResultDto(),
      stream: bloc.value,
      builder: (context, snapshot) {
        var result = snapshot.data;
        String errorMessage;
        if (snapshot.hasError) {
          if (snapshot.error is LinkedHashMap) {
            //　エラーの場合に前の状態を表示したいならこんな感じ
            result = (snapshot.error as LinkedHashMap)['beforeValue'];
            errorMessage = (snapshot.error as LinkedHashMap)["error"];
          } else {
            var graphqlErrors = (snapshot.error as OperationException).graphqlErrors;
            graphqlErrors.forEach(print);
            errorMessage = graphqlErrors.join("\n");
          }
        }

        return Column(
          children: <Widget>[
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: const Text('Flutterで検索'),
                  onPressed: () {
                    bloc.fetch('flutter');
                  },
                ),
                RaisedButton(
                  child: const Text('Dartで検索'),
                  onPressed: () {
                    bloc.fetch('dart');
                  },
                ),
                RaisedButton(
                  child: const Text('エラーの場合'),
                  onPressed: () {
                    bloc.fetch('error');
                  },
                ),
              ],
            ),
            snapshot.hasError ? Text(errorMessage) : const SizedBox.shrink(),
            Expanded(
                child: ListView.separated(
              itemCount: result?.items?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(title: Text(result.items[index].name));
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            )),
          ],
        );
      },
    );
  }
}
