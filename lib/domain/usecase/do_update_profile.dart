import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/core/resources/usecase.dart';
import 'package:fansedu/domain/entity/common_entity.dart';
import 'package:fansedu/domain/repository/fansedu_repository.dart';

class DoUpdateProfile extends UseCase<CommonEntity, UpdateProfileParams>{
  final FanseduRepository _repository;

  DoUpdateProfile(this._repository);

  @override
  Future<Either<Failure, CommonEntity>> call(UpdateProfileParams params) async {
    final result = await _repository.doUpdateProfile(params);
    return result.fold((l) => Left(l), (r) {
      return Right(
          CommonEntity(
              success: r.success ?? false,
              message: r.message ?? '',
              code: r.code ?? 0,
          )
      );
    });
  }
}

class UpdateProfileParams extends Equatable {
  final String? full_name;
  final String? profile_picture;
  final String? phone_number;
  final String? address;
  final String? gender;
  final String? date_of_birth;
  final String? grade;
  final String? institution_name;
  const UpdateProfileParams(this.full_name, this.profile_picture, this.phone_number, this.address, this.gender, this.date_of_birth, this.grade, this.institution_name);

  @override
  List<Object?> get props => [full_name, profile_picture, phone_number, address, gender, date_of_birth, grade, institution_name];

}