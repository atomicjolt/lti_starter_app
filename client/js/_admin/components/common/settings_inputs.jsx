import React from 'react';
import _     from 'lodash';

export default function SettingsInputs(props) {
  return (
    <div>
      <input
        type="hidden"
        name="oauth_consumer_key"
        value={props.settings.lti_key}
      />
      {
        _.map(props.settings, (value, key) => (
          <input key={key} type="hidden" value={value} name={key} />
        ))
      }
    </div>
  );
}

SettingsInputs.propTypes = {
  settings: React.PropTypes.shape({
    lti_key: React.PropTypes.string
  }).isRequired
};
