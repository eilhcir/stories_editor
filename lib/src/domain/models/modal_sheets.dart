import 'dart:ui';

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

/// All text delegates.
const List<StoriesEditorTextDelegate> cameraPickerTextDelegates = <StoriesEditorTextDelegate>[
  StoriesEditorTextDelegate(),
  ArabicStoriesEditorTextDelegate(),
];

class StoriesEditorTextDelegate {
  const StoriesEditorTextDelegate();

  String get languageCode => 'en';

  String get exitDialogTitle => 'Discard Edits?';

  String get exitDialogDescription => 'If you go back now, you\'ll lose all the edits you\'ve made.';

  String get exitDiscard => 'Discard';

  String get exitSaveDraft => 'Save Draft';

  String get exitCancel => 'Cancel';

  String get shareButton => 'Share';
}

class ArabicStoriesEditorTextDelegate extends StoriesEditorTextDelegate {
  const ArabicStoriesEditorTextDelegate();
  @override
  String get languageCode => 'ar';
  @override
  String get exitDialogTitle => 'هل تريد تجاهل التعديلات؟';
  @override
  String get exitDialogDescription => ' إذا عدت الآن ، ستفقد كل التعديلات التي أجريتها؟';
  @override
  String get exitDiscard => 'تجاهل';
  @override
  String get exitSaveDraft => 'حفظ المسودة';
  @override
  String get exitCancel => 'الغاء';
  @override
  String get shareButton => 'شارك';
}

/// Obtain the text delegate from the given locale.
StoriesEditorTextDelegate cameraPickerTextDelegateFromLocale(Locale? locale) {
  if (locale == null) {
    return const StoriesEditorTextDelegate();
  }
  final String languageCode = locale.languageCode.toLowerCase();
  for (final StoriesEditorTextDelegate delegate in cameraPickerTextDelegates) {
    if (delegate.languageCode == languageCode) {
      return delegate;
    }
  }
  return const StoriesEditorTextDelegate();
}
