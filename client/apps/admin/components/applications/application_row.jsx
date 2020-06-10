import React from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router3';
import Modal from './modal';

export default class ApplicationRow extends React.Component {

  static propTypes = {
    application: PropTypes.shape({
      id                          : PropTypes.number,
      name                        : PropTypes.string,
      application_instances_count : PropTypes.number,
    }).isRequired,
    saveApplication: PropTypes.func.isRequired,
  };

  static getStyles() {
    return {
      buttonIcon: {
        border: 'none',
        backgroundColor: 'transparent',
        color: 'grey',
        fontSize: '1.5em',
        cursor: 'pointer',
      }
    };
  }

  constructor() {
    super();
    this.state = { modalOpen: false };
  }

  render() {
    const styles = ApplicationRow.getStyles();
    return (
      <tr>
        <td>
          <Link to={`/applications/${this.props.application.id}/application_instances`}>{this.props.application.name}</Link>
        </td>
        <td>
          <Link to={`/applications/${this.props.application.id}/lti_install_keys`}>Manage Keys</Link>
        </td>
        <td><span>{this.props.application.application_instances_count}</span></td>
        <td>
          <button
            style={styles.buttonIcon}
            onClick={() => this.setState({ modalOpen: true })}
          >
            <i className="i-settings" />
          </button>
          <Modal
            isOpen={this.state.modalOpen}
            application={this.props.application}
            closeModal={() => this.setState({ modalOpen: false })}
            save={this.props.saveApplication}
          />
        </td>
      </tr>
    );
  }

}
