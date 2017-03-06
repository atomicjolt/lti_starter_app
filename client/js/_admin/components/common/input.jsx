import React       from 'react';
import _           from 'lodash';

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
  labelText: React.PropTypes.string,
  inputProps: React.PropTypes.shape({
    id: React.PropTypes.string,
    value: React.PropTypes.string,
    checked: React.PropTypes.bool,
    disabled: React.PropTypes.bool,
    name: React.PropTypes.string,
    type: React.PropTypes.string.isRequired,
    onChange: React.PropTypes.func,
  }),
  className: React.PropTypes.string,
};
