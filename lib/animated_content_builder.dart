// Copyright 2017 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

/// Builds some animated content.
/// [animation]'s range is from 0.0 to 1.0.
typedef Widget AnimatedContentBuilder(Animation<double> animation);
