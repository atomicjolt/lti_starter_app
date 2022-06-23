import React, { useEffect, useState, useCallback } from 'react';
import PropTypes from 'prop-types';
import { useDispatch, useSelector } from 'react-redux';
import _ from 'lodash';
import ReactModal from 'react-modal';
import { listActiveCoursesInAccount } from 'atomic-canvas/libs/constants/accounts';
import { listExternalToolsCourses, listExternalToolsAccounts } from 'atomic-canvas/libs/constants/external_tools';
import { helperListAccounts } from 'atomic-canvas/libs/helper_constants';
import canvasRequest from 'atomic-canvas/libs/action';
import {
  getApplicationInstance,
} from '../../actions/application_instances';
import Heading from '../common/heading';
import Sidebar from './sidebar';
import InstallPane from './install_pane';

export default function Index(props) {
  const dispatch = useDispatch();
  const [currentAccount, setCurrentAccount] = useState(null);
  const { params } = props;
  const {
    applicationId,
    applicationInstanceId,
  } = params;

  const applicationInstances = useSelector(
    (state) => state.applicationInstances.applicationInstances
  );
  const applicationInstance = _.find(applicationInstances, (ai) => `${ai.id}` === applicationInstanceId);
  const applications = useSelector((state) => state.applications);
  const accounts = useSelector((state) => state.accounts.accounts);
  const loadingAccounts = useSelector((state) => state.accounts.loading);
  const courses = useSelector((state) => _.sortBy(state.courses, (course) => course.name));
  const loadingCourses = useSelector((state) => state.loadingCourses);
  const sites = useSelector((state) => state.sites);

  const rootAccount = _.find(accounts, { parent_account_id: null });

  const applicationIdParsed = parseInt(applicationId, 10);

  function loadExternalTools(courseId) {
    dispatch(
      canvasRequest(
        listExternalToolsCourses,
        { course_id: courseId },
        null,
        courseId,
      )
    );
  }

  const setAccountActive = useCallback((account) => {
    if (account.external_tools === undefined) {
      dispatch(
        canvasRequest(
          listExternalToolsAccounts,
          { account_id: account.id },
          null,
          account
        )
      );
    }
    setCurrentAccount(account);
  }, [dispatch]);

  useEffect(() => {
    dispatch(
      canvasRequest(
        helperListAccounts,
        {},
        null,
        null,
      )
    );

    dispatch(
      getApplicationInstance(
        applicationId,
        applicationInstanceId,
      )
    );
  }, []);

  useEffect(() => {
    if (_.isNull(currentAccount) && !_.isUndefined(rootAccount)) {
      setAccountActive(rootAccount);
    }
  }, [currentAccount, rootAccount, setAccountActive]);

  useEffect(() => {
    if (!_.isEmpty(accounts)) {
      dispatch(
        canvasRequest(
          listExternalToolsAccounts,
          { account_id: rootAccount.id },
          null,
          rootAccount,
        )
      );
    }
  }, [accounts, rootAccount]);

  useEffect(() => {
    if (_.isEmpty(courses) && !_.isEmpty(accounts)) {
      dispatch(
        canvasRequest(
          listActiveCoursesInAccount,
          { account_id: rootAccount.id, per_page: 100 }
        )
      );
    }
  }, [courses, accounts]);

  return (
    <div style={{ height: '100%' }}>
      <Heading />
      <div className="o-contain">
        <Sidebar
          currentAccount={currentAccount}
          accounts={accounts}
          application={applications[applicationIdParsed]}
          applicationInstance={applicationInstance}
          setAccountActive={(account) => setAccountActive(account)}
          sites={sites}
        />
        <InstallPane
          canvasRequest={canvasRequest}
          loadingCourses={loadingCourses}
          applicationInstance={applicationInstance}
          account={currentAccount}
          loadExternalTools={(courseId) => loadExternalTools(courseId)}
        />
      </div>
      <ReactModal
        isOpen={loadingAccounts}
        contentLabel="Modal"
        overlayClassName="c-modal__background"
        className="c-modal c-modal--site is-open c-modal--error loading"
      >
        <div className="c-loading-icon" />
        &nbsp;&nbsp;&nbsp;Loading...
      </ReactModal>
    </div>
  );
}

Index.propTypes = {
  params: PropTypes.shape({
    applicationId: PropTypes.string,
    applicationInstanceId: PropTypes.string,
  }).isRequired,
};
