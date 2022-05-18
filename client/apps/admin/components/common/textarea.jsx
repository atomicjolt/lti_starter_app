import React from 'react';
import PropTypes from 'prop-types';

export default function Textarea(props) {
  const {
    textareaProps,
    className,
    warning,
    labelText
  } = props;

  return (
    <label htmlFor={textareaProps.id} className={className}>
      <span>{labelText}</span>
      <textarea
        id={textareaProps.id}
        value={textareaProps.value}
        disabled={textareaProps.disabled}
        name={textareaProps.name}
        placeholder={textareaProps.placeholder}
        maxLength={textareaProps.maxLength}
        minLength={textareaProps.minLength}
        cols={textareaProps.cols}
        rows={textareaProps.rows}
        onChange={textareaProps.onChange}
        readOnly={textareaProps.readOnly}
      />
      {warning}
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
