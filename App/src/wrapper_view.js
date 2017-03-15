import React, {Component} from 'react';
import {requireNativeComponent} from 'react-native';

class ReactWrapperView extends Component {
  render() {
    return <WrapperView {...this.props} />;
  }
}

ReactWrapperView.propTypes = {
  cellIndex: React.PropTypes.number
}

module.exports = requireNativeComponent('WrapperView', ReactWrapperView);