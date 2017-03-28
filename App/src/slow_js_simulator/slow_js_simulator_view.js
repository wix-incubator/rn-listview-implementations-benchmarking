import React, {Component} from 'react';
import {View, Text, Slider} from 'react-native';
import SlowJSSimulator from './slow_js_simulator';

export default class SlowJSSimulatorView extends Component {
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
        <View style={{flexDirection: 'row'}}>
          <Text>
            Time interval:
          </Text>
          <Slider
            style={{flex: 1}}
            onValueChange={(value) => {
                SlowJSSimulator.setInterval(Math.min(1, 1.001 - value));
                this.forceUpdate();
              }}
          />
        </View>
        <View style={{flexDirection: 'row'}}>
          <Text>
            Bridge noise:
          </Text>
          <Slider
            style={{flex: 1}}
            onValueChange={(value) => {
                SlowJSSimulator.setChunkSize(Math.pow(10, value * 7) - 1);
                this.forceUpdate();
              }}
          />
        </View>
        <View style={{flexDirection: 'row'}}>
          <Text>
            Busy-wait:
          </Text>
          <Slider
            style={{flex: 1}}
            onValueChange={(value) => {
                SlowJSSimulator.setBusyWait(Math.pow(10, value * 9) - 1)
                this.forceUpdate();
              }}
          />
        </View>
        <Text>isActive: {SlowJSSimulator.isActive() ? 'YES' : 'NO'}</Text>
        <Text>timeInterval: {SlowJSSimulator.interval()}</Text>
        <Text>chunkSize: {this._formatBytes(SlowJSSimulator.chunkSize())}</Text>
        <Text>busyWait: {SlowJSSimulator.busyWait()}</Text>
        <Text>chunksReceived: {SlowJSSimulator.chunksReceived()}</Text>
        <Text>chunksSent: {SlowJSSimulator.chunksSent()}</Text>
        <Text>bytesReceived: {this._formatBytes(SlowJSSimulator.bytesReceived())}</Text>
        <Text>bytesSent: {this._formatBytes(SlowJSSimulator.bytesSent())}</Text>
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