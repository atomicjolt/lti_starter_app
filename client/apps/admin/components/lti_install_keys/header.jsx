import React from 'react';
import PropTypes from 'prop-types';

export default function Header(props) {
  const { application, newLtiInstallKey } = props;
  return (
    <div className="c-info">
      <div className="c-title">
        <h1>
          {application ? application.name : 'App Name'}
          {' '}
          Lti Install Keys
        </h1>
      </div>
      <button
        type="button"
        className="c-btn c-btn--yellow"
        onClick={newLtiInstallKey}
      >
        New Lti Install Key
      </button>
    </div>
  );
}

Header.propTypes = {
  newLtiInstallKey: PropTypes.func.isRequired,
  application: PropTypes.shape({
    name: PropTypes.string,
  }),
};
