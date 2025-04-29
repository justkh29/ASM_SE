import 'package:flutter_application_1/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/service_locator.dart';
import 'package:flutter_application_1/domain/repository/auth/auth.dart';
import 'package:flutter_application_1/data/models/auth/signin_user_req.dart';

class SigninUseCase implements UseCase<Either, SigninUserReq> {
  @override
  Future<Either> call(SigninUserReq? params) async {
    return sl<AuthRepository>().signin(params!);
  }
}
