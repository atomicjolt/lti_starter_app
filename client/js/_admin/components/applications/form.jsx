import React       from 'react';

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
  onChange       : React.PropTypes.func.isRequired,
  closeModal     : React.PropTypes.func.isRequired,
  description    : React.PropTypes.string
};
