import React, { useEffect } from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import * as ApplicationInstanceActions from '../../actions/application_instances';
import Textarea from '../common/textarea';
import { useDispatch, useSelector } from 'react-redux';

export default function XmlConfig(props) {
  const {
    params,
  } = props;

  const dispatch = useDispatch();
  const loading = useSelector((state) => state.applicationInstances.loading);
  const loaded = useSelector((state) => state.applicationInstances.loaded);
  const applicationInstances = useSelector((state) => state.applicationInstances);

  useEffect(() => {
    if (!loading && !loaded) {
      dispatch(
        getApplicationInstance(
          params.applicationId,
          params.applicationInstanceId
        )
      )
    }
  }, []);

  const applicationInstance = _.filter(
    applicationInstances,
    (app) => app.id === _.parseInt(params.applicationInstanceId)
  )[0];

  const getConfig = () => `LTI KEY: ${applicationInstance.lti_key || ''}\n\nLTI Secret: 
  ${applicationInstance.lti_secret || ''}\n\nConfig XML: ${applicationInstance.lti_config_xml || ''}`;

  return (
    <div>
      <div className="o-grid__item u-full">
        <Textarea
          className="c-input c-input--dark"
          labelText="LTI Config XML"
          textareaProps={{
            id: 'application_instance_lti_config_xml',
            name: 'lti_config_xml',
            rows: 25,
            readOnly: true,
            value: getConfig(),
          }}
        />
      </div>
    </div>
  );
}

XmlConfig.propTypes = {
  applicationInstance: PropTypes.shape({
    config: PropTypes.string,
    lti_config: PropTypes.string,
    lti_config_xml: PropTypes.string,
  }),
  loading: PropTypes.bool,
  loaded: PropTypes.bool,
  applicationInstances: PropTypes.array,
  getApplicationInstance: PropTypes.func,
  params: PropTypes.shape({
    applicationId: PropTypes.string.isRequired,
    applicationInstanceId: PropTypes.string.isRequired,
  }).isRequired,
  location: PropTypes.shape({
    state: PropTypes.shape({
      setNewInstance: PropTypes.func,
    }),
  }),
};
