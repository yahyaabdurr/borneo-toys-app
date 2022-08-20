import 'dart:async';

import 'package:borneo_toys/commons/theme.dart';
import 'package:borneo_toys/controller/controllers.dart';
import 'package:borneo_toys/models/invoice_model.dart';
import 'package:borneo_toys/models/product_model.dart';
import 'package:borneo_toys/services/services.dart';
import 'package:borneo_toys/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../commons/global_functions.dart';

part 'splash_page.dart';
part 'login_page.dart';
part 'invoice_page.dart';
part 'about_page.dart';
part 'cart_page.dart';
part 'home_page.dart';
part 'reset_password_page.dart';
part 'products_page.dart';
