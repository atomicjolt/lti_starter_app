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
    }, 5000);
  }

  render() {
    if (_.isEmpty(this.props.errors)) {
      return null;
    }

    const errors = _.map(this.props.errors, (error) => {
      if (error.response && error.response.text) {
        let message = error.response.text;
        try {
          const json = JSON.parse(error.response.text);
          message = json.message;
        } catch (e) {
          // Throw away exception. String wasn't valid json.
        }
        return (
          <li>{message}</li>
        );
      }
      return (
        <li>{error.toString()}</li>
      );
    });
    return <ul>{errors}</ul>;
  }
}

export default connect(select, { clearErrors })(Errors);
