import React from 'react';

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
      />
      {props.warning}
    </label>
  );
}

Textarea.propTypes = {
  labelText: React.PropTypes.string,
  textareaProps: React.PropTypes.shape({
    id: React.PropTypes.string,
    value: React.PropTypes.string,
    disabled: React.PropTypes.bool,
    name: React.PropTypes.string,
    placeholder: React.PropTypes.string,
    maxLength: React.PropTypes.number,
    minLength: React.PropTypes.number,
    cols: React.PropTypes.number,
    rows: React.PropTypes.number,
    onChange: React.PropTypes.func,
  }),
  warning: React.PropTypes.shape({}),
  className: React.PropTypes.string,
};
