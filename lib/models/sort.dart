class Sort {
  bool byPriceDesc;
  bool byPriceAsc;
  bool byTimeDesc;
  bool byTimeAsc;
  Sort({
    this.byPriceDesc = true,
    this.byPriceAsc = false,
    this.byTimeDesc = false,
    this.byTimeAsc = false,
  });
}