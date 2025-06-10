import 'package:dartz/dartz.dart';
import 'package:graduation_project_ui/core/Entity/ArticalEntity.dart';
import 'package:graduation_project_ui/core/Errors/failuers.dart';
import 'package:graduation_project_ui/core/Models/ArticalModel.dart';
import 'package:graduation_project_ui/core/Services/Data_Base_Service.dart';
import 'package:graduation_project_ui/core/Utils/Backend_const.dart';

class ArticalRepoImpl {
  final DatabaseService databaseService;

  ArticalRepoImpl({required this.databaseService});

  Future<Either<Failuers, List<Articalentity>>> getArticals() async {
    try {
      var data = await databaseService.getData(path: BackendConst.getArticals)
          as List<Map<String, dynamic>>;
      List<Articalentity> articals =
          data.map((e) => Articalmodel.fromJson(e).toEntity()).toList();
      return Right(articals);
    } on Exception catch (e) {
      return Left(ServerFailuers(e.toString()));
    }
  }
}
