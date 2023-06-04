class Sort {
  bool byPriceDesc;
  bool byPriceAsc;
  bool byTimeDesc;
  bool byTimeAsc;
  Sort({
    this.byPriceAsc = true,
    this.byPriceDesc = false,
    this.byTimeAsc = false,
    this.byTimeDesc = false,
  });
}