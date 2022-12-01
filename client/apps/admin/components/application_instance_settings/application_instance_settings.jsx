import React from 'react';
import PropTypes from 'prop-types';
import NavColumn from './nav_column';


export default function ApplicationInstanceSettings(props) {

  const {
    application,
    applicationInstance,
    tabComponent,
    location
  } = props;

  return (
    <div className="aj-settings-container">
      <NavColumn
        location={location}
        application={application}
        applicationInstance={applicationInstance}
      />
      <div className="display-page">
        {tabComponent}
      </div>
    </div>
  );
}

ApplicationInstanceSettings.propTypes = {
  application: PropTypes.shape({
    id: PropTypes.number,
    supported_languages: PropTypes.array,
  }),
  applicationInstance: PropTypes.shape({
    lti_key: PropTypes.string,
  }),
  tabComponent: PropTypes.element,
  location: PropTypes.shape({
    pathname: PropTypes.string,
  }),
};
