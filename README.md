# flutter_mvcs_simple
 
 Ini Adalah MVCS (Model View Controller Service) Sederhana dengan menggunakan 2 package

```
dio: ^4.0.4
hooks_riverpod: ^1.0.3
```

Struktur folder

```
core/
-models/
-provicers/
-services/
ui/
main.dart
```

Penggunaan:

models/user_model.dart
```
class User{
 ...
}
```

services/user_service.dart
```

class UserService {
  Future<List<User>> getUser() async {
    try {
      const path = 'https://jsonplaceholder.typicode.com/users';
      final res = await Dio().get(path);
      final List list = res.data;
      return list.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}

final userService = Provider((ref) => UserService());
```

providers/user_provider.dart
```
class UserNotifier extends StateNotifier<AsyncValue<List<User>>>{
  final AutoDisposeStateNotifierProviderRef _ref;
  late final UserService _userService;

  UserNotifier(this._ref) : super(const AsyncValue.data(<User>[])) {
    _userService = _ref.watch(userService);
  }

  Future<void> getUsers() async {
    state = const AsyncValue.loading();
    final res =
    await AsyncValue.guard(() async => await _userService.getUser());
    state = AsyncValue.data(res.asData!.value);
  }
}


final usersProvider = StateNotifierProvider.autoDispose<UserNotifier, AsyncValue<List<User>>>((ref) {
  return UserNotifier(ref);
});
```


main.dart
```
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

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

```



Screenshot

<img src="https://raw.githubusercontent.com/ekohendratno/flutter_mvcs/main/screenshot/img1.jpg" width="23%"></img> 


