import React from 'react';
import _     from 'lodash';

const FIELDS = {
  oauth_key    : 'Canvas Developer ID',
  oauth_secret : 'Canvas Developer Key',
  url          : 'Canvas Domain',
};

export default function NewSiteForm(props) {
  return (
    <form>
      <div className="o-grid o-grid__modal-top">
        {
          _.map(FIELDS, (fieldLabel, field) => (
            <div key={field} className="o-grid__item u-half">
              <label htmlFor={`new_site_${field}`} className="c-input">
                <span>{fieldLabel}</span>
                <input
                  value={props[field]}
                  id={`new_site_${field}`}
                  name={field}
                  type="text"
                  onChange={e => props.onChange(e)}
                />
              </label>
            </div>
          ))
        }
      </div>

      <button
        type="button"
        className="c-btn c-btn--yellow"
        onClick={() => props.setupSite()}
      >
        Create Domain
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

NewSiteForm.propTypes = {
  // setupSite  : React.PropTypes.func.isRequired,
  closeModal : React.PropTypes.func.isRequired,
};
