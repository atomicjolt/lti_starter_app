import React from 'react';
import PropTypes from 'prop-types';
// import Menu from '../common/menu';

export default function Header(props) {
  const { application, newApplicationInstance } = props;
  return (
    <div className="c-info">
      <div className="c-title">
        <h1>{application ? application.name : 'App Name'} Instances</h1>
      </div>
      <button className="c-btn c-btn--border" onClick={newApplicationInstance}>
        New App Instance
      </button>

      {/* Nothing to put in menu yet waiting on more designs*/}

      {/* <Menu>
        {(onClick, activeClass, isOpen, menuRef) => (
          <div className={`aj-menu-contain aj-menu-space ${activeClass}`} ref={menuRef}>
            <button
              className="aj-icon-btn"
              aria-label="Analytics Options"
              aria-haspopup="true"
              aria-expanded={isOpen ? 'true' : 'false'}
              onClick={onClick}
              type="button"
            >
              <i className="material-icons" aria-hidden="true">more_vert</i>
            </button>
            <ul className="aj-menu" role="menu">
              <li>
                <button
                  onClick={() => {}}
                >
                  <i className="material-icons">settings</i>
                  Settings ???
                </button>
              </li>

            </ul>
          </div>
        )}
      </Menu> */}
    </div>
  );
}

Header.propTypes = {
  newApplicationInstance: PropTypes.func.isRequired,
  application: PropTypes.shape({
    name: PropTypes.string,
  }),
};
