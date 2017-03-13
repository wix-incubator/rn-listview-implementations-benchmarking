import React, {Component} from 'react';
import {View, ListView} from 'react-native';
import Cell from '../cell';

export default class RNRegularListView extends Component {
  constructor(props) {
    super(props);
    const ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
    this.state = {
      dataSource: ds.cloneWithRows(props.dataProvider.all())
    };
  }

  render() {
    return (
      <View style={{flex: 1, paddingTop: 22}}>
        <ListView
          dataSource={this.state.dataSource}
          renderRow={(rowData) => <Cell data={rowData}/>}
        />
      </View>
    );
  }
}