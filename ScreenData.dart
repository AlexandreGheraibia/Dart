class DataItem implements DataListScreen {
  @override
  String title;
  final String content;
  DataItem(this.title,this.content);
}

class DataListItem implements DataListScreen{
  @override
   String title;
    List<DataItem> listItemData;
    DataListItem(this.title, this.listItemData) ;
}

abstract class DataListScreen {
   String title;
}