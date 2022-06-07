import React from 'react';
import { useSelector, useDispatch } from 'react-redux';
import _ from 'lodash';
import { saveApplication } from '../../actions/applications';
import Heading from '../common/heading';
import ApplicationRow from './application_row';

export default function Index() {

  const applications = useSelector((state) => state.applications);

  const applicationRows = _.map(applications, (application, index) => (
    <ApplicationRow
      key={index}
      application={application}
      saveApplication={(applicationToSave) => useDispatch(saveApplication(applicationToSave))}
    />
  ));

  return (
    <div>
      <Heading />
      <div className="o-contain o-contain--full">
        <div className="c-info">
          <div className="c-title">
            <h1>LTI Applications</h1>
          </div>
        </div>
        <table className="c-table c-table--lti">
          <thead>
            <tr>
              <th><span>NAME</span></th>
              <th><span>LTI INSTALL KEYS</span></th>
              <th><span>INSTANCES</span></th>
              <th><span>SETTINGS</span></th>
            </tr>
          </thead>
          <tbody>
            { applicationRows }
          </tbody>
        </table>
      </div>
    </div>
  );
}
