import React from 'react';

export default function SettingsInputs(props) {
  return (
    <div>
      <input
        type="hidden"
        name="oauth_consumer_key"
        value={props.settings.lti_key}
      />
      {
        _.map(props.settings, (value, key) => {
          return <input key={key} type="hidden" value={value} name={key} />;
        })
      }
    </div>
  );
}

SettingsInputs.propTypes = {
  settings: React.PropTypes.shape({}).isRequired
};
