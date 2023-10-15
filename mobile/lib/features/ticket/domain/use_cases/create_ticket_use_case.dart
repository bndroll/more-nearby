import 'package:fpdart/fpdart.dart';
import 'package:vtb_map/core/di/locator.dart';
import 'package:vtb_map/core/utils/utility_types/failure.dart';
import 'package:vtb_map/core/utils/utility_types/use_case_base.dart';
import 'package:vtb_map/features/ticket/data/create_ticket_dto.dart';
import 'package:vtb_map/features/ticket/data/ticket_dto.dart';
import 'package:vtb_map/features/ticket/data/ticket_repository.dart';
import 'package:vtb_map/features/ticket/domain/store/create_ticket_store.dart';

class CreateTicketUseCase implements UseCase<Future<Either<Failure, TicketDto>>, CreateTicketDto> {

  final _tickerRepository = TicketRepository();
  final _ticketStore = locator<CreateTicketStore>();

  @override
  Future<Either<Failure, TicketDto>> execute(args) async {
    return (await _tickerRepository.createTicket(args)).match(
            (l) => Left(l),
            (r) {
              _ticketStore.updateStepper(ticketDto: r);
              return Right(r);
            }
    );
  }

}