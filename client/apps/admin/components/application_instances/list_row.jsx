import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';

import Modal from './modal';
import ConfigXmlModal from './config_xml_modal';
import EnabledButton from '../common/enabled';
import DisabledButton from '../common/disabled';
import DeleteModal from '../common/delete_modal';
import getExtraFields from './extra_fields';
import Menu from '../common/menu';

export default class ListRow extends React.Component {
  static propTypes = {
    delete: PropTypes.func.isRequired,
    save: PropTypes.func.isRequired,
    sites: PropTypes.shape({}).isRequired,
    application: PropTypes.shape({
      key: PropTypes.string.isRequired,
    }),
    applicationInstance: PropTypes.shape({
      site: PropTypes.shape({
        url: PropTypes.string,
      }),
      free_trial_days_left: PropTypes.number,
      user_email: PropTypes.string,
      disabled_at: PropTypes.bool,
      id: PropTypes.number.isRequired,
      application_id: PropTypes.number.isRequired,
      lti_key: PropTypes.string.isRequired,
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
        max_users_month: PropTypes.number,
      }),
    }).isRequired,
    settings: PropTypes.shape({
      lti_key: PropTypes.string,
      user_canvas_domains: PropTypes.arrayOf(PropTypes.string),
    }).isRequired,
    disable: PropTypes.func.isRequired,
    showPaid: PropTypes.bool,
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

  deleteAppInstance(appId, appInstId) {
    this.setState({
      confirmDeleteModalOpen: false,
    });
    this.props.delete(appId, appInstId);
  }

  render() {
    const { applicationInstance, application, showPaid } = this.props;

    const extraFields = application ? getExtraFields(application.key) : [];

    const trialEnds = applicationInstance.free_trial_days_left < 0 ? 'Expired' : `${applicationInstance.free_trial_days_left} Days`;

    return (
      <tr>
        <td>
          <span>
            {applicationInstance.lti_key}
          </span>
          {/* User Email over Instance */}
          <div>
            {applicationInstance.user_email || 'Unknown User' }
          </div>
        </td>
        {/* LicenseEnds/TrialEnds */}
        <td>
          {showPaid ? 'Never' :  trialEnds}
        </td>
        <td>
          {applicationInstance.lti_key}
        </td>
        <td>
          {_.replace(applicationInstance.site.url, 'https://', '')}
        </td>
        {/* Licensed Users not implemented yet*/}
        <td>
          {/* 0 */}
        </td>
        <td>
          {applicationInstance.request_stats.max_users_month || 0}
        </td>
        <td>
          {applicationInstance.request_stats.day_365_users || 0}
        </td>
        <td>
          <div>d:{applicationInstance.request_stats.day_1_errors}</div>
          <div>w:{applicationInstance.request_stats.day_7_errors}</div>
        </td>
        <td>
          <Menu>
            {(onClick, activeClass, isOpen, menuRef) => (
              <div className={`aj-menu-contain ${activeClass}`} ref={menuRef}>
                <button
                  className="aj-icon-btn"
                  aria-label="Instance Settings"
                  aria-haspopup="true"
                  aria-expanded={isOpen ? 'true' : 'false'}
                  onClick={onClick}
                  type="button"
                >
                  <i className="material-icons" aria-hidden="true">more_vert</i>
                </button>
                <ul className="aj-menu" role="menu">
                  {_.map(extraFields, ({ name, Component }) => (
                    <li key={name}>
                      <Component applicationInstance={applicationInstance} name={name} />
                    </li>
                  ))}
                  <li>
                    <button
                      onClick={() => this.setState({ modalOpen: true })}
                      type="button"
                    >
                      <i className="material-icons">settings</i>
                      Settings
                    </button>
                    { this.applicationInstanceModal }
                  </li>
                  <li>
                    <button
                      onClick={() => this.setState({ modalConfigXmlOpen: true })}
                      type="button"
                    >
                      <i className="material-icons">settings</i>
                      Config XML
                    </button>
                    <ConfigXmlModal
                      isOpen={this.state.modalConfigXmlOpen}
                      closeModal={() => this.setState({ modalConfigXmlOpen: false })}
                      application={this.props.application}
                      applicationInstance={applicationInstance}
                    />
                  </li>
                  <li>
                    <button
                      onClick={() => this.props.disable()}
                      className="c-disable"
                    >
                      {
                        applicationInstance.disabled_at ? <DisabledButton /> : <EnabledButton />
                      }
                      {applicationInstance.disabled_at ? 'Enable' : 'Disable' }
                    </button>
                  </li>
                  <li>
                    <button
                      onClick={() => this.setState({ confirmDeleteModalOpen: true })}
                      type="button"
                    >
                      <i className="material-icons">delete</i>
                      Delete
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
                  </li>
                </ul>
              </div>
            )}
          </Menu>
        </td>
      </tr>
    );
  }
}
