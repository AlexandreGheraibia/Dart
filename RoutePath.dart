class RoutePath {
   int sourate_id;
   int verset_id;
   bool isUnknown;

  RoutePath(this.sourate_id ,this.verset_id,this.isUnknown);

  RoutePath.unknown()
      : sourate_id = null,
        verset_id = null,
        isUnknown = true;

  bool get isSouratePage => sourate_id == null && verset_id == null;

  bool get isVersetPage => (sourate_id != null );

  bool get isDetailsPage => ( sourate_id != null && verset_id != null);

  static RoutePath parsePath(Uri uri)
  {
    // Handle '/'
    // Handle '/sourate'
    bool isKnow = false;
    int id, sub_id;
    if(uri.pathSegments.length < 2)
    {
      isKnow = (uri.pathSegments.length == 0 || uri.pathSegments[0] == 'sourate');
    }
    else
      {
        // Handle '/sourate/:id'
        if(uri.pathSegments.length == 2)
        {
          id = int.tryParse(uri.pathSegments[1]);
          isKnow = (uri.pathSegments[0] == 'sourate');
        }
        else
        {
          if(uri.pathSegments.length < 5)
          {
            id = int.tryParse(uri.pathSegments[1]);
            sub_id = uri.pathSegments.length == 3 ? null : int.tryParse(uri.pathSegments[3]);
            isKnow = ((uri.pathSegments[0] == 'sourate' && uri.pathSegments[2] == 'verset') && id != null);

          }
        }
    }

      return RoutePath(id, sub_id, !isKnow);
  }

  static String location(RoutePath path){
    if (path.isUnknown) {
      return '/404';
    }
    if (path.isVersetPage) {
      return '/sourate/${path.sourate_id}';
    }
    if (path.isSouratePage) {
      return '/sourate';
    }
    if (path.isDetailsPage) {
      return  '/sourate/${path.sourate_id}/verset/${path.verset_id}';
    }
  }

}