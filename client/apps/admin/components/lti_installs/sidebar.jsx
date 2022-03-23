import React, { useState } from 'react';
import { useDispatch } from 'react-redux';
import PropTypes from 'prop-types';
import Accounts from './accounts';
import Modal from '../application_instances/modal';

import {
  saveApplicationInstance,
} from '../../actions/application_instances';

export default function Sidebar(props) {
  const {
    sites,
    application,
    applicationInstance,
    currentAccount,
    accounts,
    setAccountActive,
  } = props;

  const [modalOpen, setModalOpen] = useState(false);
  const dispatch = useDispatch();

  function settings() {
    if (applicationInstance) {
      return (
        <span>
          <a onClick={() => setModalOpen(true)}>
            <i className="material-icons">settings</i>
          </a>
          {
            modalOpen
              ? <Modal
                  closeModal={() => setModalOpen(false)}
                  sites={sites}
                  save={(appId, appInst) => {
                    dispatch(saveApplicationInstance(appId, appInst));
                  }}
                  application={application}
                  applicationInstance={applicationInstance}
              />
              : null
          }
        </span>
      );
    }
    return null;
  }

  const schoolUrl = applicationInstance ? applicationInstance?.site?.url : '';

  return (
    <div className="o-left">
      <div className="c-tool">
        {settings()}
        <h4 className="c-tool__subtitle">LTI Tool</h4>
        <h3 className="c-tool__title">{application ? application.name : 'n/a'}</h3>
      </div>

      <div className="c-tool">
        <h4 className="c-tool__instance"><a href={schoolUrl}>{schoolUrl}</a></h4>
      </div>

      <div className="c-filters">
        <h4 className="c-sidebar-subtitle">Accounts</h4>
        <Accounts
          currentAccount={currentAccount}
          accounts={accounts}
          setAccountActive={setAccountActive}
        />
      </div>
    </div>
  );
}

Sidebar.propTypes = {
  application: PropTypes.shape({
    name: PropTypes.string.isRequired,
  }),
  applicationInstance: PropTypes.shape({
    name: PropTypes.string,
    site: PropTypes.shape({
      url: PropTypes.string
    })
  }),
  accounts: PropTypes.shape({}),
  currentAccount: PropTypes.shape({}),
  setAccountActive: PropTypes.func.isRequired,
  sites: PropTypes.shape({}).isRequired,
};
