class Sort {
  bool byPriceDesc;
  bool byPriceAsc;
  bool byTimeDesc;
  bool byTimeAsc;
  bool defaultSort;
  Sort({
    this.defaultSort = true,
    this.byPriceAsc = false,
    this.byPriceDesc = false,
    this.byTimeAsc = false,
    this.byTimeDesc = false,
  });

  get buttonText {
    if (defaultSort) {
      return 'مرتب‌سازی';
    } else if (byPriceAsc) {
      return 'ارزان ترین';
    } else if (byPriceDesc) {
      return 'گران ترین';
    } else if (byTimeAsc) {
      return 'زودترین';
    } else if (byTimeDesc) {
      return 'دیرترین';
    }
  }
}