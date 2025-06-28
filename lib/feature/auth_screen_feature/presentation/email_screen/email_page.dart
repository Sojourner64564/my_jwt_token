import 'package:flutter/material.dart';
import 'package:my_jwt_token/core/injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_jwt_token/feature/auth_screen_feature/presentation/controller/email_controller/email_controller_cubit.dart';
import 'package:my_jwt_token/feature/auth_screen_feature/presentation/email_code_screen/email_code_screen.dart';

class EmailPage extends StatelessWidget {
  EmailPage({super.key});

  final authControllerCubit = getIt<EmailControllerCubit>();

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
                  maxLength: 255,
                  onSubmitted: (text) {
                    authControllerCubit.login(text, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmailCodeScreen(),
                        ),
                      );
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                BlocBuilder<EmailControllerCubit, EmailControllerState>(
                  bloc: authControllerCubit,
                  builder: (context, state) {
                    if (state is EmailControllerError) {
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
        BlocBuilder<EmailControllerCubit, EmailControllerState>(
          bloc: authControllerCubit,
          builder: (context, state) {
            if (state is EmailControllerLoading) {
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
