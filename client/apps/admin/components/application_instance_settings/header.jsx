import React, { useState } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import EnabledButton from '../common/enabled';
import Menu from '../common/menu';
import DisabledButton from '../common/disabled';
import DeleteModal from '../common/delete_modal';
import getExtraFields from '../application_instances/extra_fields';
import * as ApplicationInstanceActions from '../../actions/application_instances';

const select = (state) => ({
  newApplicationInstance: state.applicationInstances.newApplicationInstance,
});

export function Header(props) {
  const {
    goBack,
    applicationInstance,
    application,
    deleteInstance,
    disableInstance,
    newApplicationInstance,
  } = props;

  const {
    nickname,
    primary_contact: primaryContact,
    site,
  } = applicationInstance;


  const extraFields = application ? getExtraFields(application.key) : [];

  const [deleteModalOpen, setDeleteModalOpen] = useState(false);

  const deleteAppInstance = (appId, appInstId) => {
    setDeleteModalOpen(false);
    deleteInstance(appId, appInstId);
    goBack();
  };

  const disable = () => {
    const disabledAt = applicationInstance.disabled_at ? null : new Date(Date.now());
    disableInstance(applicationInstance.application_id, applicationInstance.id, disabledAt);
  };

  const saveAppInstance = () => {
    if (!_.isEmpty(newApplicationInstance)) {
      props.saveApplicationInstance(application.id, newApplicationInstance);
    }

  };

  const instanceMenu = () => (
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
                type="button"
                onClick={() => disable()}
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
                onClick={() => setDeleteModalOpen(true)}
                type="button"
              >
                <i className="material-icons">delete</i>
                Delete
              </button>
              <DeleteModal
                isOpen={deleteModalOpen}
                closeModal={() => setDeleteModalOpen(false)}
                deleteRecord={
                  () => deleteAppInstance(
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
  );

  return (
    <div className="aj-header">
      <button type="button" onClick={goBack} className="back-btn">
        <i className="fas fa-chevron-left aj-icon" />
        {application.name}
        &nbsp;Instances
      </button>
      <div className="header-row space-between">
        <div className="title">
          {nickname}
        </div>
        <div className="flex-center">
          <button type="button" onClick={saveAppInstance} className="aj-btn">
            Save
          </button>
          {instanceMenu()}
        </div>
      </div>
      <div className="header-row info">
        <div className="info-spacing">
          <div>Primary Contact</div>
          <a href={`mailto: ${primaryContact}`}>{primaryContact}</a>
        </div>
        <div className="info-spacing">
          <div>Canvas URL</div>
          <a href={site.url}>{site.url}</a>
        </div>
      </div>
    </div>
  );
}

export default connect(select, ApplicationInstanceActions)(Header);

Header.propTypes = {
  goBack: PropTypes.func,
  saveApplicationInstance: PropTypes.func,
  deleteInstance: PropTypes.func,
  disableInstance: PropTypes.func,
  applicationInstance: PropTypes.shape({
    disabled_at: PropTypes.bool,
    application_id: PropTypes.number,
    id: PropTypes.number,
    nickname: PropTypes.string,
    primary_contact: PropTypes.string,
    site: PropTypes.shape({
      url: PropTypes.string,
    })
  }),
  newApplicationInstance: PropTypes.shape({}),
  application: PropTypes.shape({
    key: PropTypes.string,
    id: PropTypes.number,
    name: PropTypes.string,
  }),
};
