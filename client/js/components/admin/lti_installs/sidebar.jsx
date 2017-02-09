import React from 'react';

export default function Sidebar() {
  return (
    <div className="o-left">
      <div className="c-tool">
        <a href=""><i className="i-settings" /></a>
        <h4 className="c-tool__subtitle">LTI Tool</h4>
        <h3 className="c-tool__title">Attendance</h3>
        <h4 className="c-tool__instance">Air University</h4>
      </div>

      <div className="c-filters">
        <h4 className="c-accounts">Accounts</h4>
        <ul className="c-filter-list">
          <li className="c-filter__item is-active"><a href=""><span><i className="i-dropdown" />Air University</span></a>
            <ul className="c-filter__dropdown">
              <li className="c-filter__item"><a href=""><span><i className="i-dropdown" />Fly</span></a></li>
              <li className="c-filter__item"><a href=""><span><i className="i-dropdown" />Ground</span></a></li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  );
}

Sidebar.propTypes = {
  accounts: React.PropTypes.arrayOf(React.PropTypes.shape({

  })).isRequired
};
