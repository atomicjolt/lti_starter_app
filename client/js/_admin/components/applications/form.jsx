import React       from 'react';
import Textarea from '../common/textarea';

export default function Form(props) {

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
          </label>
        </div>
        <div className="o-grid__item u-full">
          <Textarea
            className="c-input"
            labelText="Default Config"
            inputProps={{
              id: 'application_default_config',
              name: 'default_config',
              placeholder: 'ex: { "foo": "bar" }',
              rows: 3,
              value: props.default_config || '',
              onChange: props.onChange,
            }}
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
  onChange: React.PropTypes.func.isRequired,
  closeModal: React.PropTypes.func.isRequired,
  description: React.PropTypes.string,
  default_config: React.PropTypes.string,
};
