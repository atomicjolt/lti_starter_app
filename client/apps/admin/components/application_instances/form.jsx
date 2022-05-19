import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import ReactSelect from 'react-select';
import Input from '../common/input';
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

export default function Form(props) {
  const {
    applicationInstance,
    onChange,
    nickname,
    sites,
    site_id,
    languagesSupported,
    configParseError,
    primary_contact,
    domain,
    isUpdate,
    newSite,
    ltiConfigParseError,
    lti_key,
    lti_secret,
    canvas_token_preview,
    canvas_token,
    anonymous,
    rollbar_enabled,
    use_scoped_developer_key,
    config,
    save,
    closeModal,
    lti_config,
  } = props;

  const [currentLanguage, setCurrentLanguage] = useState(applicationInstance ? applicationInstance.language : 'english');

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

  const selectLanguage = (option) => {
    setCurrentLanguage(option.label);

    const event = {
      target: {
        value: option.label,
        name: 'language'
      }
    };

    onChange(event);
  };

  const options = _.map(sites, site => ({
    label: site.url,
    value: `${site.id}`
  })).concat({
    label: <div>Add New</div>,
    value: 'new',
    onSelect: () => newSite()
  });

  const selectedOption = _.find(options, opt => opt.value === site_id);

  const languages = _.map(languagesSupported, (label, value) => ({
    label,
    value,
  }));

  const selectedLanguage = _.find(languages, lang => lang.label === currentLanguage);

  let erroneousConfigWarning = null;
  if (configParseError) {
    erroneousConfigWarning = (
      <Warning text={configParseError} />
    );
  }

  let erroneousLtiConfigWarning = null;
  if (ltiConfigParseError) {
    erroneousLtiConfigWarning = (
      <Warning text={ltiConfigParseError} />
    );
  }

  return (
    <form>
      <div className="o-grid o-grid__modal-top">
        <div className="o-grid__item u-half">
          <Input
            className="c-input"
            labelText="Nickname"
            inputProps={{
              id: 'nickname_input',
              name: 'nickname',
              type: 'text',
              value: nickname,
              onChange
            }}
          />
        </div>
        <div className="o-grid__item u-half">
          <Input
            className="c-input"
            labelText="Primary contact"
            inputProps={{
              id: 'primary_contact_input',
              name: 'primary_contact',
              type: 'text',
              value: primary_contact,
              onChange
            }}
          />
        </div>
        <div className="o-grid__item u-half">
          <div className="c-input">
            <span>Canvas Url</span>
            <ReactSelect
              options={options}
              value={selectedOption}
              name="site_id"
              placeholder="Select a Canvas Domain"
              onChange={option => selectSite(option)}
              isClearable={false}
            />
          </div>
        </div>
        <div className="o-grid__item u-half">
          <Input
            className="c-input"
            labelText="LTI Tool Domain"
            inputProps={{
              id: 'domain_input',
              name: 'domain',
              type: 'text',
              value: domain,
              onChange
            }}
          />
        </div>
        <div className="o-grid__item u-half">
          <Input
            className="c-input"
            labelText="LTI Key"
            inputProps={{
              id: 'lti_key_input',
              name: 'lti_key',
              type: 'text',
              disabled: isUpdate,
              value: lti_key,
              onChange
            }}
          />
        </div>
        <div className="o-grid__item u-half">
          <Input
            className="c-input"
            labelText="LTI Secret"
            inputProps={{
              id: 'lti_secret_input',
              name: 'lti_secret',
              type: 'text',
              value: lti_secret,
              onChange
            }}
          />
        </div>
        <div className="o-grid__item u-half">
          <Input
            className="c-input"
            labelText="Canvas Token"
            helperText={`Current Canvas Token: ${canvas_token_preview}`}
            inputProps={{
              id: 'canvas_token_input',
              name: 'canvas_token',
              type: 'text',
              placeholder: canvas_token_preview ? 'Token Set!' : '',
              value: canvas_token || '',
              onChange
            }}
          />
        </div>
        <div className="o-grid__item u-full">
          <Input
            className="c-checkbox"
            labelText="Anonymous"
            helperText="Indicates whether or not user name and email is stored during LTI launch"
            inputProps={{
              id: 'anonymous_input',
              name: 'anonymous',
              type: 'checkbox',
              value: 'true',
              checked: anonymous,
              onChange
            }}
          />
        </div>
        <div className="o-grid__item u-full">
          <Input
            className="c-checkbox"
            labelText="Rollbar Enabled"
            helperText="Indicates whether or not rollbar is enabled for this app instance"
            inputProps={{
              id: 'rollbar_enabled_input',
              name: 'rollbar_enabled',
              type: 'checkbox',
              value: 'true',
              checked: rollbar_enabled,
              onChange
            }}
          />
        </div>
        <div className="o-grid__item u-full">
          <Input
            helperText="Restricts the Canvas tokens generated during oauth to the minimum necessary for this application. This should only be used if the oauth key and secret are populated above and are for a scoped developer key."
            className="c-checkbox"
            labelText="Use Scoped Developer Key"
            inputProps={{
              id: 'use_scoped_developer_key_input',
              name: 'use_scoped_developer_key',
              type: 'checkbox',
              value: 'true',
              checked: use_scoped_developer_key,
              onChange
            }}
          />
        </div>
        <div className="o-grid__item u-half">
          <div className="c-input c-input--container">
            <span>Language</span>
            <ReactSelect
              options={languages}
              value={selectedLanguage}
              name="language"
              placeholder={currentLanguage}
              onChange={option => selectLanguage(option)}
              isClearable={false}
            />
          </div>
        </div>
        <div className="o-grid__item u-full">
          <Textarea
            className="c-input"
            labelText="Custom Application Instance Configuration"
            textareaProps={{
              id: 'application_instance_config',
              name: 'config',
              placeholder: 'ex: { "foo": "bar" }',
              rows: 3,
              value: prettyJSON(config || '{}'),
              onChange,
            }}
            warning={erroneousConfigWarning}
          />
        </div>
        <div className="o-grid__item u-full">
          <Textarea
            className="c-input"
            labelText="LTI Configuration"
            textareaProps={{
              id: 'application_instance_lti_config',
              name: 'lti_config',
              rows: 8,
              value: prettyJSON(lti_config || '{}'),
              onChange,
            }}
            warning={erroneousLtiConfigWarning}
          />
        </div>
      </div>
      <button
        type="button"
        onClick={() => save()}
        className="c-btn c-btn--yellow"
      >
        Save
      </button>

      <button
        type="button"
        className="c-btn c-btn--gray--large u-m-right"
        onClick={() => closeModal()}
      >
        Cancel
      </button>
    </form>
  );

}

Form.propTypes = {
  onChange: PropTypes.func.isRequired,
  closeModal: PropTypes.func.isRequired,
  save: PropTypes.func.isRequired,
  newSite: PropTypes.func.isRequired,
  site_id: PropTypes.string,
  sites: PropTypes.shape({}),
  isUpdate: PropTypes.bool,
  config: PropTypes.string,
  configParseError: PropTypes.string,
  domain: PropTypes.string,
  lti_config: PropTypes.string,
  lti_key: PropTypes.string,
  lti_secret: PropTypes.string,
  ltiConfigParseError: PropTypes.string,
  canvas_token_preview: PropTypes.string,
  anonymous: PropTypes.bool,
  rollbar_enabled: PropTypes.bool,
  use_scoped_developer_key: PropTypes.bool,
  applicationInstance: PropTypes.shape({
    language: PropTypes.string,
  }),
  languagesSupported: PropTypes.array,
  nickname: PropTypes.string,
  primary_contact: PropTypes.string,
};
