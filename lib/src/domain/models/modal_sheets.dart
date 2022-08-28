class StoriesEditorTr {
  late String title;
  late String description;
  late String discardAction;
  late String saveDraftAction;
  late String cancelAction;

  StoriesEditorTr({
    required this.title,
    required this.description,
    required this.discardAction,
    required this.saveDraftAction,
    required this.cancelAction,
  });

  StoriesEditorTr.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    discardAction = json['discardAction'];
    saveDraftAction = json['saveDraftAction'];
    cancelAction = json['cancelAction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['discardAction'] = discardAction;
    data['saveDraftAction'] = saveDraftAction;
    data['cancelAction'] = cancelAction;
    return data;
  }
}
