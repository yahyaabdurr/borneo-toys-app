import 'dart:io';
import 'package:borneo_toys/commons/utils.dart';
import 'package:borneo_toys/models/cart_model.dart';
import 'package:borneo_toys/models/invoice_model.dart';
import 'package:borneo_toys/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';
part 'auth_service.dart';
part 'product_service.dart';
part 'cart_service.dart';
part 'invoice_service.dart';
