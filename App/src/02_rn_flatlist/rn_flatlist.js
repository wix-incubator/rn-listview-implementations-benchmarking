import React, {Component} from 'react';
import {View, FlatList} from 'react-native';
import Cell from '../cell';
import _ from 'lodash';

export default class RNFlatList extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <View style={{flex: 1}}>
        <FlatList
          data={_.map(this.props.dataProvider.all(), (x) => {y = {...x, key: x.index}; return y;})}
          renderItem={({item}) => <Cell data={item}/>}
        />
      </View>
    );
  }
}