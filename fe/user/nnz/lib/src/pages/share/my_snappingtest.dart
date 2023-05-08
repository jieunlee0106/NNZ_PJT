import 'package:flutter/material.dart';
import 'package:nnz/src/components/my_shared/my_shared_qrmake.dart';
import 'package:nnz/src/pages/share/sharing_info.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class SheetBelowTest extends StatelessWidget {
  const SheetBelowTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SnappingSheet(
        lockOverflowDrag: true,
        grabbingHeight: 50,
        grabbing: const GrabbingWidget(),
        sheetBelow: SnappingSheetContent(
          draggable: true,
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const MyShareQr(),
          ),
        ),
        child: SharingDetailInfo(),
      ),
    );
  }
}

class GrabbingWidget extends StatelessWidget {
  const GrabbingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: 100,
            height: 7,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
            color: Colors.grey[200],
            height: 2,
            margin: const EdgeInsets.all(15).copyWith(top: 0, bottom: 0),
          )
        ],
      ),
    );
  }
}
