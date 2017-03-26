import BindingListView from './binding_list_view';
import React, {Component} from 'react';
import {View, Image, Text} from 'react-native';
import _ from 'lodash';

export default class BindingListViewWrapper extends Component {
  render() {
    const poolChildren = [];
    for (let i=0 ; i<this.props.poolSize ; i++) {
      const child = (
        <BindingRow key={i} renderItemTemplate={this.props.renderItemTemplate} />
      );
      poolChildren.push(child);
    }
    const binding = _.mapValues(_.keyBy(this.props.binding, (v) => v.id), (v) => v.toRowKey);
    return (
      <View style={{flex: 1}}>
        <BindingListView
          rows={_.map(this.props.dataProvider.all(), (x) => ({name: x.name, index: String(x.index), image: [{uri: x.img_path}]}))}
          binding={[
            { id: 'nameText', toRowKey: 'name' },
            { id: 'indexText', toRowKey: 'index' },
            { id: 'thumbnail', toRowKey: 'image'}
          ]}
          renderItemTemplate={this.renderItemTemplate_withImages.bind(this)}
          rowHeight={27}
          poolSize={20}
          style={{flex: 1}}
        />
        {poolChildren}
      </View>
    );
  }

  renderItemTemplate_withImages(bind) {
    return (
      <View style={{
          backgroundColor: 'white',
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
          <Image
            style={{height: 25, width: 25}}
            source={{uri: this.props.dataProvider.all()[0].img_path}}
            ref={(element) => bind(element, { id: 'thumbnail', toProp: 'source' })}
            />
          <Text
            style={{}}
            ref={(element) => bind(element, { id: 'nameText', toProp: 'children' })}
          >
            name
          </Text>
          <Text
            style={{width: 40, marginRight: 5, textAlign: 'right', fontFamily: 'Courier'}}
            ref={(element) => bind(element, { id: 'indexText', toProp: 'children' })}
          >
            index
          </Text>
        </View>
      </View>
    );
  }
}