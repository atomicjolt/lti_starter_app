import React from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router';
import _ from 'lodash';
import Modal from './modal';
import SettingsInputs from '../common/settings_inputs';
import ConfigXmlModal from './config_xml_modal';
import EnabledButton from '../common/enabled';
import DisabledButton from '../common/disabled';

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

    };
  }

  constructor() {
    super();
    this.state = {
      modalOpen: false,
      modalConfigXmlOpen: false,
    };
  }

  checkAuthentication(e) {
    if (!_.find(this.props.settings.user_canvas_domains, canvasUrl =>
      canvasUrl === this.props.applicationInstance.site.url
    )) {
      e.stopPropagation();
      e.preventDefault();
      this.settingsForm.submit();
    }
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
              name="oauth_complete_url"
              value={`${window.location.protocol}//${window.location.host}${window.location.pathname}#${path}`}
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
        <td><span>{applicationInstance.domain}</span></td>
        <td>
          <button
            style={styles.buttonIcon}
            onClick={() => this.setState({ modalOpen: true })}
          >
            <i className="i-settings" />
          </button>
          <Modal
            isOpen={this.state.modalOpen}
            closeModal={() => this.setState({ modalOpen: false })}
            sites={this.props.sites}
            save={this.props.save}
            application={this.props.application}
            applicationInstance={this.props.applicationInstance}
          />
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
        <td>
          {applicationInstance.canvas_token_preview}
        </td>
        <td>
          {applicationInstance.authentications_count}
        </td>
        <td>
          {createdAt.toLocaleDateString()} {createdAt.toLocaleTimeString()}
        </td>
        <td>
          <button
            className="c-delete"
            onClick={() => {
              this.props.delete(applicationInstance.application_id, applicationInstance.id);
            }}
          >
            <i className="i-delete" />
          </button>
        </td>
      </tr>
    );
  }
}
