import React, {Component} from 'react';
import {View, Text, Image, AppRegistry} from 'react-native';
import WrapperView from './wrapper_view';

export default class Cell extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    data = this.props.data;
    return (
      <WrapperView cellIndex={data.index} style={{
          backgroundColor: 'cyan',
          margin: 5, flex: 1,
          flexDirection: 'row',
          justifyContent: 'space-between'}}>
        <Text style={{marginLeft: 20}}>{data.image}</Text>
        <Text style={{marginRight: 20}}>{data.name}</Text>
        <Text style={{marginRight: 20, width: 40}}>{data.index}</Text>
      </WrapperView>
    );
  }
}

AppRegistry.registerComponent('Cell', () => Cell);