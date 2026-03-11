import 'package:flutter/material.dart';

class OrderAddressField extends StatefulWidget {
  final TextEditingController controller;
  const OrderAddressField({super.key, required this.controller});

  @override
  State<OrderAddressField> createState() => _OrderAddressFieldState();
}

class _OrderAddressFieldState extends State<OrderAddressField> {
  @override
  void initState() {
    super.initState();
    // Добавляем прослушиватель, как в твоем примере
    widget.controller.addListener(_updateState);
  }

  void _updateState() {
    setState(() {}); // Перерисовываем, чтобы кнопка "Очистить" появлялась/исчезала
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Delivery Address',
        hintText: 'Enter city, street, house...',
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.location_on, color: Colors.redAccent),
        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => widget.controller.clear(),
        )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}