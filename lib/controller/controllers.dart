import 'dart:io';
import 'dart:math';

import 'package:borneo_toys/commons/global_functions.dart';
import 'package:borneo_toys/models/cart_model.dart';
import 'package:borneo_toys/models/category_model.dart';
import 'package:borneo_toys/models/invoice_model.dart';
import 'package:borneo_toys/models/product_model.dart';
import 'package:borneo_toys/pages/pages.dart';
import 'package:borneo_toys/services/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

part 'auth_controller.dart';
part 'product_controller.dart';
part 'cart_controller.dart';
part 'invoice_controller.dart';
