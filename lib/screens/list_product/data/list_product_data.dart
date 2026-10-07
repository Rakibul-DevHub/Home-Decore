abstract final class ListProductData {
  // ── Assets ────────────────────────────────────────────────────────
  static const logoAsset = 'assets/icons/logo_withText.svg';
  static const heroAsset = 'assets/images/list_product.png';

  // ── Hero copy ─────────────────────────────────────────────────────
  static const heading = 'List a\nProduct.';
  static const subtext =
      'Present your art to the world.\nList it for sale or auction\non kolek';

  // ── Photos ────────────────────────────────────────────────────────
  static const photosLabel = 'Photos';
  static const maxPhotos = 10;
  static const addPhotosLabel = 'Add Photos\nor Videos';

  /// Cycle used for the demo — in a real build this would be replaced by
  /// an image picker returning real file paths.
  // static const samplePhotoPool = [
  //   'assets/images/img1.png',
  //   'assets/images/img2.png',
  //   'assets/images/img3.png',
  //   'assets/images/img4.png',
  //   'assets/images/img5.png',
  //   'assets/images/img6.png',
  // ];

  // ── Form fields ───────────────────────────────────────────────────
  static const titleLabel = 'Title';
  static const titleHint = 'e.g. Balance Stydy';
  static const titleMaxLength = 80;

  static const artistLabel = 'Artist';
  static const artistHint = 'e.g. Simon Albers';
  static const artistMaxLength = 80;

  static const yearLabel = 'Year';
  static const yearHint = 'e.g. 2024';

  static const categoryLabel = 'Category';
  static const categoryHint = 'e.g. Oil on Canvas';
  static const categories = [
    'Oil on Canvas',
    'Acrylic on Canvas',
    'Watercolour',
    'Mixed Media',
    'Digital Art',
    'Photography',
    'Sculpture',
    'Print',
  ];

  static const dimensionsLabel = 'Dimensions (Optional)';
  static const widthHint = 'Width (inch)';
  static const heightHint = 'Height (inch)';

  // ── Footer actions ────────────────────────────────────────────────
  static const nextLabel = 'Next';
  static const draftLabel = 'Save as Draft';
}