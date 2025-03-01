import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:stories_editor/src/domain/models/editable_items.dart';
import 'package:stories_editor/src/domain/models/modal_sheets.dart';
import 'package:stories_editor/src/domain/providers/notifiers/control_provider.dart';
import 'package:stories_editor/src/domain/providers/notifiers/draggable_widget_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/painting_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/text_editing_notifier.dart';
import 'package:stories_editor/src/domain/sevices/save_as_image.dart';
import 'package:stories_editor/src/presentation/utils/Extensions/hexColor.dart';
import 'package:stories_editor/src/presentation/utils/constants/item_type.dart';
import 'package:stories_editor/src/presentation/widgets/animated_onTap_button.dart';

/// create item of type Stickers
Future createStickerItem({required BuildContext context, List<String>? stickers}) async {
  // List<String> stickers = [
  //   '01_Cuppy_smile',
  //   '02_Cuppy_lol',
  //   '03_Cuppy_rofl',
  //   '04_Cuppy_sad',
  //   '05_Cuppy_cry',
  //   '06_Cuppy_love',
  //   '07_Cuppy_hate',
  //   '08_Cuppy_lovewithmug',
  //   '09_Cuppy_lovewithcookie',
  //   '10_Cuppy_hmm',
  //   '11_Cuppy_upset',
  //   '12_Cuppy_angry',
  //   '13_Cuppy_curious',
  //   '14_Cuppy_weird',
  //   '15_Cuppy_bluescreen',
  //   '16_Cuppy_angry',
  //   '17_Cuppy_tired',
  //   '18_Cuppy_workhard',
  //   '19_Cuppy_shine',
  //   '20_Cuppy_disgusting',
  //   '21_Cuppy_hi',
  //   '22_Cuppy_bye',
  //   '23_Cuppy_greentea',
  //   '24_Cuppy_phone',
  //   '25_Cuppy_battery',
  //   'tray_Cuppy',
  // ];
  late String? sticker;

  sticker = await showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: DraggableScrollableSheet(
            initialChildSize: 0.9,
            maxChildSize: 1,
            minChildSize: 0.9,
            expand: true,
            builder: (BuildContext context, ScrollController scrollController) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50.0,
                    height: 10.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(36.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 16,
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(0, 16),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 5.0),
                          Expanded(
                            child: GridView.builder(
                              primary: false,
                              controller: scrollController,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemCount: stickers!.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(5),
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () => Navigator.pop(context, stickers[index]),
                                child: Image.network(stickers[index],
                                    errorBuilder: (context, error, stackTrace) => const Center(
                                          child: Text(
                                            'Image Not Found',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                    loadingBuilder:
                                        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(child: CupertinoActivityIndicator());
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      });

  if (sticker != null) {
    final _editableItem = Provider.of<DraggableWidgetNotifier>(context, listen: false);
    _editableItem.sticker = sticker;

    _editableItem.draggableWidget.add(
      EditableItem()
        ..type = ItemType.sticker
        ..sticker = _editableItem.sticker!
        ..position = const Offset(0.0, 0.0),
    );
  }
}

/// custom exit dialog
Future<bool> exitDialog({
  required context,
  required contentKey,
  required StoriesEditorTextDelegate textDelegate,
}) async {
  return (await showDialog(
        context: context,
        barrierColor: Colors.black38,
        barrierDismissible: true,
        builder: (c) => Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetAnimationDuration: const Duration(milliseconds: 300),
          insetAnimationCurve: Curves.ease,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              padding: const EdgeInsets.only(top: 25, bottom: 5, right: 20, left: 20),
              alignment: Alignment.center,
              height: 280,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: HexColor.fromHex('#262626'),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.white10, offset: Offset(0, 1), blurRadius: 4),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    // 'Discard Edits?',
                    // modalTextTr.title,
                    textDelegate.exitDialogTitle,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    // "If you go back now, you'll lose all the edits you've made.",
                    textDelegate.exitDialogDescription,

                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white54, letterSpacing: 0.1),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  /// discard
                  AnimatedOnTapButton(
                    onTap: () async {
                      _resetDefaults(context: context);
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      // 'Discard',
                      textDelegate.exitDiscard,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.redAccent.shade200,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.1),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                    child: Divider(
                      color: Colors.white10,
                    ),
                  ),

                  /// save and exit
                  AnimatedOnTapButton(
                    onTap: () async {
                      final _paintingProvider = Provider.of<PaintingNotifier>(context, listen: false);
                      final _widgetProvider = Provider.of<DraggableWidgetNotifier>(context, listen: false);
                      if (_paintingProvider.lines.isNotEmpty || _widgetProvider.draggableWidget.isNotEmpty) {
                        /// save image
                        var response = await takePicture(contentKey: contentKey, context: context, saveToGallery: true);
                        if (response) {
                          _dispose(context: context, message: textDelegate.snackbarSuccessMsg);
                        } else {
                          _dispose(context: context, message: textDelegate.snackbarErrorMsg);
                        }
                      } else {
                        _dispose(context: context, message: textDelegate.snackbarEmptyMsg);
                      }
                    },
                    child: Text(
                      // 'Save Draft',s
                      textDelegate.exitSaveDraft,

                      style: const TextStyle(
                          fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                    child: Divider(
                      color: Colors.white10,
                    ),
                  ),

                  ///cancel
                  AnimatedOnTapButton(
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      // 'Cancel',
                      textDelegate.exitCancel,
                      style: const TextStyle(
                          fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )) ??
      false;
}

_resetDefaults({required BuildContext context}) {
  final _paintingProvider = Provider.of<PaintingNotifier>(context, listen: false);
  final _widgetProvider = Provider.of<DraggableWidgetNotifier>(context, listen: false);
  final _controlProvider = Provider.of<ControlNotifier>(context, listen: false);
  final _editingProvider = Provider.of<TextEditingNotifier>(context, listen: false);
  _paintingProvider.lines.clear();
  _widgetProvider.draggableWidget.clear();
  _widgetProvider.setDefaults();
  _paintingProvider.resetDefaults();
  _editingProvider.setDefaults();
  _controlProvider.mediaPath = '';
}

_dispose({required context, required message}) {
  _resetDefaults(context: context);
  Fluttertoast.showToast(msg: message);
  Navigator.of(context).pop(true);
}
