import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import * as ApplicationInstanceActions from '../../actions/application_instances';
import Textarea from '../common/textarea';
import Warning from '../common/warning';

function prettyJSON(str) {
  if (_.isEmpty(str)) {
    return str;
  }

  try {
    const obj = JSON.parse(str);
    return JSON.stringify(obj, null, 2);
  } catch (e) {
    // Invalid json. Warn the user and just output the string
    return str;
  }
}

const select = (state, props) => ({
  loading: state.applicationInstances.loading,
  loaded: state.applicationInstances.loaded,
  applicationInstances: _.filter(state.applicationInstances.applicationInstances,
    { application_id: parseInt(props.params.applicationId, 10) }),
});

export function Configuration(props) {

  const {
    loading,
    loaded,
    params,
    applicationInstances
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
  const [parseErrors, setParseErrors] = useState({});

  useEffect(() => {
    // Redux function to store newApplicationInstance
    props.updateNewInstance(newApplicationInstance);
  },
  [newApplicationInstance]);

  const onChange = (e) => {

    // JSON is for configuration tab. same with it's errors
    let configParseError = null;
    if (e.target.name === 'config') {
      try {
        JSON.parse(e.target.value || '{}');
      } catch (err) {
        configParseError = err.toString();
      }
    }

    let ltiConfigParseError = null;
    if (e.target.name === 'lti_config') {
      try {
        JSON.parse(e.target.value || '{}');
      } catch (err) {
        ltiConfigParseError = err.toString();
      }
    }

    setNewApplicationInstance({
      ...newApplicationInstance,
      [e.target.name]: e.target.value
    });
    setParseErrors({
      configParseError,
      ltiConfigParseError,
    });
  };

  let erroneousConfigWarning = null;
  if (parseErrors.configParseError) {
    erroneousConfigWarning = (
      <Warning text={parseErrors.configParseError} />
    );
  }

  let erroneousLtiConfigWarning = null;
  if (parseErrors.ltiConfigParseError) {
    erroneousLtiConfigWarning = (
      <Warning text={parseErrors.ltiConfigParseError} />
    );
  }

  return (
    <div>
      <div className="o-grid__item u-full">
        <Textarea
          className="c-input c-input--dark"
          labelText="Custom Application Instance Configuration"
          textareaProps={{
            id: 'application_instance_config',
            name: 'config',
            placeholder: 'ex: { "foo": "bar" }',
            value: prettyJSON(newApplicationInstance.config || '{}'),
            onChange,
          }}
          warning={erroneousConfigWarning}
        />
      </div>
      <div className="o-grid__item u-full">
        <Textarea
          className="c-input c-input--dark"
          labelText="LTI Configuration"
          textareaProps={{
            id: 'application_instance_lti_config',
            name: 'lti_config',
            rows: 25,
            value: prettyJSON(newApplicationInstance.lti_config || '{}'),
            onChange,
          }}
          warning={erroneousLtiConfigWarning}
        />
      </div>
      <div className="o-grid__item u-full">
        <Textarea
          className="c-input c-input--dark"
          labelText="LTI Config XML"
          textareaProps={{
            id: 'application_instance_lti_config_xml',
            name: 'lti_config_xml',
            rows: 25,
            readOnly: true,
            value: applicationInstance.lti_config_xml || '',
            onChange: () => {},
          }}
        />
      </div>
    </div>
  );
}

export default connect(select, ApplicationInstanceActions)(Configuration);

Configuration.propTypes = {
  applicationInstance: PropTypes.shape({
    config: PropTypes.string,
    lti_config: PropTypes.string,
    lti_config_xml: PropTypes.string,
  }),
  loading: PropTypes.bool,
  loaded: PropTypes.bool,
  updateNewInstance: PropTypes.func,
  applicationInstances: PropTypes.array,
  getApplicationInstance: PropTypes.func,
  params: PropTypes.shape({
    applicationId: PropTypes.string.isRequired,
    applicationInstanceId: PropTypes.string.isRequired,
  }).isRequired,
  location: PropTypes.shape({
    state: PropTypes.shape({
      setNewInstance: PropTypes.func,
    })
  }),
};
