import React from 'react';
import PropTypes from 'prop-types';
import ReactSelect from 'react-select';
import Flatpickr from 'react-flatpickr';
import _ from 'lodash';
import Input from '../common/input';
import Textarea from '../common/textarea';

export default function SettingsInputs(props) {

  const {
    title,
    inputs,
    inputClass,
    textareaClass,
    bodyClass
  } = props;


  return (
    <>
      <div className="aj-settings-title">
        {title}
      </div>
      <div className={`aj-item-padding ${bodyClass}`}>
        {_.map(inputs, (input, index) => {
          if (input.type === 'select') {
            return (
              <div key={index} className={`c-input c-input--container ${inputClass}`}>
                <span>{input.labelText}</span>
                <ReactSelect
                  className={`aj-react-select ${input.className}`}
                  options={input.options}
                  value={input.value}
                  name={input.name}
                  placeholder={input.placeholder}
                  onChange={input.onChange}
                  isClearable={false}
                />
              </div>
            );
          }
          if (input.type === 'textarea') {
            return (
              <Textarea
                key={index}
                className={`c-input aj-input--border ${input.className} ${textareaClass}`}
                labelText={input.labelText}
                textareaProps={input.props}
              />
            );
          }
          if (input.type === 'datepicker') {
            return (
              <div key={index} className={`c-input c-input--container ${inputClass}`}>
                <span>{input.labelText}</span>
                <Flatpickr
                  options={{
                    minDate: input.minDate,
                    maxDate: input.maxDate,
                  }}
                  value={input.value}
                  id={input.id}
                  onChange={(value) => input.onChange(value, input.name)}
                />
              </div>
            );
          }
          return (
            <Input
              key={index}
              className={input.className || `c-input aj-input--border ${inputClass}`}
              labelText={input.labelText}
              inputProps={input.props}
              helperText={input.helperText}
            />
          );
        })}
      </div>
    </>
  );
}

SettingsInputs.propTypes = {
  title: PropTypes.string,
  inputs: PropTypes.array,
  inputClass: PropTypes.string,
  textareaClass: PropTypes.string,
  bodyClass: PropTypes.string,
};
