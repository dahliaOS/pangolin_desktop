import 'dart:ui';

import 'package:flutter/material.dart';

class GraftKMGS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Text(
            _kmgs,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ));
  }
}

String _kmgs =
    '[42467]sb_user_approval: kTCCServiceSystemPolicyAllFiles satisifed by entitlement for pid 42467sb_user_approval: kTCCServiceSystemPolicyAllFiles for mdworker_shared [42467]sb_user_approval: kTCCServiceSystemPolicyAllFiles satisifed by entitlement for pid 42467sb_user_approval: kTCCServiceSystemPolicyAllFiles for mdworker_shared [42467]sb_user_approval: kTCCServiceSystemPolicyAllFiles satisifed by entitlement for pid 42467sb_user_approval: kTCCServiceSystemPolicyAllFiles for mdworker_shared [42467]sb_user_approval: kTCCServiceSystemPolicyAllFiles satisifed by entitlement for pid 42467unexpected session: 100000 uid: -1 requested by: 42479 AppleKeyStore: operation failed (pid: 42479 sel: 17 ret: e00002c2 -536870206, -1, 100000) unexpected session: 100000 uid: -1 requested by: 42479 AppleKeyStore: operation failed (pid: 42479 sel: 7 ret: e00002c2 -536870206, -1, 100000) sb_user_approval: kTCCServiceSystemPolicyAllFiles for mds [90]sb_user_approval: kTCCServiceSystemPolicyAllFiles satisifed by entitlement for pid 90sb_user_approval: kTCCServiceSystemPolicyAllFiles for mds [90]sb_user_approval: kTCCServiceSystemPolicyAllFiles satisifed by entitlement for pid 90sb_user_approval: kTCCServiceSystemPolicyAllFiles for mds [90]sb_user_approval: kTCCServiceSystemPolicyAllFiles satisifed by entitlement for pid 90sb_user_approval: kTCCServiceSystemPolicyAllFiles for mds [90]sb_user_approval: kTCCServiceSystemPolicyAllFiles satisifed by entitlement for pid 90sb_user_approval: kTCCServiceSystemPolicyAllFiles for mds [90]sb_user_approval: kTCCServiceSystemPolicyAllFiles satisifed by entitlement for pid 90sb_user_approval: kTCCServiceSystemPolicyAllFiles for mds [90]sb_user_approval: kTCCServiceSystemPolicyAllFiles satisifed by entitlement for pid 90sb_user_approval: kTCCServiceSystemPolicyAllFiles for mdworker_shared [42450]sb_user_approval: kTCCServiceSystemPolicyAllFiles satisifed by entitlement for pid 42450sb_user_approval: kTCCServiceSystemPolicyAllFiles for mdworker_shared [42450]';
