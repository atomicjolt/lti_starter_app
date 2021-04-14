import React from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router3';
import _ from 'lodash';

import Modal from './modal';
import AuthenticationsModal from './authentications_modal';
import SettingsInputs from '../common/settings_inputs';
import ConfigXmlModal from './config_xml_modal';
import EnabledButton from '../common/enabled';
import DisabledButton from '../common/disabled';
import DeleteModal from '../common/delete_modal';

export default class ListRow extends React.Component {
  static propTypes = {
    delete: PropTypes.func.isRequired,
    save: PropTypes.func.isRequired,
    sites: PropTypes.shape({}).isRequired,
    application: PropTypes.shape({}),
    applicationInstance: PropTypes.shape({
      site: PropTypes.shape({
        url: PropTypes.string,
      }),
      id: PropTypes.number.isRequired,
      application_id: PropTypes.number.isRequired,
      request_stats: PropTypes.shape({
        day_1_requests: PropTypes.number,
        day_7_requests: PropTypes.number,
        day_30_requests: PropTypes.number,
        day_365_requests: PropTypes.number,
        day_1_launches: PropTypes.number,
        day_7_launches: PropTypes.number,
        day_30_launches: PropTypes.number,
        day_365_launches: PropTypes.number,
        day_1_users: PropTypes.number,
        day_7_users: PropTypes.number,
        day_30_users: PropTypes.number,
        day_365_users: PropTypes.number,
        day_1_errors: PropTypes.number,
        day_7_errors: PropTypes.number,
        day_30_errors: PropTypes.number,
        day_365_errors: PropTypes.number,
      }),
    }).isRequired,
    settings: PropTypes.shape({
      lti_key: PropTypes.string,
      user_canvas_domains: PropTypes.arrayOf(PropTypes.string),
    }).isRequired,
    canvasOauthURL: PropTypes.string.isRequired,
    disable: PropTypes.func.isRequired,
  };

  static getStyles() {
    return {
      buttonIcon: {
        border: 'none',
        backgroundColor: 'transparent',
        color: 'grey',
        fontSize: '1.5em',
        cursor: 'pointer',
      },
      buttonNumber: {
        height: '3rem',
        borderRadius: '3px',
        background: '#f5f5f5',
        border: 'none',
        color: 'grey',
        fontSize: '1.5em',
        cursor: 'pointer',
      },
    };
  }

  constructor() {
    super();
    this.state = {
      modalOpen: false,
      authenticationModalOpen: false,
      modalConfigXmlOpen: false,
      confirmDeleteModalOpen: false,
    };
  }

  get applicationInstanceModal() {
    if (this.state.modalOpen) {
      return <Modal
        closeModal={() => this.setState({ modalOpen: false })}
        sites={this.props.sites}
        save={this.props.save}
        application={this.props.application}
        applicationInstance={this.props.applicationInstance}
      />;
    }
    return null;
  }

  closeDeleteModal() {
    this.setState({
      confirmDeleteModalOpen: false,
    });
  }

  checkAuthentication(e) {
    const found = _.find(
      this.props.settings.user_canvas_domains,
      (canvasUrl) => canvasUrl === this.props.applicationInstance.site.url
    );

    if (!found) {
      e.stopPropagation();
      e.preventDefault();
      this.settingsForm.submit();
    }
  }

  renderAuthentications() {
    const styles = ListRow.getStyles();
    const { applicationInstance } = this.props;
    const numberAuthentications = applicationInstance.authentications
      ? applicationInstance.authentications.length : 0;

    if (numberAuthentications <= 0) {
      return (
        <td>
          {numberAuthentications}
        </td>
      );
    }
    return (
      <td>
        <button
          style={styles.buttonNumber}
          onClick={() => this.setState({ authenticationModalOpen: true })}
        >
          {numberAuthentications}
        </button>
        <AuthenticationsModal
          isOpen={this.state.authenticationModalOpen}
          closeModal={() => this.setState({ authenticationModalOpen: false })}
          authentications={applicationInstance.authentications}
          application={this.props.application}
          applicationInstance={applicationInstance}
        />
      </td>
    );
  }

