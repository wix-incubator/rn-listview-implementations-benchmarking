import React, { Component } from 'react';
import ReactNative, { View, requireNativeComponent } from 'react-native';
import StaticContainer from './static_container';
import _ from 'lodash';

const BindingListView = requireNativeComponent('BindingListView');
const BindingCell = requireNativeComponent('BindingListViewCell');

export default class BindingListViewReactWrapper extends Component {
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
      <BindingListView
        rows={this.props.rows}
        binding={binding}
        numRows={this.props.rows.length}
        rowHeight={this.props.rowHeight}
        style={this.props.style}
      >
        {poolChildren}
      </BindingListView>
    );
  }
}

class BindingRow extends Component {
  constructor(props) {
    super(props);
    this.bindings = {};
    this.state = {
      bindings: {}
    }
  }
  render() {
    return (
      <BindingCell bindings={this.state.bindings}>
        <StaticContainer>
          {
            this.props.renderItemTemplate((element, { id, toProp }) => {
              if (!toProp || !element) return;
              switch (element.constructor.displayName) {
                case 'Image':
                  element = getRenderedElement(element);
                  break;
              }
              if (toProp === 'children') {
                element = getFirstChild(element);
              }
              this.bindings[id] = {
                tag: ReactNative.findNodeHandle(element),
                prop: toProp,
                viewName: _.get(element, 'viewConfig.uiViewClassName')
              };
              this.setState({bindings: this.bindings});
            })
          }
        </StaticContainer>
      </BindingCell>
    );
  }
}

function getRenderedElement(element) {
  // may god help us, is there a better way?
  return _.get(element, '_reactInternalInstance._renderedComponent');
}

function getFirstChild(element) {
  // may god help us, is there a better way?
  const children = _.get(element, '_reactInternalInstance._renderedComponent._renderedChildren');
  if (_.size(children) == 0) return undefined;
  return _.head(_.toPairs(children))[1];
}