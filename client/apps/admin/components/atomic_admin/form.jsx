import React from 'react';
import PropTypes from 'prop-types';
import Input from '../common/input';
import _ from 'lodash';


export default function Form(props) {
  const {
    fields,
    formType,
    isUpdate,
    url,
    onChange,
    setupSite,
    closeModal,
    selectedElement,
    saveElement
  } = props;


  const inputTemplate = (fieldLabel, field, value) => {
    const inputProps = {
      id: `${formType}_${field}`,
      name: field,
      type: 'text',
      value: value || '',
      onChange,
    };
    return (
      <div key={field} className="o-grid__item u-full">
        <Input
          className="c-input"
          labelText={fieldLabel}
          inputProps={inputProps}
        />
      </div>
    );
  };

  return (
    <form>
      <div className="o-grid o-grid__modal-top">
        {
          _.map(fields, (f) => inputTemplate(f.label, f.field, props.selectedElement[f.prop]))
        }
      </div>
      <button
        type="button"
        className="c-btn c-btn--yellow"
        onClick={() => {saveElement(); closeModal()}}
      >
        Save
      </button>
      <button
        type="button"
        className="c-btn c-btn--gray--large u-m-right"
        onClick={closeModal}
      >
        Cancel
      </button>
    </form>
  );
}

// SiteForm.propTypes = {
//   setupSite: PropTypes.func.isRequired,
//   closeModal: PropTypes.func.isRequired,
//   onChange: PropTypes.func.isRequired,
//   isUpdate: PropTypes.bool.isRequired,
//   oauth_key: PropTypes.string,
//   oauth_secret: PropTypes.string,
//   url: PropTypes.string,
// };
