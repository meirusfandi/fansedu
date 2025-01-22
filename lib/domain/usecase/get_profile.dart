import 'package:dartz/dartz.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/core/resources/usecase.dart';
import 'package:fansedu/domain/entity/profile_entity.dart';
import 'package:fansedu/domain/repository/fansedu_repository.dart';

class GetProfile implements UseCaseNoParam<ProfileEntity> {
  final FanseduRepository repository;

  GetProfile(this.repository);

  @override
  Future<Either<Failure, ProfileEntity>> call() async {
    final result = await repository.doGetProfile();
    return result.fold((l) => Left(l), (r) {
      return Right(
          ProfileEntity(
            success: r.success ?? false,
            message: r.message ?? '',
            code: r.code ?? 0,
            data: DataProfileEntity(
                user_id: r.data?.user_id ?? '',
                profile_id: r.data?.profile_id ?? '',
                email: r.data?.email ?? '',
                full_name: r.data?.full_name ?? '',
                phone_number: r.data?.phone_number ?? '',
                address: r.data?.address ?? '',
                profile_picture: r.data?.profile_picture ?? '',
                gender: r.data?.gender ?? '',
                date_of_birth: r.data?.date_of_birth ?? '',
                grade: r.data?.grade ?? '',
                institution_name: r.data?.institution_name ?? '',
                role: DataRoleEntity(
                    role_id: r.data?.role?.role_id ?? '',
                    role_name: r.data?.role?.role_name ?? '',
                    role_description: r.data?.role?.role_description ?? ''
                )
            )
          )
      );
    });
  }
}
