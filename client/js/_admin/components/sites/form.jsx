import React from 'react';
import Input from '../common/input';

export const FIELDS = {
  oauth_key: 'Canvas Developer ID',
  oauth_secret: 'Canvas Developer Key',
  url: 'Canvas Domain',
};

const SiteForm = (props) => {
  const {
    isUpdate,
    oauth_key,
    oauth_secret,
    url,
    onChange,
    setupSite,
    closeModal,
  } = props;
  const buttonVerb = isUpdate ? 'Update' : 'Create';

  const inputTemplate = (fieldLabel, field, value) => {
    const inputProps = {
      id: `site_${field}`,
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
        {inputTemplate(FIELDS.url, 'url', url)}
        {inputTemplate(FIELDS.oauth_key, 'oauth_key', oauth_key)}
        {inputTemplate(FIELDS.oauth_secret, 'oauth_secret', oauth_secret)}
      </div>


      <button
        type="button"
        className="c-btn c-btn--yellow"
        onClick={setupSite}
      >
        {buttonVerb} Domain
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
};

SiteForm.propTypes = {
  setupSite: React.PropTypes.func.isRequired,
  closeModal: React.PropTypes.func.isRequired,
  onChange: React.PropTypes.func.isRequired,
  isUpdate: React.PropTypes.bool.isRequired,
  oauth_key: React.PropTypes.string,
  oauth_secret: React.PropTypes.string,
  url: React.PropTypes.string,
};

export default SiteForm;
