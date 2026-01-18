part of 'page_bloc.dart';

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent.load() = PageLoad;
  const factory PageEvent.save() = PageSave;
}
