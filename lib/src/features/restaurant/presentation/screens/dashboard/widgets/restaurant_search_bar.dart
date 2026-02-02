import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/config.dart';
import '../../../../../../shared_components/input/app_search_bar.dart';
import '../view_model/view_model.dart';

class RestaurantSearchBar extends StatefulWidget {
  const RestaurantSearchBar({super.key});

  @override
  State<RestaurantSearchBar> createState() => _RestaurantSearchBarState();
}

class _RestaurantSearchBarState extends State<RestaurantSearchBar> {
  late TextEditingController _controller;
  Timer? _debounce;

  static const _debounceDuration = Duration(seconds: 1);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onQueryChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(_debounceDuration, () {
      context.read<RestaurantProvider>().fetchRestaurants(query: value);
    });
  }

  void _onClear() {
    _debounce?.cancel();
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: AppSearchBar(
          padding: EdgeInsets.zero,
          controller: _controller,
          onChanged: _onQueryChanged,
          onClear: _onClear,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.greyShade600
              : AppColors.white,
        ),
      ),
    );
  }
}
