import React from 'react';
import SubAccounts from './subAccounts';

export default function Sidebar(props) {
  const schoolName = props.accounts[0] ? props.accounts[0].name : 'Loading...';
  return (
    <div className="o-left">
      <div className="c-tool">
        <a href=""><i className="i-settings" /></a>
        <h4 className="c-tool__subtitle">LTI Tool</h4>
        <h3 className="c-tool__title">{props.application ? props.application.name : 'n/a'}</h3>
        <h4 className="c-tool__instance">{schoolName}</h4>
      </div>

      <div className="c-filters">
        <h4 className="c-accounts">Accounts</h4>
        <ul className="c-filter-list">
          <li className={props.activeAccount ? 'c-filter__item' : 'c-filter__item is-active'}>
            <a href="">
              <span>
                <i className="i-dropdown" />
                {schoolName}
              </span>
            </a>
            <SubAccounts
              // Need to only show if clicked.
              accounts={props.accounts[1]}
              canvasRequest={props.canvasRequest}
              setAccount={props.setAccount}
              activeAccount={props.activeAccount}
            />
          </li>
        </ul>
      </div>
    </div>
  );
}

Sidebar.propTypes = {
  application: React.PropTypes.arrayOf(React.PropTypes.shape({
    name: React.PropTypes.string.isRequired,
  })).isRequired,
  accounts: React.PropTypes.arrayOf(React.PropTypes.shape({
    name: React.PropTypes.string.isRequired,
  })).isRequired,
  canvasRequest: React.PropTypes.func.isRequired,
  setAccount: React.PropTypes.func.isRequired,
  activeAccount: React.PropTypes.shape({}),
};
