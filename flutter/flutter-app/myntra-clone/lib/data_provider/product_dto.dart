class ProductDto {
  final String imageUrl;
  final String name;
  final String description;
  final String price;
  final String mrpPrice;
  final String discountString;

  ProductDto(this.imageUrl, this.name, this.description, this.price,
      this.mrpPrice, this.discountString);
}
