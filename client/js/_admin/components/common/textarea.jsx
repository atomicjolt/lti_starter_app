import React       from 'react';

export default function Input(props) {
  return (
    <label htmlFor={props.inputProps.id} className={props.className}>
      <span>{props.labelText}</span>
      <textarea {...props.inputProps} />
    </label>
  );
}

Input.propTypes = {
  labelText: React.PropTypes.string,
  inputProps: React.PropTypes.shape({
    id: React.PropTypes.string,
    value: React.PropTypes.string,
    disabled: React.PropTypes.bool,
    name: React.PropTypes.string,
    placeholder: React.PropTypes.string,
    maxlength: React.PropTypes.number,
    minlength: React.PropTypes.number,
    cols: React.PropTypes.number,
    rows: React.PropTypes.number,
    onChange: React.PropTypes.func,
  }),
  className: React.PropTypes.string,
};
