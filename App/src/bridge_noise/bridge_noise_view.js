import React, {Component} from 'react';
import {View, Text, Slider} from 'react-native';
import BridgeNoise from './bridge_noise';

export default class BridgeNoiseView extends Component {
  constructor(props) {
    super(props);
    this._stateChanges = 0;

    setInterval(() => {
      this.setState({ stateChanges: this._stateChanges + 1 });
    }, 1000);
  }

  render() {
    return (
      <View {...props=this.props}>
        <Slider
          onValueChange={(value) => {
              BridgeNoise.setChunkSize(value * Math.pow(10, 7))
              if(BridgeNoise.isActive() && value === 0) {
                BridgeNoise.stop();
              }
              if(!BridgeNoise.isActive() && value > 0) {
                BridgeNoise.start();
              }
              this.forceUpdate();
            }}
        />
        <Text>isActive: {BridgeNoise.isActive() ? 'YES' : 'NO'}</Text>
        <Text>chunkSize: {this._formatBytes(BridgeNoise.chunkSize())}</Text>
        <Text>chunksReceived: {BridgeNoise.chunksReceived()}</Text>
        <Text>chunksSent: {BridgeNoise.chunksSent()}</Text>
        <Text>bytesReceived: {this._formatBytes(BridgeNoise.bytesReceived())}</Text>
        <Text>bytesSent: {this._formatBytes(BridgeNoise.bytesSent())}</Text>
      </View>
    );
  }

  _formatBytes(bytes,decimals) {
    if(bytes == 0) return '0 Bytes';
    var k = 1000,
        dm = decimals + 1 || 3,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
  }
}