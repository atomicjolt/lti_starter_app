import React from 'react';
import PropTypes from 'prop-types';

export default function Textarea(props) {
  return (
    <label htmlFor={props.textareaProps.id} className={props.className}>
      <span>{props.labelText}</span>
      <textarea
        id={props.textareaProps.id}
        value={props.textareaProps.value}
        disabled={props.textareaProps.disabled}
        name={props.textareaProps.name}
        placeholder={props.textareaProps.placeholder}
        maxLength={props.textareaProps.maxLength}
        minLength={props.textareaProps.minLength}
        cols={props.textareaProps.cols}
        rows={props.textareaProps.rows}
        onChange={props.textareaProps.onChange}
        readOnly={props.textareaProps.readOnly}
      />
      {props.warning}
    </label>
  );
}

Textarea.propTypes = {
  labelText: PropTypes.string,
  textareaProps: PropTypes.shape({
    id: PropTypes.string,
    value: PropTypes.string,
    disabled: PropTypes.bool,
    name: PropTypes.string,
    placeholder: PropTypes.string,
    maxLength: PropTypes.number,
    minLength: PropTypes.number,
    cols: PropTypes.number,
    rows: PropTypes.number,
    onChange: PropTypes.func,
    readOnly: PropTypes.bool,
  }),
  warning: PropTypes.shape({}),
  className: PropTypes.string,
};
