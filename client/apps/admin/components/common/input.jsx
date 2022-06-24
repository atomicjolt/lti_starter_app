import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';

export default function Input(props) {
  const {
    labelText,
    inputProps,
    className,
    helperText: helperTextProp
  } = props;

  let before;
  let after;

  if (_.includes(['radio', 'checkbox'], inputProps.type)) {
    after = <span>{labelText}</span>;
  } else {
    before = <span>{labelText}</span>;
  }

  let helperText;
  if (helperTextProp) {
    helperText = <div className="helper-text">{helperTextProp}</div>;
  }

  return (
    <div className="c-input--container">
      <label htmlFor={inputProps.id} className={className}>
        {before}
        <input
          id={inputProps.id}
          value={inputProps.value}
          checked={inputProps.checked}
          disabled={inputProps.disabled}
          name={inputProps.name}
          type={inputProps.type}
          onChange={inputProps.onChange}
        />
        {after}
      </label>
      {helperText}
    </div>
  );
}

Input.propTypes = {
  labelText: PropTypes.string,
  inputProps: PropTypes.shape({
    id: PropTypes.string,
    value: PropTypes.string,
    checked: PropTypes.bool,
    disabled: PropTypes.bool,
    name: PropTypes.string,
    type: PropTypes.string.isRequired,
    onChange: PropTypes.func,
  }),
  className: PropTypes.string,
  helperText: PropTypes.string,
};
