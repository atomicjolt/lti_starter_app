import React       from 'react';
import _           from 'lodash';
import ReactSelect from 'react-select';
import Input       from './input';

export const TEXT_FIELDS = {
  lti_key      : 'LTI Key',
  lti_secret   : 'LTI Secret',
  canvas_token : 'Canvas Token',
};

export const TYPE_RADIOS = {
  basic              : 'General',
  account_navigation : 'Account Navigation',
  course_navigation  : 'Course Navigation',
};

export default class Form extends React.Component {

  static propTypes = {
    onChange:       React.PropTypes.func.isRequired,
    closeModal:     React.PropTypes.func.isRequired,
    createInstance: React.PropTypes.func.isRequired,
    newSite:        React.PropTypes.func.isRequired,
    site_id:        React.PropTypes.string,
    sites:          React.PropTypes.shape({})
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

  renderInput(outerClassName, className, type, altName, fieldLabel, field) {
    const id = `instance_${field}`;
    const name = altName || field;
    const value = type === 'radio' ? field : this.props[field] || '';
    return (
      <div key={field} className={outerClassName}>
        <Input
          className={className}
          labelText={fieldLabel}
          inputProps={{
            id,
            name,
            type,
            value,
            onChange: this.props.onChange
          }}
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
              this.renderInput('o-grid__item u-half', 'c-input', 'text', undefined, ...args)
            )
          }
        </div>
        <h3 className="c-modal__subtitle">Install Settings</h3>
        <div className="o-grid o-grid__bottom">
          {
            _.map(TYPE_RADIOS, (...args) =>
              this.renderInput('o-grid__item u-third', 'c-checkbox', 'radio', 'lti_type', ...args)
            )
          }
        </div>
        <button
          type="button"
          onClick={() => this.props.createInstance()}
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
