import 'package:flutter/material.dart';
import 'package:my_jwt_token/core/injectable/injectable.dart';
import 'package:my_jwt_token/feature/auth_screen/presentation/controller/auth_controller_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final authControllerCubit = getIt<AuthControllerCubit>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 300,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Center(child: Icon(Icons.email_outlined, size: 50)),
                SizedBox(height: 50),
                Text('Введите почту'),
                TextField(
                  onSubmitted: (text) {
                    authControllerCubit.login(text, () {
                      /* Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SecondScreen()),
                              );*/
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                BlocBuilder<AuthControllerCubit, AuthControllerState>(
                  bloc: authControllerCubit,
                  builder: (context, state) {
                    if (state is AuthControllerError) {
                      return Text(
                        state.error,
                        style: TextStyle(color: Colors.red),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<AuthControllerCubit, AuthControllerState>(
          bloc: authControllerCubit,
          builder: (context, state) {
            if (state is AuthControllerLoading) {
              return Visibility(
                visible: true,
                child: Container(
                  color: Colors.white.withAlpha(150),
                  child: Center(child: CircularProgressIndicator()),
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }
}
