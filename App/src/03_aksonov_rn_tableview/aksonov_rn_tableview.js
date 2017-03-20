import React, {Component} from 'react';
import {View} from 'react-native';
import Cell from '../cell';
import _ from 'lodash';
import TableView from 'react-native-tableview';

export default class AksonovRNTableview extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <View style={{flex: 1}}>
        <TableView style={{flex:1}} reactModuleForCell="Cell">
          <TableView.Section>
            {
              _.map(this.props.dataProvider.all(), (x) => {
                y = {...x, key: x.index};
                return (<TableView.Item {...y}/>);
              })
            }
          </TableView.Section>
        </TableView>
      </View>
    );
  }
}