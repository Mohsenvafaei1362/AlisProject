import 'package:local_notification_flutter_project/ui/screens/Register/Map/router/app_router.dart';
import 'package:flutter/material.dart';
// import 'package:point_app/router/app_router.dart';
import 'package:provider/provider.dart';
import '../providers/point_provider.dart';

class PointListScreen extends StatelessWidget {
  const PointListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<Ui_PointProvider>(context, listen: false).getData(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Ui_PointProvider>(
                child: const Center(
                  child: Text("اطلاعاتی یافت نشد"),
                ),
                builder: (ctx, data, child) => data.getPoints.isEmpty
                    ? child!
                    : ListView.builder(
                        itemBuilder: (ctx, index) => Dismissible(
                          key: Key(data.getPoints[index].id),
                          direction: DismissDirection.startToEnd,
                          confirmDismiss: (direction) async {
                            await Provider.of<Ui_PointProvider>(context,
                                    listen: false)
                                .DeleteById(data.getPoints[index].id);
                            return true;
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(data.getPoints[index].image),
                            ),
                            title: Text(data.getPoints[index].title),
                            subtitle:
                                Text(data.getPoints[index].location.address),
                            onTap: () => Navigator.of(context).pushNamed(
                                Ui_AppRouter.pointDetailsRoute,
                                arguments: data.getPoints[index].id),
                          ),
                        ),
                        itemCount: data.getPoints.length,
                      ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Ui_AppRouter.addPointRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
