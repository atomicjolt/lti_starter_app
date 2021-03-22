import React from 'react';
import PropTypes from 'prop-types';

export default class CatalystLink extends React.PureComponent {
  static propTypes = {
    applicationInstance: PropTypes.shape({
      id: PropTypes.number,
    }),
    name: PropTypes.string,
  };

  render() {
    const { applicationInstance } = this.props;
    const href = `/admin/application_instances/${applicationInstance.id}/catalyst_stats`;

    return (
      <a href={href} target="_blank">
        <i className="material-icons">open_in_new </i>
        {this.props.name}
      </a>
    );
  }
}
