import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';

export default function SettingsInputs(props) {
  return (
    <div>
      {
        _.map(props.settings, (value, key) => (
          <input key={key} type="hidden" value={value || ''} name={key} />
        ))
      }
    </div>
  );
}

SettingsInputs.propTypes = {
  settings: PropTypes.shape({
    lti_key: PropTypes.string
  }).isRequired
};
