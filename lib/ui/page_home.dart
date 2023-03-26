import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_mvcs/core/providers/user_provider.dart';

class PageHome extends StatelessWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MVCS Example'),
      ),
      body: const _UserList(),
    );
  }
}

class _UserList extends ConsumerWidget {
  const _UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getUsers = ref.watch(usersProvider.notifier);
    final users = ref.watch(usersProvider);

    return Scaffold(
      body: users.when(
          data: (list){
            final newList = list;
            if(newList.isEmpty){
              return Center(child: Text('Tidak ada data user'),);
            }

            return ListView.builder(
              itemCount: list.length,
                itemBuilder: (_,i){
                  final user = newList[i];
                  return Column(
                    children: [
                      Card(
                        margin: const EdgeInsets.all(16),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${user.name}'),
                              Text('${user.website}'),
                            ],
                          ),
                        ),
                      )
                    ],
                  );

                }
            );



          },
          error: (_,__){
            return Center(child: Text('err'),);
          },
          loading: (){
            return Center(child: CircularProgressIndicator(),);
          }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await getUsers.getUsers();
        },
      ),
    );
  }
}
