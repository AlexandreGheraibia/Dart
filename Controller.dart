import 'package:flutter/material.dart';
import 'package:flutter_music/DBManager.dart';
import 'package:flutter_music/DownLoad.dart';
import 'package:flutter_music/ScreenData.dart';
import 'package:flutter_music/NavigationView.dart';
import 'RoutePath.dart';


//router call it to parse path and get information from the routeProvider
class ControllerRouteInformationParser extends RouteInformationParser<RoutePath> {

  //send parsed information to the RouterDelegate
  @override
  Future<RoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
      return RoutePath.parsePath(Uri.parse(routeInformation.location));
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath path) {
      return RouteInformation(location: RoutePath.location(path));
  }

}

class ControllerRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
    final GlobalKey<NavigatorState> navigatorKey;
    bool _canDownload=true;
    bool  _waitDataLoadingCompleted = true;
    RoutePath _currentPath = RoutePath(null, null, false);
    List<DataListItem>coran;

  ControllerRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    LoadData();
  }

  Future<void> LoadData() async {
    DBManager dbManager= DBManager();
    await dbManager.init();
    await dbManager.getVerset().then((List<DataListItem> value) => _dataLoadingCompleted(value))
        .catchError((e) => []);
    await dbManager.close();
  }

  void _dataLoadingCompleted(List<DataListItem> value){
    this.coran = value;
    _waitDataLoadingCompleted =false;
    notifyListeners();
  }

  RoutePath get currentConfiguration {
   return _currentPath;
  }

  void _handleDataListScreenTapped(DataListScreen dataListScreen)
  {

    switch(dataListScreen.runtimeType)
    {
      case  DataItem:
        _currentPath.verset_id = coran[_currentPath.sourate_id].listItemData.indexOf(dataListScreen);
        break;
      case DataListItem:
        _currentPath.sourate_id = coran.indexOf(dataListScreen);
        break;
    }

    notifyListeners();
  }


   Page<dynamic> _mustDownload(){
      if(_canDownload){
        _canDownload=false;
       return MaterialPage(key: ValueKey('DownLoading'), child: DownLoadPage(downloadNotifier:  notifyListeners));

      }
      else
      return  ItemDataDetailsPage(
          itemData: coran[_currentPath.sourate_id].listItemData[_currentPath
              .verset_id]);
   }

   List<Page<dynamic>> pages() =>[
     if(_waitDataLoadingCompleted)
       MaterialPage(key: ValueKey('load'),
           child:LoadScreen()
       ),
     if(!_waitDataLoadingCompleted)
       MaterialPage(
        key: ValueKey('Sourates'),
        child: ListScreen<DataListItem>(
          title :" Coran ",
          itemsList: coran,
          onTapped: _handleDataListScreenTapped,
        ),
      ),
    if(_currentPath.isVersetPage)
      MaterialPage(
        key: ValueKey('Versets'),
        child:
          Stack(
              children: [
                Positioned(
                    top:0,
                    right:0,
                    width:370,
                    height:620,
                    child: ListScreen<DataItem>(
                    title : coran[_currentPath.sourate_id].title,
                    itemsList: coran[_currentPath.sourate_id].listItemData,
                    onTapped: _handleDataListScreenTapped
                    )
                ),

                Positioned(
                    bottom:0,
                    right:0,
                    width:400,
                    height:100,
                    child: Scaffold(body:Text("test"))
                )
              ],
              )
        ),
    if(_currentPath.isDetailsPage)
         _mustDownload()
       ,
    if(_currentPath.isUnknown)
      MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages:pages() ,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        // Update the list of pages
        if(_currentPath.isDetailsPage)
          _currentPath.verset_id = null;
        else if(_currentPath.isVersetPage){
          _currentPath.sourate_id = null;
        }
        _currentPath.isUnknown = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RoutePath path) async {
    final bool canDownload=true;
    if (path.isDetailsPage) {
      if (path.verset_id < 0 || path.verset_id > coran[_currentPath.sourate_id].listItemData.length - 1) {
        _currentPath.isUnknown = true;
        return;
      }

    }
    if (path.isVersetPage) {
      if (path.sourate_id < 0 || path.sourate_id> coran.length - 1) {
        _currentPath.isUnknown = true;
        return;
      }

    }
    _currentPath = path;

  }
}