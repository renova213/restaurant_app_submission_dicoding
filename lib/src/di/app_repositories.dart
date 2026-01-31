import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/restaurant/restaurant.dart';

final appRepositories = <RepositoryProvider>[...restaurantRepositories];

final appCubits = <BlocProvider>[...restaurantCubits];
