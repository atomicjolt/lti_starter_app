import React from 'react';
import SubAccounts from './sub_accounts';

export default function Sidebar(props) {
  const schoolName = props.accounts[1] ? props.accounts[1].name : 'Loading...';
  const subAccounts = props.accounts[1] ? props.accounts[1].sub_accounts : [];

  return (
    <div className="o-left">
      <div className="c-tool">
        <a href=""><i className="i-settings" /></a>
        <h4 className="c-tool__subtitle">LTI Tool</h4>
        <h3 className="c-tool__title">{props.applicationInstance ? props.application.name : 'n/a'}</h3>
        <h4 className="c-tool__instance">{schoolName}</h4>
      </div>

      <div className="c-filters">
        <h4 className="c-accounts">Accounts</h4>
        <ul className="c-filter-list">
          <li className={'c-filter__item is-active'}>
            <button>
              <i className="i-dropdown" />
              {schoolName}
            </button>
            <SubAccounts
              // Need to only show if clicked.
              accounts={subAccounts}
              canvasRequest={props.canvasRequest}
              setAccountActive={props.setAccountActive}
              activeAccounts={props.activeAccounts}
            />
          </li>
        </ul>
      </div>
    </div>
  );
}

Sidebar.propTypes = {
  application: React.PropTypes.shape({
    name: React.PropTypes.string.isRequired,
  }),
  accounts: React.PropTypes.shape({}),
  canvasRequest: React.PropTypes.func.isRequired,
  setAccountActive: React.PropTypes.func.isRequired,
  activeAccounts: React.PropTypes.arrayOf(React.PropTypes.shape({})),
};
