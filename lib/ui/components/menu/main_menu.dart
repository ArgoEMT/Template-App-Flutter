import 'package:flutter/material.dart';
import 'package:flutter_template/core/constants/route_paths.dart';

import '../../../core/view_models/components/menu/menu_view_model.dart';
import '../../shared/colors.dart';
import '../../shared/menu_item.dart';
import '../../shared/text_styles.dart';
import '../base_widget.dart';
import 'main_menu_commons.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with MainMenuCommons {
  var textColor = blackColor;

  Widget _buildUserDetail({
    required BuildContext context,
    required MenuViewModel model,
  }) {
    return Container(
      color: primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 26.0, top: 26),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 72,
                  width: 72,
                  margin: const EdgeInsets.only(
                    bottom: 14,
                    right: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: whiteColor.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: const Icon(
                        Icons.account_box_sharp,
                        size: 72,
                        color: blackColor,
                      )),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'UserName',
                        style: bigTextStyle,
                        overflow: TextOverflow.clip,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'user.email@email.fr',
                        style: normalTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Divider(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var routeName = ModalRoute.of(context).settings.name;
    return BaseWidget<MenuViewModel>(
      model: MenuViewModel(),
      builder: (context, model, child) {
        return Drawer(
          backgroundColor: whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // Important: Remove any padding from the ListView.
            children: [
              _buildUserDetail(context: context, model: model),
              Expanded(
                child: buildDrawerList(
                  context: context,
                  model: model,
                  textColor: textColor,
                ),
              ),
              const Divider(),
              buildTile(
                context: context,
                item: MenuItem(
                  icon: Icons.exit_to_app,
                  libelle: 'Déconnexion',
                  action: () {
                    // TODO: logout
                  },
                  routePaths: [RoutePaths.logout],
                ),
                leftPadding: 0,
                textColor: textColor,
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        );
      },
    );
  }
}
