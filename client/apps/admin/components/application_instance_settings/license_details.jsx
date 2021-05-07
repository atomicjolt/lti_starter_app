import React, { useState, useEffect }  from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import * as ApplicationInstanceActions from '../../actions/application_instances';

import SettingsInputs from './settings_inputs';

const select = (state, props) => ({
  loading: state.applicationInstances.loading,
  loaded: state.applicationInstances.loaded,
  applicationInstances: _.filter(state.applicationInstances.applicationInstances,
    { application_id: parseInt(props.params.applicationId, 10) }),
  sites: state.sites,
});

export function TrialDetails(props) {

  const {
    applicationInstances,
    params,
    loading,
    loaded
  } = props;

  useEffect(() => {
    if (!loading && !loaded) {
      props.getApplicationInstance(params.applicationId, params.applicationInstanceId);
    }
  },
  []);

  const applicationInstance = _.filter(applicationInstances, (app) => (
    app.id === _.parseInt(params.applicationInstanceId)
  ))[0];

  const [newApplicationInstance, setNewApplicationInstance] = useState(applicationInstance || {});

  useEffect(() => {
    // Redux function to store newApplicationInstance
    props.updateNewInstance(newApplicationInstance);
  },
  [newApplicationInstance]);

  const onChange = (e) => {

    if (e.target.name === 'paid') {
      const cloneApplicationInstance = _.cloneDeep(newApplicationInstance);
      cloneApplicationInstance.paid_at = null;
      if (e.target.checked) {
        cloneApplicationInstance.paid_at = new Date().toUTCString();
      }
      setNewApplicationInstance(cloneApplicationInstance);
      return;
    }

    if (e.target.type === 'datepicker') {
      const cloneApplicationInstance = _.cloneDeep(newApplicationInstance);
      cloneApplicationInstance[e.target.name] = new Date(e.target.value).toUTCString();
      setNewApplicationInstance(cloneApplicationInstance);
      return;
    }

    setNewApplicationInstance({
      ...newApplicationInstance,
      [e.target.name]: e.target.value
    });
  };

  const changeDatepicker = (value, name) => {
    const event = {
      target: {
        value: value[0],
        type: 'datepicker',
        name,
      }
    };
    onChange(event);
  };

  const licenseInputs = [
    {
      labelText: 'Paid Account',
      className: 'c-checkbox',
      props: {
        name: 'paid',
        type: 'checkbox',
        id: 'paid_input',
        value: 'true',
        checked: _.isString(newApplicationInstance.paid_at),
        onChange,
      }
    },
    {
      labelText: 'License start date',
      name: 'paid_at',
      type: 'datepicker',
      maxDate: newApplicationInstance.license_end_date || '',
      value: newApplicationInstance.paid_at,
      onChange: changeDatepicker,
    },
    {
      labelText: 'License end date',
      name: 'license_end_date',
      type: 'datepicker',
      minDate: newApplicationInstance.paid_at || '',
      value: newApplicationInstance.license_end_date,
      onChange: changeDatepicker,
    },
    {
      labelText: 'Licensed users',
      props: {
        name: 'licensed_users',
        type: 'text',
        id: 'licensed_users_input',
        value: newApplicationInstance.licensed_users || '',
        onChange,
      }
    },
    {
      labelText: 'License notes',
      type: 'textarea',
      props: {
        name: 'license_notes',
        id: 'license_notes_input',
        rows: 20,
        value: newApplicationInstance.license_notes || '',
        onChange,
      }
    },
  ];

  return (
    <div className="aj-columns">
      <div className="aj-col-flex">
        <SettingsInputs
          title="License Details"
          inputs={licenseInputs}
          inputClass="aj-small-input"
          textareaClass="aj-small-textarea"
          bodyClass="aj-flex-col"
        />
      </div>
    </div>
  );
}

export default connect(select, ApplicationInstanceActions)(TrialDetails);


TrialDetails.propTypes = {
  loading: PropTypes.bool,
  loaded: PropTypes.bool,
  getApplicationInstance: PropTypes.func,
  updateNewInstance: PropTypes.func,
  params: PropTypes.shape({
    applicationId: PropTypes.string.isRequired,
    applicationInstanceId: PropTypes.string.isRequired,
  }).isRequired,
  applicationInstances: PropTypes.array,
};
