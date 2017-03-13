import {Navigation} from 'react-native-navigation';
import ListViews from './list_views';
import ListViewSelector from './list_view_selector';

Navigation.registerComponent(ListViewSelector.name, () => ListViewSelector);
for(listView of ListViews) {
  Navigation.registerComponent(listView.name, () => listView);
}

Navigation.startSingleScreenApp({
  screen: {
    screen: ListViewSelector.name
  }
})