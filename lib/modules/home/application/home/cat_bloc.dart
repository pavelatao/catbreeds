import 'package:bloc/bloc.dart';
import 'package:catbreeds/modules/home/domain/models/cat.dart';
import 'package:catbreeds/modules/home/infrastructure/the_cat_api_repository.dart';
import 'package:equatable/equatable.dart';

part 'cat_event.dart';
part 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final TheCatApiRepository _catRepository;

  CatBloc({required TheCatApiRepository catRepository}) : _catRepository = catRepository, super(CatInitial()) {
    on<CatFetchRequested>(_onCatFetchRequested);
  }

  void _onCatFetchRequested(CatFetchRequested event, Emitter<CatState> emit) async {
    emit(CatLoading());
    try {
      final List<Cat> cats = await _catRepository.fetchCats(event.breedId);
      emit(CatLoaded(cats));
    } catch (e) {
      emit(CatError(e.toString()));
    }
  }
}
