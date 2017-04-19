import React from 'react';
import PropTypes from 'prop-types';

export default function Header(props) {
  const { application, newApplicationInstance } = props;
  return (
    <div className="c-info">
      <div className="c-title">
        <h1>{application ? application.name : 'App Name'} Instances</h1>
      </div>
      <button className="c-btn c-btn--yellow" onClick={newApplicationInstance}>
        New Application Instance
      </button>
    </div>
  );
}

Header.propTypes = {
  newApplicationInstance: PropTypes.func.isRequired,
  application: PropTypes.shape({
    name: PropTypes.string,
  }),
};
