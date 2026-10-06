// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// //
// // import '../../../screens/appearance/appearance_page.dart';
// // import '../../../theme/kolek_colors.dart';
// // import '../../../widgets/kolek_widgets.dart';
// // import '../bloc/list_product_bloc.dart';
// // import '../bloc/list_product_event.dart';
// // import '../bloc/list_product_state.dart';
// // import '../data/list_product_data.dart';
// //
// // class ListProductScreen extends StatelessWidget {
// //   const ListProductScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppearancePage.background(context),
// //       body: SafeArea(
// //         child: BlocListener<ListProductBloc, ListProductState>(
// //           listenWhen: (prev, next) =>
// //           !prev.submitting && next.submitting,
// //           listener: (context, state) {
// //             // TODO: navigate to the next step once it exists.
// //           },
// //           child: ListView(
// //             padding: EdgeInsets.zero,
// //             children: [
// //               const _AppBar(),
// //               const _HeroSection(),
// //               const SizedBox(height: 12),
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// //                 child: BlocBuilder<ListProductBloc, ListProductState>(
// //                   builder: (context, state) {
// //                     return Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         _PhotosSection(state: state),
// //                         const SizedBox(height: 22),
// //                         _FieldLabel(ListProductData.titleLabel),
// //                         const SizedBox(height: 8),
// //                         _TextInput(
// //                           hint: ListProductData.titleHint,
// //                           value: state.title,
// //                           maxLength: ListProductData.titleMaxLength,
// //                           onChanged: (v) => context
// //                               .read<ListProductBloc>()
// //                               .add(ListProductTitleChanged(v)),
// //                         ),
// //                         const SizedBox(height: 18),
// //                         _FieldLabel(ListProductData.artistLabel),
// //                         const SizedBox(height: 8),
// //                         _TextInput(
// //                           hint: ListProductData.artistHint,
// //                           value: state.artist,
// //                           maxLength: ListProductData.artistMaxLength,
// //                           onChanged: (v) => context
// //                               .read<ListProductBloc>()
// //                               .add(ListProductArtistChanged(v)),
// //                         ),
// //                         const SizedBox(height: 18),
// //                         _FieldLabel(ListProductData.yearLabel),
// //                         const SizedBox(height: 8),
// //                         _TextInput(
// //                           hint: ListProductData.yearHint,
// //                           value: state.year,
// //                           onChanged: (v) => context
// //                               .read<ListProductBloc>()
// //                               .add(ListProductYearChanged(v)),
// //                         ),
// //                         const SizedBox(height: 18),
// //                         _FieldLabel(ListProductData.categoryLabel),
// //                         const SizedBox(height: 8),
// //                         _CategoryDropdown(
// //                           value: state.category,
// //                           onSelected: (v) => context
// //                               .read<ListProductBloc>()
// //                               .add(ListProductCategoryChanged(v)),
// //                         ),
// //                         const SizedBox(height: 18),
// //                         _FieldLabel(ListProductData.dimensionsLabel),
// //                         const SizedBox(height: 8),
// //                         _DimensionsRow(
// //                           width: state.width,
// //                           height: state.height,
// //                           onWidthChanged: (v) => context
// //                               .read<ListProductBloc>()
// //                               .add(ListProductWidthChanged(v)),
// //                           onHeightChanged: (v) => context
// //                               .read<ListProductBloc>()
// //                               .add(ListProductHeightChanged(v)),
// //                         ),
// //                         const SizedBox(height: 28),
// //                         _NextButton(enabled: state.canProceed),
// //                         const SizedBox(height: 14),
// //                         const _SaveDraftLink(),
// //                         const SizedBox(height: 24),
// //                       ],
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // ─────────────────────────────────────────────────────────────────────────
// // // App bar — logo left, close right
// // // ─────────────────────────────────────────────────────────────────────────
// //
// // class _AppBar extends StatelessWidget {
// //   const _AppBar();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.fromLTRB(16, 10, 14, 4),
// //       child: Row(
// //         children: [
// //           SvgPicture.asset(
// //             ListProductData.logoAsset,
// //             height: 26,
// //             fit: BoxFit.contain,
// //           ),
// //           const Spacer(),
// //           GestureDetector(
// //             onTap: () => Navigator.of(context).pop(),
// //             child: Container(
// //               width: 30,
// //               height: 30,
// //               decoration: BoxDecoration(
// //                 color: AppearancePage.foreground(context),
// //                 shape: BoxShape.circle,
// //               ),
// //               child: Icon(
// //                 Icons.close,
// //                 size: 16,
// //                 color: AppearancePage.background(context),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // // ─────────────────────────────────────────────────────────────────────────
// // // Hero — heading + dash + subtext on left, illustration on right
// // // ─────────────────────────────────────────────────────────────────────────
// //
// // class _HeroSection extends StatelessWidget {
// //   const _HeroSection();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final fg = AppearancePage.foreground(context);
// //
// //     return SizedBox(
// //       height: 240,
// //       child: Stack(
// //         clipBehavior: Clip.none,
// //         children: [
// //           Positioned(
// //             left: 16,
// //             top: 12,
// //             right: 140,
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   ListProductData.heading,
// //                   style: KolekText.sans(
// //                     size: 44,
// //                     weight: FontWeight.w700,
// //                     height: 1.02,
// //                     letterSpacing: -1.2,
// //                     color: fg,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 14),
// //                 Container(width: 26, height: 4, color: fg),
// //                 const SizedBox(height: 14),
// //                 Text(
// //                   ListProductData.subtext,
// //                   style: KolekText.mono(
// //                     size: 12,
// //                     weight: FontWeight.w400,
// //                     height: 1.55,
// //                     color: fg,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Positioned(
// //             right: -28,
// //             top: 0,
// //             bottom: 0,
// //             child: Image.asset(
// //               ListProductData.heroAsset,
// //               height: 235,
// //               fit: BoxFit.contain,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // // ─────────────────────────────────────────────────────────────────────────
// // // Photos section — label + counter + horizontal scroll row of slots
// // // ─────────────────────────────────────────────────────────────────────────
// //
// // class _PhotosSection extends StatelessWidget {
// //   const _PhotosSection({required this.state});
// //
// //   final ListProductState state;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Row(
// //           children: [
// //             _FieldLabel(ListProductData.photosLabel),
// //             const Spacer(),
// //             Text(
// //               '${state.photoCount}/${ListProductData.maxPhotos}',
// //               style: KolekText.mono(
// //                 size: 11,
// //                 color: AppearancePage.muted(context),
// //               ),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 10),
// //         SizedBox(
// //           height: 82,
// //           child: ListView.separated(
// //             scrollDirection: Axis.horizontal,
// //             itemCount: _slotCount(state),
// //             separatorBuilder: (_, _) => const SizedBox(width: 8),
// //             itemBuilder: (context, index) {
// //               if (index < state.photos.length) {
// //                 return _PhotoTile(
// //                   asset: state.photos[index],
// //                   onRemove: () => context
// //                       .read<ListProductBloc>()
// //                       .add(ListProductPhotoRemoved(index)),
// //                 );
// //               }
// //               // First empty slot after the photos → show the "+" tile.
// //               if (index == state.photos.length && state.canAddPhoto) {
// //                 return _AddPhotoTile(
// //                   onTap: () => context
// //                       .read<ListProductBloc>()
// //                       .add(const ListProductPhotoAdded()),
// //                 );
// //               }
// //               // Otherwise → empty placeholder tile.
// //               return const _EmptyPhotoTile();
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   /// Show the photos, the add tile, and enough empty placeholders to fill
// //   /// the visible row (four tiles total, minimum).
// //   int _slotCount(ListProductState state) {
// //     final filled = state.photos.length;
// //     final withAdd = state.canAddPhoto ? 1 : 0;
// //     final total = filled + withAdd;
// //     return total < 4 ? 4 : total;
// //   }
// // }
// //
// // class _PhotoTile extends StatelessWidget {
// //   const _PhotoTile({required this.asset, required this.onRemove});
// //
// //   final String asset;
// //   final VoidCallback onRemove;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       width: 76,
// //       height: 82,
// //       child: Stack(
// //         clipBehavior: Clip.none,
// //         children: [
// //           ClipRRect(
// //             borderRadius: BorderRadius.circular(8),
// //             child: Image.asset(
// //               asset,
// //               width: 76,
// //               height: 82,
// //               fit: BoxFit.cover,
// //             ),
// //           ),
// //           Positioned(
// //             top: -6,
// //             right: -6,
// //             child: GestureDetector(
// //               onTap: onRemove,
// //               child: Container(
// //                 width: 22,
// //                 height: 22,
// //                 decoration: BoxDecoration(
// //                   color: AppearancePage.foreground(context),
// //                   shape: BoxShape.circle,
// //                 ),
// //                 child: Icon(
// //                   Icons.close,
// //                   size: 12,
// //                   color: AppearancePage.background(context),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // class _AddPhotoTile extends StatelessWidget {
// //   const _AddPhotoTile({required this.onTap});
// //
// //   final VoidCallback onTap;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final fg = AppearancePage.foreground(context);
// //     final muted = AppearancePage.muted(context);
// //     final line = AppearancePage.line(context);
// //
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         width: 76,
// //         height: 82,
// //         decoration: BoxDecoration(
// //           color: AppearancePage.field(context),
// //           borderRadius: BorderRadius.circular(8),
// //           border: Border.all(color: line),
// //         ),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(Icons.add, size: 22, color: fg),
// //             const SizedBox(height: 6),
// //             Text(
// //               ListProductData.addPhotosLabel,
// //               textAlign: TextAlign.center,
// //               style: KolekText.mono(
// //                 size: 9,
// //                 color: muted,
// //                 height: 1.15,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class _EmptyPhotoTile extends StatelessWidget {
// //   const _EmptyPhotoTile();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       width: 76,
// //       height: 82,
// //       decoration: BoxDecoration(
// //         color: AppearancePage.field(context),
// //         borderRadius: BorderRadius.circular(8),
// //         border: Border.all(color: AppearancePage.line(context)),
// //       ),
// //     );
// //   }
// // }
// //
// // // ─────────────────────────────────────────────────────────────────────────
// // // Field label
// // // ─────────────────────────────────────────────────────────────────────────
// //
// // class _FieldLabel extends StatelessWidget {
// //   const _FieldLabel(this.text);
// //
// //   final String text;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Text(
// //       text,
// //       style: KolekText.sans(
// //         size: 13,
// //         weight: FontWeight.w500,
// //         color: AppearancePage.foreground(context),
// //       ),
// //     );
// //   }
// // }
// //
// // // ─────────────────────────────────────────────────────────────────────────
// // // Text input with optional counter suffix
// // // ─────────────────────────────────────────────────────────────────────────
// //
// // class _TextInput extends StatelessWidget {
// //   const _TextInput({
// //     required this.hint,
// //     required this.value,
// //     required this.onChanged,
// //     this.maxLength,
// //   });
// //
// //   final String hint;
// //   final String value;
// //   final ValueChanged<String> onChanged;
// //   final int? maxLength;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final fg = AppearancePage.foreground(context);
// //     final muted = AppearancePage.muted(context);
// //     final line = AppearancePage.line(context);
// //     final field = AppearancePage.field(context);
// //
// //     final counter = maxLength == null ? null : '${value.length}/$maxLength';
// //
// //     return TextField(
// //       controller: _ControllerFor(value),
// //       onChanged: onChanged,
// //       style: KolekText.sans(size: 14, color: fg),
// //       cursorColor: KolekColors.blue600,
// //       decoration: InputDecoration(
// //         isDense: true,
// //         hintText: hint,
// //         hintStyle: KolekText.sans(size: 14, color: muted),
// //         suffixText: counter,
// //         suffixStyle: KolekText.mono(size: 11, color: muted),
// //         filled: true,
// //         fillColor: field,
// //         contentPadding:
// //         const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(8),
// //           borderSide: BorderSide(color: line),
// //         ),
// //         enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(8),
// //           borderSide: BorderSide(color: line),
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(8),
// //           borderSide: BorderSide(color: KolekColors.blue600, width: 1.2),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // /// Small helper: creates a fresh TextEditingController seeded with [value]
// // /// but keyed by the initial value so rebuilds don't reset the cursor.
// // ///
// // /// NOTE: This is a lightweight approach for the demo. In production you'd
// // /// hoist the controllers into the state class or use a proper form widget.
// // class _ControllerFor extends TextEditingController {
// //   _ControllerFor(String value) : super(text: value);
// // }
// //
// // // ─────────────────────────────────────────────────────────────────────────
// // // Category dropdown — popup menu styled like the other inputs
// // // ─────────────────────────────────────────────────────────────────────────
// //
// // class _CategoryDropdown extends StatelessWidget {
// //   const _CategoryDropdown({
// //     required this.value,
// //     required this.onSelected,
// //   });
// //
// //   final String? value;
// //   final ValueChanged<String> onSelected;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final fg = AppearancePage.foreground(context);
// //     final muted = AppearancePage.muted(context);
// //     final line = AppearancePage.line(context);
// //     final field = AppearancePage.field(context);
// //
// //     final display = value ?? ListProductData.categoryHint;
// //     final displayColor = value == null ? muted : fg;
// //
// //     return PopupMenuButton<String>(
// //       tooltip: '',
// //       padding: EdgeInsets.zero,
// //       position: PopupMenuPosition.under,
// //       color: AppearancePage.menu(context),
// //       elevation: 8,
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(8),
// //         side: BorderSide(color: line),
// //       ),
// //       onSelected: onSelected,
// //       itemBuilder: (context) => [
// //         for (final category in ListProductData.categories)
// //           PopupMenuItem<String>(
// //             value: category,
// //             height: 44,
// //             padding: const EdgeInsets.symmetric(horizontal: 16),
// //             child: Align(
// //               alignment: Alignment.centerLeft,
// //               child: Text(
// //                 category,
// //                 style: KolekText.sans(size: 14, color: fg),
// //               ),
// //             ),
// //           ),
// //       ],
// //       child: Container(
// //         height: 48,
// //         padding: const EdgeInsets.symmetric(horizontal: 14),
// //         decoration: BoxDecoration(
// //           color: field,
// //           borderRadius: BorderRadius.circular(8),
// //           border: Border.all(color: line),
// //         ),
// //         child: Row(
// //           children: [
// //             Expanded(
// //               child: Text(
// //                 display,
// //                 style: KolekText.sans(size: 14, color: displayColor),
// //               ),
// //             ),
// //             Icon(
// //               Icons.keyboard_arrow_down,
// //               size: 20,
// //               color: AppearancePage.icon(context),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // ─────────────────────────────────────────────────────────────────────────
// // // Dimensions — Width × Height
// // // ─────────────────────────────────────────────────────────────────────────
// //
// // class _DimensionsRow extends StatelessWidget {
// //   const _DimensionsRow({
// //     required this.width,
// //     required this.height,
// //     required this.onWidthChanged,
// //     required this.onHeightChanged,
// //   });
// //
// //   final String width;
// //   final String height;
// //   final ValueChanged<String> onWidthChanged;
// //   final ValueChanged<String> onHeightChanged;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       children: [
// //         Expanded(
// //           child: _TextInput(
// //             hint: ListProductData.widthHint,
// //             value: width,
// //             onChanged: onWidthChanged,
// //           ),
// //         ),
// //         Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 10),
// //           child: Text(
// //             '×',
// //             style: KolekText.sans(
// //               size: 16,
// //               color: AppearancePage.muted(context),
// //             ),
// //           ),
// //         ),
// //         Expanded(
// //           child: _TextInput(
// //             hint: ListProductData.heightHint,
// //             value: height,
// //             onChanged: onHeightChanged,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// //
// // // ─────────────────────────────────────────────────────────────────────────
// // // Next button — disabled until required fields are filled
// // // ─────────────────────────────────────────────────────────────────────────
// //
// // class _NextButton extends StatelessWidget {
// //   const _NextButton({required this.enabled});
// //
// //   final bool enabled;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       width: double.infinity,
// //       height: 52,
// //       child: FilledButton(
// //         onPressed: enabled
// //             ? () => context
// //             .read<ListProductBloc>()
// //             .add(const ListProductSubmitted())
// //             : null,
// //         style: FilledButton.styleFrom(
// //           backgroundColor: KolekColors.blue600,
// //           disabledBackgroundColor:
// //           KolekColors.blue600.withValues(alpha: 0.35),
// //           foregroundColor: Colors.white,
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(8),
// //           ),
// //           textStyle: KolekText.sans(
// //             size: 15,
// //             weight: FontWeight.w600,
// //           ),
// //         ),
// //         child: const Text(ListProductData.nextLabel),
// //       ),
// //     );
// //   }
// // }
// //
// // class _SaveDraftLink extends StatelessWidget {
// //   const _SaveDraftLink();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: GestureDetector(
// //         onTap: () => context
// //             .read<ListProductBloc>()
// //             .add(const ListProductDraftSaved()),
// //         behavior: HitTestBehavior.opaque,
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
// //           child: Text(
// //             ListProductData.draftLabel,
// //             style: KolekText.sans(
// //               size: 13,
// //               weight: FontWeight.w500,
// //               color: AppearancePage.muted(context),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
//
//
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../../screens/appearance/appearance_page.dart';
// import '../../../theme/kolek_colors.dart';
// import '../../../widgets/kolek_widgets.dart';
// import '../bloc/list_product_bloc.dart';
// import '../bloc/list_product_event.dart';
// import '../bloc/list_product_state.dart';
// import '../data/list_product_data.dart';
//
// class ListProductScreen extends StatefulWidget {
//   const ListProductScreen({super.key});
//
//   @override
//   State<ListProductScreen> createState() => _ListProductScreenState();
// }
//
// class _ListProductScreenState extends State<ListProductScreen> {
//   // Controllers live for the lifetime of the screen — created once,
//   // disposed once. Their text is the field's own source of truth;
//   // the bloc just tracks the same values for validation and submission.
//   final _titleCtrl = TextEditingController();
//   final _artistCtrl = TextEditingController();
//   final _yearCtrl = TextEditingController();
//   final _widthCtrl = TextEditingController();
//   final _heightCtrl = TextEditingController();
//
//   @override
//   void dispose() {
//     _titleCtrl.dispose();
//     _artistCtrl.dispose();
//     _yearCtrl.dispose();
//     _widthCtrl.dispose();
//     _heightCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppearancePage.background(context),
//       body: SafeArea(
//         child: BlocListener<ListProductBloc, ListProductState>(
//           listenWhen: (prev, next) =>
//           !prev.submitting && next.submitting,
//           listener: (context, state) {
//             // TODO: navigate to the next step once it exists.
//           },
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               const _AppBar(),
//               const _HeroSection(),
//               const SizedBox(height: 12),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // ── Photos: rebuilds only when the photo list changes ──
//                     BlocSelector<ListProductBloc, ListProductState,
//                         ({List<String> photos, bool canAdd})>(
//                       selector: (s) =>
//                       (photos: s.photos, canAdd: s.canAddPhoto),
//                       builder: (context, data) => _PhotosSection(
//                         photos: data.photos,
//                         canAddPhoto: data.canAdd,
//                       ),
//                     ),
//                     const SizedBox(height: 22),
//
//                     // ── Title ──────────────────────────────────────────
//                     const _FieldLabel(ListProductData.titleLabel),
//                     const SizedBox(height: 8),
//                     _TextInput(
//                       controller: _titleCtrl,
//                       hint: ListProductData.titleHint,
//                       maxLength: ListProductData.titleMaxLength,
//                       onChanged: (v) => context
//                           .read<ListProductBloc>()
//                           .add(ListProductTitleChanged(v)),
//                     ),
//                     const SizedBox(height: 18),
//
//                     // ── Artist ─────────────────────────────────────────
//                     const _FieldLabel(ListProductData.artistLabel),
//                     const SizedBox(height: 8),
//                     _TextInput(
//                       controller: _artistCtrl,
//                       hint: ListProductData.artistHint,
//                       maxLength: ListProductData.artistMaxLength,
//                       onChanged: (v) => context
//                           .read<ListProductBloc>()
//                           .add(ListProductArtistChanged(v)),
//                     ),
//                     const SizedBox(height: 18),
//
//                     // ── Year ───────────────────────────────────────────
//                     const _FieldLabel(ListProductData.yearLabel),
//                     const SizedBox(height: 8),
//                     _TextInput(
//                       controller: _yearCtrl,
//                       hint: ListProductData.yearHint,
//                       onChanged: (v) => context
//                           .read<ListProductBloc>()
//                           .add(ListProductYearChanged(v)),
//                     ),
//                     const SizedBox(height: 18),
//
//                     // ── Category: rebuilds only when category changes ──
//                     const _FieldLabel(ListProductData.categoryLabel),
//                     const SizedBox(height: 8),
//                     BlocSelector<ListProductBloc, ListProductState, String?>(
//                       selector: (s) => s.category,
//                       builder: (context, category) => _CategoryDropdown(
//                         value: category,
//                         onSelected: (v) => context
//                             .read<ListProductBloc>()
//                             .add(ListProductCategoryChanged(v)),
//                       ),
//                     ),
//                     const SizedBox(height: 18),
//
//                     // ── Dimensions ─────────────────────────────────────
//                     const _FieldLabel(ListProductData.dimensionsLabel),
//                     const SizedBox(height: 8),
//                     _DimensionsRow(
//                       widthCtrl: _widthCtrl,
//                       heightCtrl: _heightCtrl,
//                       onWidthChanged: (v) => context
//                           .read<ListProductBloc>()
//                           .add(ListProductWidthChanged(v)),
//                       onHeightChanged: (v) => context
//                           .read<ListProductBloc>()
//                           .add(ListProductHeightChanged(v)),
//                     ),
//                     const SizedBox(height: 28),
//
//                     // ── Next: rebuilds only when canProceed flips ──────
//                     BlocSelector<ListProductBloc, ListProductState, bool>(
//                       selector: (s) => s.canProceed,
//                       builder: (context, enabled) =>
//                           _NextButton(enabled: enabled),
//                     ),
//                     const SizedBox(height: 14),
//                     const _SaveDraftLink(),
//                     const SizedBox(height: 24),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────
// // App bar
// // ─────────────────────────────────────────────────────────────────────────
//
// class _AppBar extends StatelessWidget {
//   const _AppBar();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 10, 14, 4),
//       child: Row(
//         children: [
//           SvgPicture.asset(
//             ListProductData.logoAsset,
//             height: 26,
//             fit: BoxFit.contain,
//           ),
//           const Spacer(),
//           GestureDetector(
//             onTap: () => Navigator.of(context).pop(),
//             child: Container(
//               width: 30,
//               height: 30,
//               decoration: BoxDecoration(
//                 color: AppearancePage.foreground(context),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.close,
//                 size: 16,
//                 color: AppearancePage.background(context),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────
// // Hero
// // ─────────────────────────────────────────────────────────────────────────
//
// class _HeroSection extends StatelessWidget {
//   const _HeroSection();
//
//   @override
//   Widget build(BuildContext context) {
//     final fg = AppearancePage.foreground(context);
//
//     return SizedBox(
//       height: 240,
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Positioned(
//             left: 16,
//             top: 12,
//             right: 140,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   ListProductData.heading,
//                   style: KolekText.sans(
//                     size: 44,
//                     weight: FontWeight.w700,
//                     height: 1.02,
//                     letterSpacing: -1.2,
//                     color: fg,
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 Container(width: 26, height: 4, color: fg),
//                 const SizedBox(height: 14),
//                 Text(
//                   ListProductData.subtext,
//                   style: KolekText.mono(
//                     size: 12,
//                     weight: FontWeight.w400,
//                     height: 1.55,
//                     color: fg,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             right: -28,
//             top: 0,
//             bottom: 0,
//             child: Image.asset(
//               ListProductData.heroAsset,
//               height: 235,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────
// // Photos
// // ─────────────────────────────────────────────────────────────────────────
//
// class _PhotosSection extends StatelessWidget {
//   const _PhotosSection({
//     required this.photos,
//     required this.canAddPhoto,
//   });
//
//   final List<String> photos;
//   final bool canAddPhoto;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             const _FieldLabel(ListProductData.photosLabel),
//             const Spacer(),
//             Text(
//               '${photos.length}/${ListProductData.maxPhotos}',
//               style: KolekText.mono(
//                 size: 11,
//                 color: AppearancePage.muted(context),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         SizedBox(
//           height: 82,
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             itemCount: _slotCount,
//             separatorBuilder: (_, _) => const SizedBox(width: 8),
//             itemBuilder: (context, index) {
//               if (index < photos.length) {
//                 return _PhotoTile(
//                   asset: photos[index],
//                   onRemove: () => context
//                       .read<ListProductBloc>()
//                       .add(ListProductPhotoRemoved(index)),
//                 );
//               }
//               if (index == photos.length && canAddPhoto) {
//                 return _AddPhotoTile(
//                   onTap: () => context
//                       .read<ListProductBloc>()
//                       .add(const ListProductPhotoAdded()),
//                 );
//               }
//               return const _EmptyPhotoTile();
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   /// Photos + optional add tile, padded to a minimum of four slots so the
//   /// row always looks populated.
//   int get _slotCount {
//     final total = photos.length + (canAddPhoto ? 1 : 0);
//     return total < 4 ? 4 : total;
//   }
// }
//
// class _PhotoTile extends StatelessWidget {
//   const _PhotoTile({required this.asset, required this.onRemove});
//
//   final String asset;
//   final VoidCallback onRemove;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 76,
//       height: 82,
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.asset(
//               asset,
//               width: 76,
//               height: 82,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned(
//             top: -6,
//             right: -6,
//             child: GestureDetector(
//               onTap: onRemove,
//               child: Container(
//                 width: 22,
//                 height: 22,
//                 decoration: BoxDecoration(
//                   color: AppearancePage.foreground(context),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.close,
//                   size: 12,
//                   color: AppearancePage.background(context),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _AddPhotoTile extends StatelessWidget {
//   const _AddPhotoTile({required this.onTap});
//
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     final fg = AppearancePage.foreground(context);
//     final muted = AppearancePage.muted(context);
//     final line = AppearancePage.line(context);
//
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 76,
//         height: 82,
//         decoration: BoxDecoration(
//           color: AppearancePage.field(context),
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: line),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.add, size: 22, color: fg),
//             const SizedBox(height: 6),
//             Text(
//               ListProductData.addPhotosLabel,
//               textAlign: TextAlign.center,
//               style: KolekText.mono(
//                 size: 9,
//                 color: muted,
//                 height: 1.15,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _EmptyPhotoTile extends StatelessWidget {
//   const _EmptyPhotoTile();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 76,
//       height: 82,
//       decoration: BoxDecoration(
//         color: AppearancePage.field(context),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: AppearancePage.line(context)),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────
// // Field label
// // ─────────────────────────────────────────────────────────────────────────
//
// class _FieldLabel extends StatelessWidget {
//   const _FieldLabel(this.text);
//
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: KolekText.sans(
//         size: 13,
//         weight: FontWeight.w500,
//         color: AppearancePage.foreground(context),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────
// // Text input
// // ─────────────────────────────────────────────────────────────────────────
//
// /// Text field driven by an external [controller]. The character counter
// /// rebuilds on its own via [ValueListenableBuilder] — the rest of the
// /// widget doesn't re-render on each keystroke.
// class _TextInput extends StatelessWidget {
//   const _TextInput({
//     required this.controller,
//     required this.hint,
//     required this.onChanged,
//     this.maxLength,
//   });
//
//   final TextEditingController controller;
//   final String hint;
//   final ValueChanged<String> onChanged;
//   final int? maxLength;
//
//   @override
//   Widget build(BuildContext context) {
//     final fg = AppearancePage.foreground(context);
//     final muted = AppearancePage.muted(context);
//     final line = AppearancePage.line(context);
//     final field = AppearancePage.field(context);
//
//     return TextField(
//       controller: controller,
//       onChanged: onChanged,
//       style: KolekText.sans(size: 14, color: fg),
//       cursorColor: KolekColors.blue600,
//       decoration: InputDecoration(
//         isDense: true,
//         hintText: hint,
//         hintStyle: KolekText.sans(size: 14, color: muted),
//         suffix: maxLength == null
//             ? null
//             : ValueListenableBuilder<TextEditingValue>(
//           valueListenable: controller,
//           builder: (context, value, _) => Text(
//             '${value.text.length}/$maxLength',
//             style: KolekText.mono(size: 11, color: muted),
//           ),
//         ),
//         filled: true,
//         fillColor: field,
//         contentPadding:
//         const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: line),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: line),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: KolekColors.blue600, width: 1.2),
//         ),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────
// // Category dropdown
// // ─────────────────────────────────────────────────────────────────────────
//
// class _CategoryDropdown extends StatelessWidget {
//   const _CategoryDropdown({
//     required this.value,
//     required this.onSelected,
//   });
//
//   final String? value;
//   final ValueChanged<String> onSelected;
//
//   @override
//   Widget build(BuildContext context) {
//     final fg = AppearancePage.foreground(context);
//     final muted = AppearancePage.muted(context);
//     final line = AppearancePage.line(context);
//     final field = AppearancePage.field(context);
//
//     final display = value ?? ListProductData.categoryHint;
//     final displayColor = value == null ? muted : fg;
//
//     return PopupMenuButton<String>(
//       tooltip: '',
//       padding: EdgeInsets.zero,
//       position: PopupMenuPosition.under,
//       color: AppearancePage.menu(context),
//       elevation: 8,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//         side: BorderSide(color: line),
//       ),
//       onSelected: onSelected,
//       itemBuilder: (context) => [
//         for (final category in ListProductData.categories)
//           PopupMenuItem<String>(
//             value: category,
//             height: 44,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 category,
//                 style: KolekText.sans(size: 14, color: fg),
//               ),
//             ),
//           ),
//       ],
//       child: Container(
//         height: 48,
//         padding: const EdgeInsets.symmetric(horizontal: 14),
//         decoration: BoxDecoration(
//           color: field,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: line),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 display,
//                 style: KolekText.sans(size: 14, color: displayColor),
//               ),
//             ),
//             Icon(
//               Icons.keyboard_arrow_down,
//               size: 20,
//               color: AppearancePage.icon(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────
// // Dimensions row
// // ─────────────────────────────────────────────────────────────────────────
//
// class _DimensionsRow extends StatelessWidget {
//   const _DimensionsRow({
//     required this.widthCtrl,
//     required this.heightCtrl,
//     required this.onWidthChanged,
//     required this.onHeightChanged,
//   });
//
//   final TextEditingController widthCtrl;
//   final TextEditingController heightCtrl;
//   final ValueChanged<String> onWidthChanged;
//   final ValueChanged<String> onHeightChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Expanded(
//           child: _TextInput(
//             controller: widthCtrl,
//             hint: ListProductData.widthHint,
//             onChanged: onWidthChanged,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Text(
//             '×',
//             style: KolekText.sans(
//               size: 16,
//               color: AppearancePage.muted(context),
//             ),
//           ),
//         ),
//         Expanded(
//           child: _TextInput(
//             controller: heightCtrl,
//             hint: ListProductData.heightHint,
//             onChanged: onHeightChanged,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────
// // Next button + Save draft link
// // ─────────────────────────────────────────────────────────────────────────
//
// class _NextButton extends StatelessWidget {
//   const _NextButton({required this.enabled});
//
//   final bool enabled;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 52,
//       child: FilledButton(
//         onPressed: enabled
//             ? () => context
//             .read<ListProductBloc>()
//             .add(const ListProductSubmitted())
//             : null,
//         style: FilledButton.styleFrom(
//           backgroundColor: KolekColors.blue600,
//           disabledBackgroundColor:
//           KolekColors.blue600.withValues(alpha: 0.35),
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           textStyle: KolekText.sans(size: 15, weight: FontWeight.w600),
//         ),
//         child: const Text(ListProductData.nextLabel),
//       ),
//     );
//   }
// }
//
// class _SaveDraftLink extends StatelessWidget {
//   const _SaveDraftLink();
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: GestureDetector(
//         onTap: () => context
//             .read<ListProductBloc>()
//             .add(const ListProductDraftSaved()),
//         behavior: HitTestBehavior.opaque,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//           child: Text(
//             ListProductData.draftLabel,
//             style: KolekText.sans(
//               size: 13,
//               weight: FontWeight.w500,
//               color: AppearancePage.muted(context),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }















import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/list_product_bloc.dart';
import '../bloc/list_product_event.dart';
import '../bloc/list_product_state.dart';
import '../data/list_product_data.dart';
import 'gallery_picker_sheet.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  final _titleCtrl = TextEditingController();
  final _artistCtrl = TextEditingController();
  final _yearCtrl = TextEditingController();
  final _widthCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _artistCtrl.dispose();
    _yearCtrl.dispose();
    _widthCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  /// Opens the gallery modal and appends any picked photos to the form.
  Future<void> _openGallery() async {
    final bloc = context.read<ListProductBloc>();
    final remaining =
        ListProductData.maxPhotos - bloc.state.photos.length;
    if (remaining <= 0) return;

    final paths = await GalleryPickerSheet.show(
      context,
      maxSelectable: remaining,
    );

    if (!mounted || paths == null || paths.isEmpty) return;

    for (final path in paths) {
      bloc.add(ListProductPhotoAdded(path: path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: BlocListener<ListProductBloc, ListProductState>(
          listenWhen: (prev, next) =>
          !prev.submitting && next.submitting,
          listener: (context, state) {
            // TODO: navigate to the next step once it exists.
          },
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const _AppBar(),
              const _HeroSection(),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Photos ──────────────────────────────────────
                    BlocSelector<ListProductBloc, ListProductState,
                        ({List<String> photos, bool canAdd})>(
                      selector: (s) =>
                      (photos: s.photos, canAdd: s.canAddPhoto),
                      builder: (context, data) => _PhotosSection(
                        photos: data.photos,
                        canAddPhoto: data.canAdd,
                        onAddPhoto: _openGallery,
                      ),
                    ),
                    const SizedBox(height: 22),

                    // ── Title ───────────────────────────────────────
                    const _FieldLabel(ListProductData.titleLabel),
                    const SizedBox(height: 8),
                    _TextInput(
                      controller: _titleCtrl,
                      hint: ListProductData.titleHint,
                      maxLength: ListProductData.titleMaxLength,
                      onChanged: (v) => context
                          .read<ListProductBloc>()
                          .add(ListProductTitleChanged(v)),
                    ),
                    const SizedBox(height: 18),

                    // ── Artist ──────────────────────────────────────
                    const _FieldLabel(ListProductData.artistLabel),
                    const SizedBox(height: 8),
                    _TextInput(
                      controller: _artistCtrl,
                      hint: ListProductData.artistHint,
                      maxLength: ListProductData.artistMaxLength,
                      onChanged: (v) => context
                          .read<ListProductBloc>()
                          .add(ListProductArtistChanged(v)),
                    ),
                    const SizedBox(height: 18),

                    // ── Year ────────────────────────────────────────
                    const _FieldLabel(ListProductData.yearLabel),
                    const SizedBox(height: 8),
                    _TextInput(
                      controller: _yearCtrl,
                      hint: ListProductData.yearHint,
                      onChanged: (v) => context
                          .read<ListProductBloc>()
                          .add(ListProductYearChanged(v)),
                    ),
                    const SizedBox(height: 18),

                    // ── Category ────────────────────────────────────
                    const _FieldLabel(ListProductData.categoryLabel),
                    const SizedBox(height: 8),
                    BlocSelector<ListProductBloc, ListProductState, String?>(
                      selector: (s) => s.category,
                      builder: (context, category) => _CategoryDropdown(
                        value: category,
                        onSelected: (v) => context
                            .read<ListProductBloc>()
                            .add(ListProductCategoryChanged(v)),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // ── Dimensions ──────────────────────────────────
                    const _FieldLabel(ListProductData.dimensionsLabel),
                    const SizedBox(height: 8),
                    _DimensionsRow(
                      widthCtrl: _widthCtrl,
                      heightCtrl: _heightCtrl,
                      onWidthChanged: (v) => context
                          .read<ListProductBloc>()
                          .add(ListProductWidthChanged(v)),
                      onHeightChanged: (v) => context
                          .read<ListProductBloc>()
                          .add(ListProductHeightChanged(v)),
                    ),
                    const SizedBox(height: 28),

                    // ── Next ────────────────────────────────────────
                    BlocSelector<ListProductBloc, ListProductState, bool>(
                      selector: (s) => s.canProceed,
                      builder: (context, enabled) =>
                          _NextButton(enabled: enabled),
                    ),
                    const SizedBox(height: 14),
                    const _SaveDraftLink(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// App bar
// ─────────────────────────────────────────────────────────────────────────

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 14, 4),
      child: Row(
        children: [
          SvgPicture.asset(
            ListProductData.logoAsset,
            height: 26,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppearancePage.foreground(context),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 16,
                color: AppearancePage.background(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Hero
// ─────────────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);

    return SizedBox(
      height: 240,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 16,
            top: 12,
            right: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ListProductData.heading,
                  style: KolekText.sans(
                    size: 44,
                    weight: FontWeight.w700,
                    height: 1.02,
                    letterSpacing: -1.2,
                    color: fg,
                  ),
                ),
                const SizedBox(height: 14),
                Container(width: 26, height: 4, color: fg),
                const SizedBox(height: 14),
                Text(
                  ListProductData.subtext,
                  style: KolekText.mono(
                    size: 12,
                    weight: FontWeight.w400,
                    height: 1.55,
                    color: fg,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -28,
            top: 0,
            bottom: 0,
            child: Image.asset(
              ListProductData.heroAsset,
              height: 235,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Photos
// ─────────────────────────────────────────────────────────────────────────

class _PhotosSection extends StatelessWidget {
  const _PhotosSection({
    required this.photos,
    required this.canAddPhoto,
    required this.onAddPhoto,
  });

  final List<String> photos;
  final bool canAddPhoto;
  final VoidCallback onAddPhoto;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const _FieldLabel(ListProductData.photosLabel),
            const Spacer(),
            Text(
              '${photos.length}/${ListProductData.maxPhotos}',
              style: KolekText.mono(
                size: 11,
                color: AppearancePage.muted(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 82,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _slotCount,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              if (index < photos.length) {
                return _PhotoTile(
                  path: photos[index],
                  onRemove: () => context
                      .read<ListProductBloc>()
                      .add(ListProductPhotoRemoved(index)),
                );
              }
              if (index == photos.length && canAddPhoto) {
                return _AddPhotoTile(onTap: onAddPhoto);
              }
              return const _EmptyPhotoTile();
            },
          ),
        ),
      ],
    );
  }

  int get _slotCount {
    final total = photos.length + (canAddPhoto ? 1 : 0);
    return total < 4 ? 4 : total;
  }
}

/// Photo tile that renders either an `assets/...` image or a file path
/// returned by the gallery picker. Uses `Image.file` for absolute paths
/// and `Image.asset` for bundled assets.
class _PhotoTile extends StatelessWidget {
  const _PhotoTile({required this.path, required this.onRemove});

  final String path;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      height: 82,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: _PhotoImage(path: path, width: 76, height: 82),
          ),
          Positioned(
            top: -6,
            right: -6,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: AppearancePage.foreground(context),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 12,
                  color: AppearancePage.background(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Renders a photo from either a bundled asset or a file-system path.
///
/// Bundled assets start with `assets/`. Anything else is treated as a
/// file path returned by the gallery picker.
class _PhotoImage extends StatelessWidget {
  const _PhotoImage({
    required this.path,
    required this.width,
    required this.height,
  });

  final String path;
  final double width;
  final double height;

  bool get _isAsset => path.startsWith('assets/');

  @override
  Widget build(BuildContext context) {
    if (_isAsset) {
      return Image.asset(
        path,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      File(path),
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => ColoredBox(
        color: AppearancePage.field(context),
        child: Icon(
          Icons.broken_image_outlined,
          color: AppearancePage.muted(context),
        ),
      ),
    );
  }
}

class _AddPhotoTile extends StatelessWidget {
  const _AddPhotoTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final muted = AppearancePage.muted(context);
    final line = AppearancePage.line(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 76,
        height: 82,
        decoration: BoxDecoration(
          color: AppearancePage.field(context),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: line),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 22, color: fg),
            const SizedBox(height: 6),
            Text(
              ListProductData.addPhotosLabel,
              textAlign: TextAlign.center,
              style: KolekText.mono(
                size: 9,
                color: muted,
                height: 1.15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyPhotoTile extends StatelessWidget {
  const _EmptyPhotoTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 82,
      decoration: BoxDecoration(
        color: AppearancePage.field(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppearancePage.line(context)),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Field label
// ─────────────────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: KolekText.sans(
        size: 13,
        weight: FontWeight.w500,
        color: AppearancePage.foreground(context),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Text input
// ─────────────────────────────────────────────────────────────────────────

class _TextInput extends StatelessWidget {
  const _TextInput({
    required this.controller,
    required this.hint,
    required this.onChanged,
    this.maxLength,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final muted = AppearancePage.muted(context);
    final line = AppearancePage.line(context);
    final field = AppearancePage.field(context);

    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: KolekText.sans(size: 14, color: fg),
      cursorColor: KolekColors.blue600,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: KolekText.sans(size: 14, color: muted),
        suffix: maxLength == null
            ? null
            : ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) => Text(
            '${value.text.length}/$maxLength',
            style: KolekText.mono(size: 11, color: muted),
          ),
        ),
        filled: true,
        fillColor: field,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: KolekColors.blue600, width: 1.2),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Category dropdown
// ─────────────────────────────────────────────────────────────────────────

class _CategoryDropdown extends StatelessWidget {
  const _CategoryDropdown({
    required this.value,
    required this.onSelected,
  });

  final String? value;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final muted = AppearancePage.muted(context);
    final line = AppearancePage.line(context);
    final field = AppearancePage.field(context);

    final display = value ?? ListProductData.categoryHint;
    final displayColor = value == null ? muted : fg;

    return PopupMenuButton<String>(
      tooltip: '',
      padding: EdgeInsets.zero,
      position: PopupMenuPosition.under,
      color: AppearancePage.menu(context),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: line),
      ),
      onSelected: onSelected,
      itemBuilder: (context) => [
        for (final category in ListProductData.categories)
          PopupMenuItem<String>(
            value: category,
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                category,
                style: KolekText.sans(size: 14, color: fg),
              ),
            ),
          ),
      ],
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: field,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: line),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                display,
                style: KolekText.sans(size: 14, color: displayColor),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: AppearancePage.icon(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Dimensions row
// ─────────────────────────────────────────────────────────────────────────

class _DimensionsRow extends StatelessWidget {
  const _DimensionsRow({
    required this.widthCtrl,
    required this.heightCtrl,
    required this.onWidthChanged,
    required this.onHeightChanged,
  });

  final TextEditingController widthCtrl;
  final TextEditingController heightCtrl;
  final ValueChanged<String> onWidthChanged;
  final ValueChanged<String> onHeightChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _TextInput(
            controller: widthCtrl,
            hint: ListProductData.widthHint,
            onChanged: onWidthChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '×',
            style: KolekText.sans(
              size: 16,
              color: AppearancePage.muted(context),
            ),
          ),
        ),
        Expanded(
          child: _TextInput(
            controller: heightCtrl,
            hint: ListProductData.heightHint,
            onChanged: onHeightChanged,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Next button + Save draft link
// ─────────────────────────────────────────────────────────────────────────

class _NextButton extends StatelessWidget {
  const _NextButton({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: enabled
            ? () => context
            .read<ListProductBloc>()
            .add(const ListProductSubmitted())
            : null,
        style: FilledButton.styleFrom(
          backgroundColor: KolekColors.blue600,
          disabledBackgroundColor:
          KolekColors.blue600.withValues(alpha: 0.35),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: KolekText.sans(size: 15, weight: FontWeight.w600),
        ),
        child: const Text(ListProductData.nextLabel),
      ),
    );
  }
}

class _SaveDraftLink extends StatelessWidget {
  const _SaveDraftLink();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => context
            .read<ListProductBloc>()
            .add(const ListProductDraftSaved()),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            ListProductData.draftLabel,
            style: KolekText.sans(
              size: 13,
              weight: FontWeight.w500,
              color: AppearancePage.muted(context),
            ),
          ),
        ),
      ),
    );
  }
}