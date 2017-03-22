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
          backgroundColor: 'white',
          flex: 1,
          height: 27
          }}>
        <View style={{
          backgroundColor: 'cyan',
          flexDirection: 'row',
          justifyContent: 'space-between',
          marginTop: 1,
          height: 25,
          alignItems: 'center'
        }}>
          <Image style={{height: 25, width: 25}} source={{uri: "file://" + data.img_path}}/>
          <Text style={{}}>{data.name}</Text>
          <Text style={{width: 40, marginRight: 5, textAlign: 'right', fontFamily: 'Courier'}}>{data.index}</Text>
        </View>
      </WrapperView>
    );
  }
}

AppRegistry.registerComponent('Cell', () => Cell);