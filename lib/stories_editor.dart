// ignore_for_file: must_be_immutable
library stories_editor;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stories_editor/src/domain/models/modal_sheets.dart';
import 'package:stories_editor/src/domain/providers/notifiers/control_provider.dart';
import 'package:stories_editor/src/domain/providers/notifiers/draggable_widget_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/gradient_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/painting_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/scroll_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/text_editing_notifier.dart';
import 'package:stories_editor/src/presentation/main_view/main_view.dart';
import 'package:stories_editor/src/presentation/utils/constants/constants.dart';

export 'package:stories_editor/stories_editor.dart';
export 'package:stories_editor/src/domain/models/modal_sheets.dart';

class StoriesEditor extends StatefulWidget {
  /// editor custom font families
  final List<String>? fontFamilyList;

  /// editor custom font families package
  final bool? isCustomFontList;

  final Locale? locale;
  // dialog text translation
  final StoriesEditorTextDelegate? textDelegate;

  /// editor custom color gradients
  final List<List<Color>>? gradientColors;

  /// editor custom logo
  final Widget? middleBottomWidget;

  /// on done
  final Function(String)? onDone;

  /// on done button Text
  final Widget? onDoneButtonStyle;

  /// on back pressed
  final Future<bool>? onBackPress;

  /// editor custom color palette list
  final List<Color>? colorList;

  /// editor custom color palette list
  final List<String>? networkStickers;

  /// editor background color
  final Color? editorBackgroundColor;

  /// gallery thumbnail quality
  final int? galleryThumbnailQuality;

  const StoriesEditor(
      {Key? key,
      required this.onDone,
      this.textDelegate,
      this.networkStickers,
      this.locale,
      this.middleBottomWidget,
      this.colorList,
      this.gradientColors,
      this.fontFamilyList,
      this.isCustomFontList,
      this.onBackPress,
      this.onDoneButtonStyle,
      this.editorBackgroundColor,
      this.galleryThumbnailQuality})
      : super(key: key);

  @override
  _StoriesEditorState createState() => _StoriesEditorState();
}

class _StoriesEditorState extends State<StoriesEditor> {
  @override
  void initState() {
    Constants.textDelegate = widget.textDelegate ?? StoriesEditorTextDelegateFromLocale(widget.locale);
    Paint.enableDithering = true;
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ControlNotifier()),
        ChangeNotifierProvider(create: (_) => ScrollNotifier()),
        ChangeNotifierProvider(create: (_) => DraggableWidgetNotifier()),
        ChangeNotifierProvider(create: (_) => GradientNotifier()),
        ChangeNotifierProvider(create: (_) => PaintingNotifier()),
        ChangeNotifierProvider(create: (_) => TextEditingNotifier()),
      ],
      child: MainView(
        onDone: widget.onDone,
        networkStickers: widget.networkStickers,
        fontFamilyList: widget.fontFamilyList,
        isCustomFontList: widget.isCustomFontList,
        middleBottomWidget: widget.middleBottomWidget,
        gradientColors: widget.gradientColors,
        colorList: widget.colorList,
        onDoneButtonStyle: widget.onDoneButtonStyle,
        onBackPress: widget.onBackPress,
        editorBackgroundColor: widget.editorBackgroundColor,
        galleryThumbnailQuality: widget.galleryThumbnailQuality,
      ),
    );
  }
}
