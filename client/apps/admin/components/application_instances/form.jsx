import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import ReactSelect from 'react-select';
import Input from '../common/input';
import Textarea from '../common/textarea';
import Warning from '../common/warning';

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
    lti_key: PropTypes.string,
    lti_secret: PropTypes.string,
    ltiConfigParseError: PropTypes.string,
    canvas_token_preview: PropTypes.string,
    anonymous: PropTypes.bool,
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

  render() {
    const { onChange } = this.props;
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
          <div className="o-grid__item u-half">
            <Input
              className="c-input"
              labelText="LTI Key"
              inputProps={{
                id: 'lti_key_input',
                name: 'lti_key',
                type: 'text',
                disabled: this.props.isUpdate,
                value: this.props.lti_key,
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
                value: this.props.lti_secret,
                onChange
              }}
            />
          </div>
          <div className="o-grid__item u-half">
            <Input
              className="c-input"
              labelText="Canvas Token"
              helperText={`Current Canvas Token: ${this.props.canvas_token_preview}`}
              inputProps={{
                id: 'canvas_token_input',
                name: 'canvas_token',
                type: 'text',
                placeholder: this.props.canvas_token_preview ? 'Token Set!' : '',
                value: '',
                onChange
              }}
            />
          </div>
          <div className="o-grid__item u-full">
            <Input
              className="c-checkbox"
              labelText="Anonymous"
              helperText="indicates whether or not user name and email is stored during LTI launch"
              inputProps={{
                id: 'anonymous_input',
                name: 'anonymous',
                type: 'checkbox',
                value: 'true',
                checked: this.props.anonymous,
                onChange
              }}
            />
          </div>
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
