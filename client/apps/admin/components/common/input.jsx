import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';

export default function Input(props) {

  let before;
  let after;

  if (_.includes(['radio', 'checkbox'], props.inputProps.type)) {
    after = <span>{props.labelText}</span>;
  } else {
    before = <span>{props.labelText}</span>;
  }

  return (
    <label htmlFor={props.inputProps.id} className={props.className}>
      {before}
      <input {...props.inputProps} />
      {after}
    </label>
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
};
