import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_jwt_token/core/injectable/injectable.dart';
import 'package:my_jwt_token/feature/main_screen_feature/presentation/controller/user_controller/user_controller_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final userControllerCubit = getIt<UserControllerCubit>();

  @override
  void initState() {
    userControllerCubit.fetchUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(41, 72, 42, 1),
            Color.fromRGBO(78, 137, 80, 1),
            Color.fromRGBO(159, 185, 127, 1),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: BlocBuilder<UserControllerCubit, UserControllerState>(
                bloc: userControllerCubit,
                builder: (context, state) {
                  if(state is UserControllerInitial){
                    return Text('Bruh', style: TextStyle(fontSize: 30));
                  }
                  if(state is UserControllerLoading){
                    return Text('Загрузка...', style: TextStyle(fontSize: 30));
                  }
                  if(state is UserControllerLoaded){
                    return Text('UserId: ${state.userIdEntity.userId}', style: TextStyle(fontSize: 30));
                  }
                  if(state is UserControllerError){
                    return Text('Ошибка: ${state.error}', style: TextStyle(fontSize: 30));
                  }else{
                    return Text('Неожиданная ошибка', style: TextStyle(fontSize: 30));
                  }
                },
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
              ),
              onPressed: () {
                userControllerCubit.fetchUserId();
              },
              child: Text(
                'Получить UserId',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
