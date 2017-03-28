import React, {Component} from 'react';
import {View, ListView, Text, Button} from 'react-native';
import ListViews from './list_views';
import _ from 'lodash';
import Navigation from 'react-native-navigation';
import DataProvider from './data_provider';
import SlowJSSimulatorView from './slow_js_simulator/slow_js_simulator_view';

export default class ListViewSelector extends Component {
  constructor(props) {
    super(props);
    const ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
    this.state = {
      dataProvider: new DataProvider(),
      dataSource: ds.cloneWithRows(_.map(ListViews, (x) => x.name))
    }
  }

  render() {
    return (
      <View style={{flex: 1, paddingTop: 22}}>
        <ListView dataSource={this.state.dataSource} renderRow={(rowData) =>
            <Button
            onPress={function(rowData) {
              this.props.navigator.push({
                screen: rowData,
                title: rowData,
                passProps: {
                  dataProvider: this.state.dataProvider
                }
              })
              }.bind(this, rowData)
            }
            title={rowData}
            />
          }/>
        <SlowJSSimulatorView style={{marginRight: 10}}/>
      </View>
    );
  }
}