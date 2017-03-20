import React, {Component} from 'react';
import {View} from 'react-native';
import {requireNativeComponent} from 'react-native';

const ReactFullyNativeTableView = requireNativeComponent('FullyNativeTableView');

export default class FullyNativeTableView extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <View {...this.props} style={{flex: 1, backgroundColor: 'green'}}>
        <ReactFullyNativeTableView
          {...this.props}
          style={{...this.props, flex: 1, backgroundColor: 'magenta'}}
          data={{rows: this.props.dataProvider.all()}}
        />
      </View>
    );
  }
}