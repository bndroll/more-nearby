import 'package:fpdart/fpdart.dart';
import 'package:vtb_map/core/di/locator.dart';
import 'package:vtb_map/core/utils/utility_types/failure.dart';
import 'package:vtb_map/core/utils/utility_types/use_case_base.dart';
import 'package:vtb_map/features/banks/data/banks_repository.dart';
import 'package:vtb_map/features/banks/entities/tag.dart';

import '../stores/tags_store.dart';

class GetAllTagsUseCase implements UseCase<Future<Either<Failure, List<Tag>>>, dynamic> {

  final _banksRepository = BanksRepository();
  final _tagsStore = locator<TagStore>();

  @override
  Future<Either<Failure, List<Tag>>> execute(args) async {
    if(_tagsStore.tags.isNotEmpty) return Right(_tagsStore.tags);
    return (await _banksRepository.getTags()).match(
            (l) => Left(l),
            (r) {
              _tagsStore.setTags(r);
              return Right(_tagsStore.tags);
            }
    );
  }

}