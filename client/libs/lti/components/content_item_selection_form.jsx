import _ from 'lodash';
import React from 'react';
import PropTypes from 'prop-types';

export default class ContentItemSelectionForm extends React.Component {

  static propTypes = {
    launchData : PropTypes.shape({}),
    contentItemReturnURL: PropTypes.string,
  }

  componentDidMount() {
    this.form.submit();
  }

  renderLaunchData() {
    return _.map(this.props.launchData, (value, key) => (
      <input key={key} type="hidden" value={value || ''} name={key} />
    ));
  }

  render() {
    const formStyle = { display: 'none' };
    return (
      <form
        ref={(ref) => { this.form = ref; }}
        action={this.props.contentItemReturnURL}
        style={formStyle}
        method="post"
        encType="application/x-www-form-urlencoded"
      >
        { this.renderLaunchData() }
        <button type="submit">Finish</button>
      </form>
    );
  }
}
