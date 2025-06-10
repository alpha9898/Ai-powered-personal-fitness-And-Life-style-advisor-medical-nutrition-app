import 'package:bloc/bloc.dart';
import 'package:graduation_project_ui/core/Entity/ArticalEntity.dart';
import 'package:graduation_project_ui/core/Repo/Artical_repo_impl.dart';
import 'package:meta/meta.dart';

part 'artical_state.dart';

class ArticalCubit extends Cubit<ArticalState> {
  final ArticalRepoImpl articalRepo;
  ArticalCubit({required this.articalRepo}) : super(ArticalInitial());

  Future<void> getArticals() async {
    emit(ArticalLoading());
    var result = await articalRepo.getArticals();
    result.fold((fail) => emit(Articalfailure(fail.Massage)),
        (articals) => emit(ArticalSuccess(articals)));
  }
}
