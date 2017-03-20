import React, {Component} from 'react';
import {WebView, Text} from 'react-native';
import _ from 'lodash';

export default class ListviewWebview extends Component {

  render() {
    const tableContent = _.map(this.props.dataProvider.all(), (item) => `
      <tr>
        <th>TBD image</th>
        <th>${item.name}</th>
        <th>${item.index}</th>
      </tr>
    `).join("")

    const table = `
      <table style="width:100%">
        ${tableContent}
      </table>
    `

    return (
      <WebView
        source={{html: table}}
      />
    );
  }
}