import React from 'react';
import PropTypes from 'prop-types';
import Textarea from '../common/textarea';
import Warning from '../common/warning';

export default function Form(props) {
  let erroneousConfigWarning = null;
  if (props.configParseError) {
    erroneousConfigWarning = (
      <Warning text={props.configParseError} />
    );
  }

  return (
    <form>
      <div className="o-grid o-grid__modal-top">
        <div className="o-grid__item u-half">
          <label htmlFor="description" className="c-input">
            <span>Description</span>
            <input
              id="description"
              name="description"
              type="text"
              value={props.description || ''}
              onChange={props.onChange}
            />
          </label>
        </div>
        <div className="o-grid__item u-half">
          <label htmlFor="permissions" className="c-input">
            <span>Canvas API Permissions</span>
            {props.canvasApiPermissions}
          </label>
        </div>
        <div className="o-grid__item u-full">
          <Textarea
            className="c-input"
            labelText="Default Config"
            textareaProps={{
              id: 'application_default_config',
              name: 'default_config',
              placeholder: 'ex: { "foo": "bar" }',
              rows: 3,
              value: props.defaultConfig || '',
              onChange: props.onChange,
            }}
            warning={erroneousConfigWarning}
          />
        </div>
      </div>
      <button
        type="button"
        onClick={() => props.save()}
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

Form.propTypes = {
  onChange: PropTypes.func.isRequired,
  closeModal: PropTypes.func.isRequired,
  description: PropTypes.string,
  defaultConfig: PropTypes.string,
  configParseError: PropTypes.string,
  canvasApiPermissions: PropTypes.string,
};
