import 'dart:ui';

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

  String get tabTotypeHint => 'Tap to type';

  String get snackbarSuccessMsg => 'Successfully Saved';

  String get snackbarErrorMsg => 'Error';

  String get snackbarEmptyMsg => 'Draft Empty';
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
  @override
  String get tabTotypeHint => 'انقر للكتابة';
  @override
  String get snackbarSuccessMsg => ' تم الحفظ بنجاح';
  @override
  String get snackbarErrorMsg => 'خطأ';
  @override
  String get snackbarEmptyMsg => 'المسودة فارغة';
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
