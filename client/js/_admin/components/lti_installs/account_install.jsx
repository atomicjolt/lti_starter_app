import React from 'react';

export default function AccountInstall(props) {
  return (
    <div className="c-info">
      <div className="c-title">
        <h1>{props.accountInstalls}</h1>
        <h3>{props.accountName}</h3>
      </div>
      <button className="c-btn c-btn--yellow">Install at Account Level</button>
    </div>
  );
}

AccountInstall.propTypes = {
  accountName: React.PropTypes.string.isRequired,
  accountInstalls: React.PropTypes.number,
};