  deleteAppInstance(appId, appInstId) {
    this.setState({
      confirmDeleteModalOpen: false,
    });
    this.props.delete(appId, appInstId);
  }

  render() {
    const { applicationInstance } = this.props;
    const styles = ListRow.getStyles();
    const path = `applications/${applicationInstance.application_id}/application_instances/${applicationInstance.id}/installs`;
    const createdAt = new Date(applicationInstance.created_at);

    return (
      <tr>
        <td>
          <form
            ref={(ref) => { this.settingsForm = ref; }}
            action={this.props.canvasOauthURL}
          >
            <SettingsInputs settings={this.props.settings} />
            <input
              type="hidden"
              name="canvas_url"
              value={applicationInstance.site.url}
            />
            <input
              type="hidden"
              name="admin_oauth_aii"
              value={applicationInstance.id}
            />
            <input
              type="hidden"
              name="oauth_consumer_key"
              value={applicationInstance.lti_key}
            />
          </form>
          <Link
            onClick={(e) => { this.checkAuthentication(e); }}
            to={path}
          >
            {applicationInstance.lti_key}
          </Link>
          <div>{_.replace(applicationInstance.site.url, 'https://', '')}</div>
        </td>
        <td>
          <button
            style={styles.buttonIcon}
            onClick={() => this.setState({ modalOpen: true })}
          >
            <i className="i-settings" />
          </button>
          { this.applicationInstanceModal }
        </td>
        <td>
          <button
            style={styles.buttonIcon}
            onClick={() => this.setState({ modalConfigXmlOpen: true })}
          >
            <i className="i-settings" />
          </button>
          <ConfigXmlModal
            isOpen={this.state.modalConfigXmlOpen}
            closeModal={() => this.setState({ modalConfigXmlOpen: false })}
            application={this.props.application}
            applicationInstance={applicationInstance}
          />
        </td>
        <td>
          <button
            onClick={this.props.disable}
            className="c-disable"
          >
            {
              applicationInstance.disabled_at ? <DisabledButton /> : <EnabledButton />
            }
          </button>
        </td>
        { this.renderAuthentications() }
        <td>
          {createdAt.toLocaleDateString()}
          {' '}
          {createdAt.toLocaleTimeString()}
        </td>
        <td>
          <div>1 day</div>
          <div>7 days</div>
          <div>30 days</div>
          <div>1 year</div>
        </td>
        <td>
          <div>{applicationInstance.request_stats.day_1_requests}</div>
          <div>{applicationInstance.request_stats.day_7_requests}</div>
          <div>{applicationInstance.request_stats.day_30_requests}</div>
          <div>{applicationInstance.request_stats.day_365_requests}</div>
        </td>
        <td>
          <div>{applicationInstance.request_stats.day_1_launches}</div>
          <div>{applicationInstance.request_stats.day_7_launches}</div>
          <div>{applicationInstance.request_stats.day_30_launches}</div>
          <div>{applicationInstance.request_stats.day_365_launches}</div>
        </td>
        <td>
          <div>{applicationInstance.request_stats.day_1_users}</div>
          <div>{applicationInstance.request_stats.day_7_users}</div>
          <div>{applicationInstance.request_stats.day_30_users}</div>
          <div>{applicationInstance.request_stats.day_365_users}</div>
        </td>
        <td>
          <div>{applicationInstance.request_stats.day_1_errors}</div>
          <div>{applicationInstance.request_stats.day_7_errors}</div>
          <div>{applicationInstance.request_stats.day_30_errors}</div>
          <div>{applicationInstance.request_stats.day_365_errors}</div>
        </td>
        <td>
          <button
            className="c-delete"
            style={styles.buttonIcon}
            onClick={() => this.setState({ confirmDeleteModalOpen: true })}
          >
            <i className="i-delete" />
          </button>
          <DeleteModal
            isOpen={this.state.confirmDeleteModalOpen}
            closeModal={() => this.closeDeleteModal()}
            deleteRecord={
              () => this.deleteAppInstance(
                applicationInstance.application_id,
                applicationInstance.id,
              )
            }
          />
        </td>
      </tr>
    );
  }
}
