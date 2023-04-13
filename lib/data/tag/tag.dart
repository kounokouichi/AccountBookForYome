import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';

@freezed
class Tag with _$Tag {
  const factory Tag(
    int id,
    String name,
    String color,
    int sort,
  ) = _Tag;

  static List<Tag> fromList(List<Map<String, dynamic>> data) {
    List<Tag> result = [];
    for (var item in data) {
      result.add(
        Tag(
          item['id'] ?? 0,
          item['name'] ?? '',
          item['color'] ?? '',
          item['sort'] ?? 0,
        ),
      );
    }
    return result;
  }
}
