enum PaymentOption { cash, online }
enum DeliveryOption { delivery, takeout }

class CartOptions {
  DeliveryOption deliveryOption;
  PaymentOption paymentOption;

  String deliveryAddress;
}