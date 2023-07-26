import 'package:flutter/material.dart';
import 'package:test_bloc_app/cat_facts/bloc/cats_bloc.dart';
import 'package:test_bloc_app/cat_facts/models/cat_fact_model.dart';
import 'package:provider/provider.dart';

class CatsPresenter extends StatelessWidget {
  const CatsPresenter({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CatsBloc>(context, listen: false);
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Positioned.fill(
          child: StreamBuilder(
            stream: bloc.catsViewModelStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CatsWidget(catFactModel: snapshot.data!);
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}",
                    style: const TextStyle(color: Colors.red));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: FloatingActionButton(
            onPressed: () => bloc.fetchCatsData(),
            child: const Icon(Icons.refresh),
          ),
        ),
      ],
    );
  }
}

class CatsWidget extends StatelessWidget {
  const CatsWidget({required this.catFactModel, super.key});

  final CatFactModel catFactModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: catFactModel.facts.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListTile(
              title: Text(catFactModel.facts[index]),
            ),
          );
        });
  }
}
