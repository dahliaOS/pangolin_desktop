import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pangolin/utils/globals.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:pangolin/widgets/searchbar.dart';
import 'package:utopia_wm/wm.dart';
import 'package:provider/provider.dart';

class SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          hoverColor: Theme.of(context).cardColor.withOpacity(0.5),
          mouseCursor: SystemMouseCursors.click,
          onTap: () {
            WmAPI(context).pushOverlayEntry(DismissibleOverlayEntry(
                uniqueId: "search",
                content: Search(),
                duration: Duration(milliseconds: 200)));
          },
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Center(child: Icon(Icons.search, size: 20)),
          ),
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _focusNode = FocusNode();
    _focusNode.requestFocus();
    return Builder(builder: (context) {
      final _ac = context.watch<DismissibleOverlayEntry>().animation;
      return AnimatedBuilder(
          animation: _ac,
          builder: (context, child) {
            return Positioned(
              top: 64,
              left: sidePadding(context, 600),
              right: sidePadding(context, 600),
              child: BoxContainer(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                      offset:
                          Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ],
                ),
                useSystemOpacity: true,
                color: Theme.of(context).scaffoldBackgroundColor,
                customBorderRadius: BorderRadius.circular(10),
                width: 500,
                height: 320 * _ac.value,
                //margin: EdgeInsets.only(bottom: wmKey.currentState!.insets.bottom + 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 52,
                      child: Column(
                        children: [
                          BoxContainer(
                              //padding: EdgeInsets.symmetric(horizontal: 16),
                              color: Theme.of(context).scaffoldBackgroundColor,
                              useSystemOpacity: true,
                              height: 52,
                              child: Searchbar(
                                focusNode: _focusNode,
                                controller: TextEditingController(),
                                hint: '"Search Device, Apps and Web',
                                leading: Icon(Icons.search),
                                trailing: Icon(Icons.more_vert_rounded),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }
}
