import React           from 'react';

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
  newApplicationInstance: React.PropTypes.func.isRequired,
  application: React.PropTypes.shape({
    name: React.PropTypes.string,
  }),
};
