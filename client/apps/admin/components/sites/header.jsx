import React from 'react';

const Header = (props) => {
  const {
    newSite
  } = props;

  return (
    <div className="c-info">
      <div className="c-title">
        <h1>Sites</h1>
      </div>
      <button className="c-btn c-btn--yellow" onClick={newSite}>
        New Site
      </button>
    </div>
  );
};

Header.propTypes = {
  newSite: React.PropTypes.func.isRequired,
};

export default Header;
