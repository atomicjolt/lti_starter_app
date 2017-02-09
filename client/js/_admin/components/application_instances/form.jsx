import React       from 'react';
import _           from 'lodash';
import ReactSelect from 'react-select';

const TEXT_FIELDS = {
  lti_key      : 'LTI Key',
  lti_secret   : 'LTI Secret',
  canvas_token : 'Canvas Token',
};

const TYPE_RADIOS = {
  basic              : 'General',
  account_navigation : 'Account Navigation',
  course_navigation  : 'Course Navigation',
};

export default function newApplicationInstanceForm(props) {
  function selectSite(option) {
    if (_.isFunction(option.onSelect)) {
      option.onSelect();
    }

    const event = {
      target: {
        value: option.value,
        name: 'site_id'
      }
    };

    props.onChange(event);
  }

  const options = _.map(props.sites, site => ({
    label: site.url,
    value: `${site.id}`
  })).concat({
    label: <div>Add New</div>,
    value: 'new',
    onSelect: () => props.newSite()
  });

  return (
    <form>
      <div className="o-grid o-grid__modal-top">
        <div className="o-grid__item u-half">
          <div className="c-input">
            <span>Domain</span>
            <ReactSelect
              options={options}
              value={props.site_id}
              name="site_id"
              placeholder="Select a Domain"
              onChange={option => selectSite(option)}
              searchable={false}
              arrowRenderer={() => null}
              clearable={false}
            />
          </div>
        </div>
        {
          _.map(TEXT_FIELDS, (fieldLabel, field) => (
            <div key={field} className="o-grid__item u-half">
              <label htmlFor={`instance_${field}`} className="c-input">
                <span>{fieldLabel}</span>
                <input
                  id={`instance_${field}`}
                  name={field}
                  type="text"
                  value={props[field] || ''}
                  onChange={props.onChange}
                />
              </label>
            </div>
          ))
        }
      </div>
      <h3 className="c-modal__subtitle">Install Settings</h3>
      <div className="o-grid o-grid__bottom">
        {
          _.map(TYPE_RADIOS, (typeLabel, typeValue) => (
            <div key={typeValue} className="o-grid__item u-third">
              <label
                htmlFor={`lti_type_${typeValue}`}
                className="c-checkbox"
              >
                {typeLabel}
                <input
                  id={`lti_type_${typeValue}`}
                  value={`${typeValue}`}
                  checked={`${props.lti_type}` === `${typeValue}`}
                  name="lti_type"
                  type="radio"
                  onChange={props.onChange}
                />
              </label>
            </div>
          ))
        }
      </div>
      <button
        type="button"
        onClick={() => props.createInstance()}
        className="c-btn c-btn--yellow"
      >
        Save
      </button>

      <button
        type="button"
        className="c-btn c-btn--gray--large u-m-right"
        onClick={() => props.closeModal()}
      >
        Cancel
      </button>
    </form>
  );
}

newApplicationInstanceForm.propTypes = {
  // onChange       : React.PropTypes.func.isRequired,
  closeModal     : React.PropTypes.func.isRequired,
  // createInstance : React.PropTypes.func.isRequired,
  // newSite        : React.PropTypes.func.isRequired,
  site_id        : React.PropTypes.string,
  sites          : React.PropTypes.shape({})
};
