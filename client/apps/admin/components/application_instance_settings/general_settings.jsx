import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import moment from 'moment';
import SiteModal from '../sites/modal';
import SettingsInputs from './settings_inputs';
import * as ApplicationInstanceActions from '../../actions/application_instances';

const select = (state, props) => ({
  loading: state.applicationInstances.loading,
  loaded: state.applicationInstances.loaded,
  applicationInstances: _.filter(state.applicationInstances.applicationInstances,
    { application_id: parseInt(props.params.applicationId, 10) }),
  sites: state.sites,
});

export function GeneralSettings(props) {

  const {
    languagesSupported,
    params,
    loading,
    loaded,
    sites,
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
  const [currentLanguage, setCurrentLanguage] = useState(applicationInstance ? applicationInstance.language : 'english');
  const [siteModalOpen, setSiteModalOpen] = useState(false);

  useEffect(() => {
    // Redux function to store newApplicationInstance
    props.updateNewInstance(newApplicationInstance);
  },
  [newApplicationInstance]);

  const languages = _.map(languagesSupported, (label, value) => ({
    label,
    value,
  }));

  const selectedLanguage = _.find(languages, (lang) => lang.label === currentLanguage);

  const onChange = (e) => {

    if (e.target.name === 'anonymous') {
      const cloneApplicationInstance = _.cloneDeep(newApplicationInstance);
      cloneApplicationInstance.anonymous = false;
      if (e.target.checked) {
        cloneApplicationInstance.anonymous = true;
      }
      setNewApplicationInstance(cloneApplicationInstance);
      return;
    }

    if (e.target.name === 'rollbar_enabled') {
      const cloneApplicationInstance = _.cloneDeep(newApplicationInstance);
      cloneApplicationInstance.rollbar_enabled = false;
      if (e.target.checked) {
        cloneApplicationInstance.rollbar_enabled = true;
      }
      setNewApplicationInstance(cloneApplicationInstance);
      return;
    }

    if (e.target.name === 'use_scoped_developer_key') {
      const cloneApplicationInstance = _.cloneDeep(newApplicationInstance);
      cloneApplicationInstance.use_scoped_developer_key = false;
      if (e.target.checked) {
        cloneApplicationInstance.use_scoped_developer_key = true;
      }
      setNewApplicationInstance(cloneApplicationInstance);
      return;
    }

    setNewApplicationInstance({
      ...newApplicationInstance,
      [e.target.name]: e.target.value
    });
  };

  const changeLanguage = (option) => {
    setCurrentLanguage(option.label);

    const event = {
      target: {
        value: option.label,
        name: 'language'
      }
    };

    onChange(event);
  };

  const selectSite = (option) => {
    if (_.isFunction(option.onSelect)) {
      option.onSelect();
    }

    const event = {
      target: {
        value: option.value,
        name: 'site_id'
      }
    };

    onChange(event);
  };

  const urls = _.map(sites, (site) => ({
    label: site.url,
    value: `${site.id}`
  })).concat({
    label: <div>Add New</div>,
    value: 'new',
    onSelect: () => setSiteModalOpen(true)
  });

  const siteId = newApplicationInstance.site_id || applicationInstance.site.id;
  const selectedUrl = _.find(urls, (opt) => opt.value === siteId.toString());

  const settingsInputs = [
    {
      labelText: 'Nickname',
      props: {
        name: 'nickname',
        type: 'text',
        id: 'nickname_input',
        value: newApplicationInstance.nickname || '',
        onChange,
      },
    },
    {
      labelText: 'Primary contact',
      props: {
        name: 'primary_contact',
        type: 'text',
        id: 'primary_contact_input',
        value: newApplicationInstance.primary_contact || '',
        onChange,
      },
    },
    {
      labelText: 'Date created',
      props: {
        name: 'date_created',
        type: 'text',
        id: 'date_div',
        value: moment(newApplicationInstance.created_at).format('MM/DD/YY'),
        disabled: true,
      },
    },
    {
      labelText: 'Canvas URL',
      type: 'select',
      options: urls,
      value: selectedUrl,
      name: 'site_id',
      placeholder: 'Select a Canvas Domain',
      onChange: (option) => selectSite(option),
    },
    {
      labelText: 'LTI tool domain',
      props: {
        name: 'domain',
        type: 'text',
        id: 'domain_input',
        value: newApplicationInstance.domain,
        onChange,
      }
    },
    {
      labelText: 'Canvas Token',
      helperText: `Current Canvas Token: ${newApplicationInstance.canvas_token_preview}`,
      props: {
        name: 'canvas_token',
        type: 'text',
        id: 'canvas_token_input',
        placeholder: newApplicationInstance.canvas_token_preview ? 'Token Set!' : '',
        value: newApplicationInstance.canvas_token || '',
        onChange,
      }
    },
    {
      labelText: 'Language',
      type: 'select',
      options: languages,
      value:selectedLanguage,
      name: 'language',
      placeholder: currentLanguage,
      onChange : (option) => changeLanguage(option),
    },
    {
      labelText: 'Enable Rollbar',
      className: 'c-checkbox',
      props: {
        name: 'rollbar_enabled',
        type: 'checkbox',
        id: 'rollbar_enabled_input',
        value: 'true',
        checked: newApplicationInstance.rollbar_enabled,
        onChange,
      }
    },
    {
      labelText: 'Use Scoped Developer Key',
      className: 'c-checkbox',
      props: {
        name: 'use_scoped_developer_key',
        type: 'checkbox',
        id: 'use_scoped_developer_key_input',
        value: 'true',
        checked: newApplicationInstance.use_scoped_developer_key,
        onChange,
      }
    },
    {
      labelText: 'Anonymous (Don\'t store username and email during LTI launch)',
      className: 'c-checkbox',
      props: {
        name: 'anonymous',
        type: 'checkbox',
        id: 'anonymous',
        value: 'true',
        checked: newApplicationInstance.anonymous,
        onChange,
      }
    },
  ];

  const ltiInputs = [
    {
      labelText: 'LTI key',
      props: {
        name: 'lti_key',
        type: 'text',
        id: 'lti_key_input',
        disabled: true,
        value: newApplicationInstance.lti_key,
        onChange,
      }
    },
    {
      labelText: 'LTI Secret',
      props: {
        name: 'lti_secret',
        type: 'text',
        id: 'lti_secret_input',
        value: newApplicationInstance.lti_secret,
        onChange,
      }
    },

  ];

  return (
    <div className="aj-columns">
      <div className="aj-col-flex">
        <SettingsInputs title="General Settings" inputs={settingsInputs} />
      </div>
      <div className="aj-col-flex">
        <SettingsInputs title="LTI Key and Secret" inputs={ltiInputs} />
      </div>
      <SiteModal
        isOpen={siteModalOpen}
        closeModal={() => setSiteModalOpen(false)}
      />
    </div>
  );
}

export default connect(select, ApplicationInstanceActions)(GeneralSettings);


GeneralSettings.propTypes = {
  loading: PropTypes.bool,
  loaded: PropTypes.bool,
  sites: PropTypes.shape({}).isRequired,
  applicationInstances: PropTypes.array,
  getApplicationInstance: PropTypes.func,
  updateNewInstance: PropTypes.func,
  params: PropTypes.shape({
    applicationId: PropTypes.string.isRequired,
    applicationInstanceId: PropTypes.string.isRequired,
  }).isRequired,
  location: PropTypes.shape({
    state: PropTypes.shape({
      setNewInstance: PropTypes.func,
    })
  }),
  languagesSupported: PropTypes.array,
};
