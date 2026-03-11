class DeliveryModel {
  final String typeDeliveryName;
  final int timeDelivery;
  bool isSelected;

  DeliveryModel({
    required this.typeDeliveryName,
    required this.timeDelivery,
    required this.isSelected,
  });

  static List<DeliveryModel> getListDelivery() {
    return [
      DeliveryModel(
          typeDeliveryName: 'Курьерская доставка (в надежной упаковке):',
          timeDelivery: 24,
          isSelected: true),
      DeliveryModel(
          typeDeliveryName: 'Самовывоз из Vinyl Store (БЕСПЛАТНО)',
          timeDelivery: 0,
          isSelected: false),
      DeliveryModel(
          typeDeliveryName: 'Почта / СДЭК в другой город:',
          timeDelivery: 72,
          isSelected: false),
    ];
  }
}
