import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import ReactSelect from 'react-select';
import Input from '../common/input';
import Textarea from '../common/textarea';
import Warning from '../common/warning';
import {
  canvasDevKeysUrl,
  oauthCallbackUrl } from '../../libs/sites';

export const TEXT_FIELDS = {
  lti_key: 'LTI Key',
  lti_secret: 'LTI Secret',
  canvas_token: 'Canvas Token',
};

export default class Form extends React.Component {

  static propTypes = {
    onChange: PropTypes.func.isRequired,
    closeModal: PropTypes.func.isRequired,
    save: PropTypes.func.isRequired,
    newSite: PropTypes.func.isRequired,
    site_id: PropTypes.string,
    sites: PropTypes.shape({}),
    isUpdate: PropTypes.bool,
    config: PropTypes.string,
    configParseError: PropTypes.string,
    lti_config: PropTypes.string,
    ltiConfigParseError: PropTypes.string,
    domain: PropTypes.string,
  };

  selectSite(option) {
    if (_.isFunction(option.onSelect)) {
      option.onSelect();
    }

    const event = {
      target: {
        value: option.value,
        name: 'site_id'
      }
    };

    this.props.onChange(event);
  }

  renderInput(outerClassName, className, type, altName, isUpdate, fieldLabel, field) {
    const id = `instance_${field}`;
    const name = altName || field;
    const inputProps = {
      id,
      name,
      type,
      onChange: this.props.onChange
    };
    if (type === 'radio') {
      inputProps.checked = this.props[altName] === field;
      inputProps.value = field;
    } else {
      if (isUpdate && field === 'lti_key') {
        inputProps.disabled = true;
      }
      inputProps.value = this.props[field] || '';
    }
    return (
      <div key={field} className={outerClassName}>
        <Input
          className={className}
          labelText={fieldLabel}
          inputProps={inputProps}
        />
      </div>
    );
  }

  render() {
    const options = _.map(this.props.sites, site => ({
      label: site.url,
      value: `${site.id}`
    })).concat({
      label: <div>Add New</div>,
      value: 'new',
      onSelect: () => this.props.newSite()
    });

    let erroneousConfigWarning = null;
    if (this.props.configParseError) {
      erroneousConfigWarning = (
        <Warning text={this.props.configParseError} />
      );
    }

    let erroneousLtiConfigWarning = null;
    if (this.props.ltiConfigParseError) {
      erroneousLtiConfigWarning = (
        <Warning text={this.props.ltiConfigParseError} />
      );
    }

    return (
      <form>
        <div className="o-grid o-grid__modal-top">
          <div className="o-grid__item u-half">
            <div className="c-input">
              <span>Domain</span>
              <ReactSelect
                options={options}
                value={this.props.site_id}
                name="site_id"
                placeholder="Select a Domain"
                onChange={option => this.selectSite(option)}
                searchable={false}
                arrowRenderer={() => null}
                clearable={false}
              />
            </div>
          </div>
          {
            _.map(TEXT_FIELDS, (...args) =>
              this.renderInput('o-grid__item u-half', 'c-input', 'text', undefined, this.props.isUpdate, ...args)
            )
          }
          <div className="o-grid__item u-full">
            <Textarea
              className="c-input"
              labelText="Config"
              textareaProps={{
                id: 'application_instance_config',
                name: 'config',
                placeholder: 'ex: { "foo": "bar" }',
                rows: 3,
                value: this.props.config || '',
                onChange: this.props.onChange,
              }}
              warning={erroneousConfigWarning}
            />
          </div>
          <div className="o-grid__item u-full">
            <h3 className="c-modal__subtitle">LTI Configuration</h3>
            <Textarea
              className="c-input"
              labelText="Config"
              textareaProps={{
                id: 'application_instance_lti_config',
                name: 'lti_config',
                rows: 3,
                value: this.props.lti_config || '',
                onChange: this.props.onChange,
              }}
              warning={erroneousLtiConfigWarning}
            />
          </div>
        </div>
        <button
          type="button"
          onClick={() => this.props.save()}
          className="c-btn c-btn--yellow"
        >
          Save
        </button>

        <button
          type="button"
          className="c-btn c-btn--gray--large u-m-right"
          onClick={() => this.props.closeModal()}
        >
          Cancel
        </button>
      </form>
    );
  }

}
