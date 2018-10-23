import _ from 'lodash';
import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import { clearErrors } from 'atomic-fuel/libs/actions/errors';

const select = state => ({ errors: state.errors });

export class Errors extends React.Component {

  static propTypes = {
    clearErrors: PropTypes.func,
  }

  componentDidMount() {
    setTimeout(() => {
      this.props.clearErrors();
    }, 10000);
  }

  render() {
    if (_.isEmpty(this.props.errors)) {
      return null;
    }

    const errors = _(this.props.errors).map((error, index) => {
      if (error.response && error.response.text) {
        let message = error.response.text;
        try {
          const json = JSON.parse(error.response.text);
          message = json.message;
          if (json.canvas_authorization_required) {
            message = 'Please re-authorize Canvas.';
          }
        } catch (e) {
          // Throw away exception. String wasn't valid json.
        }

        return (
          <li key={index}>{message}</li>
        );
      } else if (error.message) {
        return (
          <li key={index}>{error.message}</li>
        );
      }
      return (
        <li key={index}>{error.toString()}</li>
      );
    }).flatten().value();
    return <ul>{errors}</ul>;
  }
}

export default connect(select, { clearErrors })(Errors);
