import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';

part 'products_filter_event.dart';
part 'products_filter_state.dart';

class ProductsFilterBloc
    extends Bloc<ProductsFilterEvent, ProductsFilterState> {
  ProductsFilterBloc({
    required ProductsFilter initialFilter,
  }) : super(ProductsFilterState(
          filter: initialFilter,
          initialFilter: initialFilter,
        )) {
    on<FilterChangeView>(_onFilterChangeView);
    on<FilterChangeSorting>(_onFilterChangeSorting);
    on<FilterShowCompleted>(_onFilterShowCompleted);
    on<FilterShowMarked>(_onFilterShowMarked);
    on<FilterReset>(_onFilterReset);
  }

  void _onFilterChangeView(
    FilterChangeView event,
    Emitter<ProductsFilterState> emit,
  ) {
    emit(
      state.copyWith(
        filter: state.filter.copyWith(
          view: event.view,
          isDefault: false,
        ),
      ),
    );
  }

  void _onFilterChangeSorting(
    FilterChangeSorting event,
    Emitter<ProductsFilterState> emit,
  ) {
    emit(
      state.copyWith(
        filter: state.filter.copyWith(
          sorting: event.sorting,
          ascendingSorting: event.ascending,
          isDefault: false,
        ),
      ),
    );
  }

  void _onFilterShowCompleted(
    FilterShowCompleted event,
    Emitter<ProductsFilterState> emit,
  ) {
    emit(
      state.copyWith(
        filter: state.filter.copyWith(
          showCompleted: event.show,
          isDefault: false,
        ),
      ),
    );
  }

  void _onFilterShowMarked(
    FilterShowMarked event,
    Emitter<ProductsFilterState> emit,
  ) {
    emit(
      state.copyWith(
        filter: state.filter.copyWith(
          showMarked: event.show,
          isDefault: false,
        ),
      ),
    );
  }

  void _onFilterReset(
    FilterReset event,
    Emitter<ProductsFilterState> emit,
  ) {
    emit(
      state.copyWith(
        filter: const ProductsFilter(),
      ),
    );
  }
}
